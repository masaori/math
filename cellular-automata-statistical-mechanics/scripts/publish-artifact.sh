#!/usr/bin/env bash
# 構造化証明から論文 HTML を生成・公開し、公開 URL を Slack へ一度だけ通知する。
#
# Firebase Hosting 上の成果物は、その場で読むための一時公開物であり、恒久リンクには使わない。
# 定期実行では対話セッションを前提にできないため、並行公開対応済みの publish.py を使う。
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
REPO_DIR="$(cd "$PROJECT_DIR/.." && pwd -P)"
PROJECT_NAME="$(basename "$PROJECT_DIR")"
LOG_DIR="$HOME/Library/Logs/cellular-automata-auto-loop"
LOG_FILE="$LOG_DIR/publish-artifact.log"
LOCK_DIR="$LOG_DIR/publish-artifact.lock"
HTML="$PROJECT_DIR/structured-latex/build/document.html"
SLUG="cellular-automata-statistical-mechanics"
STAGE="$HOME/.artifact-uploads/math/$SLUG"
# 公開先は GitHub Pages から Firebase Hosting へ移った。旧 URL のままだと公開自体は
# 成功しているのに照合だけが落ち、ティックが毎回失敗として記録される（2026-08-16）。
EXPECTED_URL="https://hexcomp-artifacts.web.app/math/$SLUG/"
PUBLISHER="/Users/masaori/git/masaori/artifacts/publish.py"
SLACK_RESPONSE_VALIDATOR="$PROJECT_DIR/scripts/validate-slack-route-response.sh"

mkdir -p "$LOG_DIR"
log() { printf '%s %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$1" >> "$LOG_FILE"; }

PATH="$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
[ -d "$HOME/.local/share/mise/shims" ] && PATH="$HOME/.local/share/mise/shims:$PATH"
if [ -d "$HOME/.nvm/versions/node" ]; then
  nvm_bin="$(find "$HOME/.nvm/versions/node" -mindepth 1 -maxdepth 1 -type d -name 'v*' -print | sort -V | tail -1)"
  [ -n "$nvm_bin" ] && PATH="$nvm_bin/bin:$PATH"
fi
export PATH

for cli in git pnpm jq curl python3; do
  if ! command -v "$cli" >/dev/null 2>&1; then
    log "NG: 必要なコマンドが PATH に無い: $cli"
    exit 1
  fi
done
if [ ! -x "$PUBLISHER" ]; then
  log "NG: 公開スクリプトが見つからない: $PUBLISHER"
  exit 1
fi

if ! mkdir "$LOCK_DIR" 2>/dev/null; then
  lock_pid="$(cat "$LOCK_DIR/pid" 2>/dev/null || true)"
  if [ -n "$lock_pid" ] && kill -0 "$lock_pid" 2>/dev/null; then
    log "SKIP: 論文の公開処理がすでに走っている（pid ${lock_pid}）"
    exit 0
  fi
  rm -f "$LOCK_DIR/pid"
  if ! rmdir "$LOCK_DIR" 2>/dev/null; then
    log "NG: 古い公開ロックに未知の内容がある: $LOCK_DIR"
    exit 1
  fi
  mkdir "$LOCK_DIR"
  log "WARN: 終了済みプロセスの公開ロックを除去した"
fi
cleanup_lock() {
  rm -f "$LOCK_DIR/pid"
  rmdir "$LOCK_DIR" 2>/dev/null || true
}
printf '%s\n' "$$" > "$LOCK_DIR/pid"
trap cleanup_lock EXIT

project_commit="$(git -C "$REPO_DIR" log -1 --format=%H -- "$PROJECT_NAME")"
short_commit="$(printf '%.8s' "$project_commit")"
notified_mark="$LOG_DIR/last-notified-project-commit"
if [ "$(cat "$notified_mark" 2>/dev/null || true)" = "$project_commit" ]; then
  log "SKIP: 同じ論文版は公開・通知済み（版 ${short_commit}）"
  exit 0
fi

summary="$(git -C "$REPO_DIR" log -1 --format='%s' -- "$PROJECT_NAME")"
summary="$(printf '%s' "$summary" | sed -E 's/^[^:]+:[[:space:]]*//; s/（.*$//; s/[[:space:]]+$//')"
summary="「${summary}」を完了しました。"

if ! (cd "$PROJECT_DIR/structured-latex" && pnpm run --silent build:html >> "$LOG_FILE" 2>&1); then
  log "NG: 論文 HTML の生成に失敗した（版 ${short_commit}）"
  exit 1
fi

mkdir -p "$STAGE"
cp "$HTML" "$STAGE/index.html"

publish_output=""
if ! publish_output="$($PUBLISHER --src "$STAGE" --repo math --path "$SLUG" 2>&1)"; then
  printf '%s\n' "$publish_output" >> "$LOG_FILE"
  log "NG: 論文の公開に失敗した（版 ${short_commit}）"
  exit 1
fi
printf '%s\n' "$publish_output" >> "$LOG_FILE"
# 公開先の URL は EXPECTED_URL だけを正本とし、形を推測する正規表現を持たない
# （旧公開先には /artifacts/ の階層があり、移設後はそれが無い。形を二重に持つと片方が腐る）。
url="$(printf '%s\n' "$publish_output" | grep -Fo "$EXPECTED_URL" | tail -1 || true)"
if [ "$url" != "$EXPECTED_URL" ]; then
  log "NG: 公開スクリプトが期待した URL を返さなかった（版 ${short_commit}）"
  exit 1
fi

published=0
for _attempt in $(seq 1 30); do
  if curl -sfI "$url" >/dev/null; then
    published=1
    break
  fi
  sleep 10
done
if [ "$published" -ne 1 ]; then
  log "NG: 公開 URL が 200 を返さない（版 ${short_commit}・${url}）"
  exit 1
fi
log "OK: 論文を公開した（版 ${short_commit}）→ ${url}"

# **報告には最終ゴール・現在地・今回の一歩・次の一手の四項目を必ず入れる**
# （ユーザー指示 2026-09-05。それまでは今回の一歩だけを送っていて、人間から
# 「今どういう状況か・ゴール設定が報告に含まれていない」と指摘された）。四項目は固定文では
# なく、README と台帳から共通の組み立て器が毎回抽出する（正本が変われば報告も変わる）。
# 抽出に失敗したら通知せず落ちる（空欄のまま報告しない）。
if ! report_body="$(python3 "$REPO_DIR/scripts/compose-tick-report.py" "$PROJECT_DIR" "$summary")"; then
  log "NG: 報告本文（最終ゴール・現在地・今回の一歩・次の一手）を組み立てられなかった（版 ${short_commit}）"
  exit 1
fi
message="${report_body}
${url}"
case "$message" in
  *"$EXPECTED_URL"*) ;;
  *)
    log "NG: Slack 通知文に公開アーティファクト URL が無い（版 ${short_commit}）"
    exit 1
    ;;
esac
slack_response="$(slack route-post math "$message" \
  --topic "セルオートマトン統計力学" \
  --artifact-url "$EXPECTED_URL")"
printf '%s\n' "$slack_response" >> "$LOG_FILE"
if ! printf '%s' "$slack_response" | "$SLACK_RESPONSE_VALIDATOR" math; then
  log "NG: Slack の明示routeから期待した配送応答を得られなかった（版 ${short_commit}）"
  exit 1
fi

printf '%s' "$project_commit" > "$notified_mark"
log "OK: 公開 URL を Slack へ通知した（版 ${short_commit}）"
printf '%s\n' "$url"
