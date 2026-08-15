#!/usr/bin/env bash
# 構造化証明から論文 HTML を生成・公開し、公開 URL を Slack へ一度だけ通知する。
#
# GitHub Pages 上の成果物は、その場で読むための一時公開物であり、恒久リンクには使わない。
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
EXPECTED_URL="https://hexagonal-computation.github.io/artifacts/math/$SLUG/"
PUBLISHER="/Users/masaori/git/masaori/artifacts/publish.py"
WEBHOOK_URL="https://hooks.slack.com/triggers/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"

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

summary="$(python3 - "$PROJECT_DIR/docs/tasks/auto-loop-state.md" <<'PYEOF'
import re
import sys

text = open(sys.argv[1], encoding="utf-8").read()
section = re.search(r"^## 現在地\n(.*?)(?=^## |\Z)", text, re.S | re.M)
if section is None:
    raise SystemExit(0)

entries = []
current = []
for line in section.group(1).strip().splitlines():
    if line.startswith("- "):
        if current:
            entries.append(" ".join(current))
        current = [line[2:].strip()]
    elif line.strip() and current:
        current.append(line.strip())
if current:
    entries.append(" ".join(current))

if entries:
    value = re.sub(r"\s+", " ", entries[-1].replace("**", "")).strip()
    print(value if len(value) <= 240 else value[:240] + "…")
PYEOF
)"
[ -n "$summary" ] || summary="$(git -C "$REPO_DIR" log -1 --format='%s' -- "$PROJECT_NAME")"

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
url="$(printf '%s\n' "$publish_output" | grep -Eo 'https://[^ ]+/artifacts/math/'"$SLUG"'/' | tail -1 || true)"
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

title="$(sed -n 's:.*<title>\(.*\)</title>.*:\1:p' "$HTML" | head -1)"
[ -n "$title" ] || title="2値セルオートマトンの内在構造"
agent="$(cat "$LOG_DIR/last-agent" 2>/dev/null || echo '-')"
git_common_dir="$(git -C "$REPO_DIR" rev-parse --path-format=absolute --git-common-dir 2>/dev/null || true)"
if [ -n "$git_common_dir" ]; then
  repository="$(basename "$(dirname "$git_common_dir")")"
else
  repository="math"
fi

message="${title}（${agent} / 版 ${short_commit}）
${summary}
${url}"
slack_response="$(curl --fail -sS -X POST "$WEBHOOK_URL" \
  -H 'Content-Type: application/json' \
  --data "$(jq -n --arg message "$message" --arg repository "$repository" \
    '{message: $message, repository: $repository}')")"
printf '%s\n' "$slack_response" >> "$LOG_FILE"
if ! printf '%s' "$slack_response" | jq -e '.ok == true' >/dev/null; then
  log "NG: Slack が成功応答を返さなかった（版 ${short_commit}）"
  exit 1
fi

printf '%s' "$project_commit" > "$notified_mark"
log "OK: 公開 URL を Slack へ通知した（版 ${short_commit}）"
printf '%s\n' "$url"
