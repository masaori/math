#!/usr/bin/env bash
# 構造化証明から論文 HTML を生成・公開し、公開 URL を Slack へ一度だけ通知する。
#
# Firebase Hosting 上の成果物は、その場で読むための一時公開物であり、恒久リンクには使わない。
# 定期実行では対話セッションを前提にできないため、成果物基盤の認証付き API CLI を使う。
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
ARTIFACTS_REPO="/Users/masaori/git/masaori/artifacts"
PUBLISHER="$ARTIFACTS_REPO/frontend/for-ai-agents/bin/publish.ts"
ARTIFACTS_API_URL="https://hexcomp-artifacts.web.app"
ARTIFACTS_API_AUDIENCE="https://artifacts.hexagonal-computation.com/api"
ARTIFACT_TITLE="2値セルオートマトンの内在構造 — 局所規則から生じる数学の抽出"
PUBLISH_RESPONSE_VALIDATOR="$PROJECT_DIR/scripts/validate-artifact-publish-response.sh"
PROJECT_COMMIT_VALIDATOR="$PROJECT_DIR/scripts/validate-publish-project-commit.sh"
SLACK_RESPONSE_VALIDATOR="$PROJECT_DIR/scripts/validate-slack-route-response.sh"

mkdir -p "$LOG_DIR"
log() { printf '%s %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$1" >> "$LOG_FILE"; }

PATH="$HOME/.agent-shims:$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
[ -d "$HOME/.local/share/mise/shims" ] && PATH="$HOME/.local/share/mise/shims:$PATH"
if [ -d "$HOME/.nvm/versions/node" ]; then
  nvm_bin="$(find "$HOME/.nvm/versions/node" -mindepth 1 -maxdepth 1 -type d -name 'v*' -print | sort -V | tail -1)"
  [ -n "$nvm_bin" ] && PATH="$nvm_bin/bin:$PATH"
fi
export PATH

for cli in git pnpm npx jq curl python3; do
  if ! command -v "$cli" >/dev/null 2>&1; then
    log "NG: 必要なコマンドが PATH に無い: $cli"
    exit 1
  fi
done
if [ ! -f "$PUBLISHER" ]; then
  log "NG: 公開スクリプトが見つからない: $PUBLISHER"
  exit 1
fi

case "$#" in
  0) project_commit="$(git -C "$REPO_DIR" log -1 --format=%H -- "$PROJECT_NAME")" ;;
  2)
    if [ "$1" != "--project-commit" ]; then
      log "NG: 未知の引数: $1"
      exit 2
    fi
    project_commit="$2"
    ;;
  *)
    log "NG: usage: publish-artifact.sh [--project-commit <commit>]"
    exit 2
    ;;
esac
if ! "$PROJECT_COMMIT_VALIDATOR" "$REPO_DIR" "$PROJECT_NAME" "$project_commit"; then
  log "NG: 公開対象は現在の履歴に含まれ、この研究を変更した commit でなければならない"
  exit 1
fi
if ! bash -lc 'type agent-id-token >/dev/null 2>&1'; then
  log "NG: 正規 API の呼出主体を取得する agent-id-token が配布されていない"
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

short_commit="$(printf '%.8s' "$project_commit")"
notified_mark="$LOG_DIR/last-notified-project-commit"
if [ "$(cat "$notified_mark" 2>/dev/null || true)" = "$project_commit" ]; then
  log "SKIP: 同じ論文版は公開・通知済み（版 ${short_commit}）"
  exit 0
fi

summary="$(git -C "$REPO_DIR" show -s --format='%s' "$project_commit")"
summary="$(printf '%s' "$summary" | sed -E 's/^[^:]+:[[:space:]]*//; s/（.*$//; s/[[:space:]]+$//')"
summary="「${summary}」を完了しました。"

if ! (cd "$PROJECT_DIR/structured-latex" && pnpm run --silent build:html >> "$LOG_FILE" 2>&1); then
  log "NG: 論文 HTML の生成に失敗した（版 ${short_commit}）"
  exit 1
fi

mkdir -p "$STAGE"
cp "$HTML" "$STAGE/index.html"

publish_output=""
if ! publish_output="$(
  cd "$REPO_DIR"
  ARTIFACTS_API_URL="$ARTIFACTS_API_URL" \
    ARTIFACTS_API_AUDIENCE="$ARTIFACTS_API_AUDIENCE" \
    npx --prefix "$ARTIFACTS_REPO" tsx "$PUBLISHER" \
      --src "$STAGE" \
      --repo math \
      --path "$SLUG" \
      --title "$ARTIFACT_TITLE"
)" 2>> "$LOG_FILE"; then
  log "NG: 論文の公開に失敗した（版 ${short_commit}）"
  exit 1
fi
printf '%s\n' "$publish_output" >> "$LOG_FILE"
if ! url="$(printf '%s' "$publish_output" | "$PUBLISH_RESPONSE_VALIDATOR" "$ARTIFACTS_API_URL")"; then
  log "NG: 公開 API が公開済み URL を正しい JSON で返さなかった（版 ${short_commit}）"
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
  *"$url"*) ;;
  *)
    log "NG: Slack 通知文に公開アーティファクト URL が無い（版 ${short_commit}）"
    exit 1
    ;;
esac
slack_response="$(slack route-post math "$message" \
  --topic "セルオートマトン統計力学" \
  --artifact-url "$url")"
printf '%s\n' "$slack_response" >> "$LOG_FILE"
if ! printf '%s' "$slack_response" | "$SLACK_RESPONSE_VALIDATOR" math; then
  log "NG: Slack の明示routeから期待した配送応答を得られなかった（版 ${short_commit}）"
  exit 1
fi

printf '%s' "$project_commit" > "$notified_mark"
log "OK: 公開 URL を Slack へ通知した（版 ${short_commit}）"
printf '%s\n' "$url"
