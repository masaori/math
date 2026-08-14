#!/usr/bin/env bash
# 論文そのものを HTML で公開し、tick の完了を Slack へ報告する（ユーザー指示）。
#
# 公開するのは**論文**であって、進捗の報告ではない。`structured-latex/content/` から
# `tools/build-html.ts` が 1 枚の HTML を作り、それをそのまま index.html として置く。
# PDF は公開しない（手元で開いて読む）。
#
# 公開先は artifacts リポジトリの GitHub Pages。**URL を決め打ちしない**
# （リポジトリの所有が移って決め打ちの URL が 404 になった実例がある）。
# エージェント CLI 内蔵の公開機能は使わない（グローバル指示）。
#
# **その場で見るためのものだけを置く。** ここは予告なく消えうる場所である。
set -uo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
REPO_DIR="$(cd "$PROJECT_DIR/.." && pwd -P)"
LOG_DIR="$HOME/Library/Logs/ising-3d-cut-auto-loop"
LOG_FILE="$LOG_DIR/publish-artifact.log"
LOCK_DIR="$LOG_DIR/publish-artifact.lock"
HTML="$PROJECT_DIR/structured-latex/build/document.html"
SLUG="ising-3d-cut"
STAGE="$HOME/.artifact-uploads/math/$SLUG"

mkdir -p "$LOG_DIR"
log() { printf '%s %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$1" >> "$LOG_FILE"; }

PATH="$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
[ -d "$HOME/.local/share/mise/shims" ] && PATH="$HOME/.local/share/mise/shims:$PATH"
if [ -d "$HOME/.nvm/versions/node" ]; then
  nvm_bin="$(ls -d "$HOME"/.nvm/versions/node/v* 2>/dev/null | sort -V | tail -1)"
  [ -n "$nvm_bin" ] && PATH="$nvm_bin/bin:$PATH"
fi
export PATH

if ! mkdir "$LOCK_DIR" 2>/dev/null; then exit 0; fi
trap 'rm -rf "$LOCK_DIR"' EXIT

commit="$(git -C "$REPO_DIR" rev-parse --short HEAD)"
agent="$(cat "$LOG_DIR/last-agent" 2>/dev/null || echo '-')"

# 通知の見出しはプロジェクト README の表題から取る。**固定文字列にすると、ゴール設定が
# 変わったときに古い名前を通知し続ける**（実測 2026-08-14: 降格した「臨界点の切断」を
# 名乗り続けていた）。
title="$(sed -n '1s/^#\{1,\} *//p' "$PROJECT_DIR/README.md")"
[ -z "$title" ] && title="3 次元 Ising（可算側）"

# リポジトリ名は共有チェックアウトの名前にする。**worktree 名を使うと通知先の分類が壊れる**
# （このループは専用 worktree で走るので、素朴に basename を取ると worktree 名になる）。
git_common_dir="$(git -C "$REPO_DIR" rev-parse --path-format=absolute --git-common-dir 2>/dev/null || true)"
if [ -n "$git_common_dir" ]; then
  repository="$(basename "$(dirname "$git_common_dir")")"
else
  repository="$(basename "$REPO_DIR")"
fi

# その tick が何をしたか。コミットの件名は短いので、台帳の「現在地」の先頭
# （＝直近の tick の記録）を本文にする。
summary="$(python3 - "$PROJECT_DIR/docs/tasks/auto-loop-state.md" <<'PYEOF'
import re, sys

text = open(sys.argv[1], encoding="utf-8").read()
section = re.search(r"^## 現在地\n(.*?)(?=^## |\Z)", text, re.S | re.M)
if section is None:
    raise SystemExit(0)

lines, body = section.group(1).strip().split("\n"), []
for line in lines:
    if line.startswith("- ") and body:
        break
    if line.startswith("- "):
        body.append(line[2:].strip())
    elif line.strip():
        body.append(line.strip())
text = " ".join(body).replace("**", "")
# **短く切る。** 人間が Slack で読むのは「その tick が何をしたか」の 1〜2 文だけであり、
# 台帳の記述をそのまま流すと読まれない（2026-08-14 のユーザー指摘）。
print(text if len(text) <= 240 else text[:240] + "…")
PYEOF
)"
[ -z "$summary" ] && summary="$(git -C "$REPO_DIR" log -1 --format='%s')"

if ! (cd "$PROJECT_DIR/structured-latex" && npm run --silent build:html >> "$LOG_FILE" 2>&1); then
  log "NG: 論文 HTML の生成に失敗した（版 ${commit}）"
  exit 1
fi

mkdir -p "$STAGE"
cp "$HTML" "$STAGE/index.html"

out="$(/Users/masaori/git/masaori/artifacts/publish.py --src "$STAGE" --repo math --path "$SLUG" 2>&1)"
status=$?
printf '%s\n' "$out" >> "$LOG_FILE"
url="$(printf '%s\n' "$out" | grep -o 'https://[^ ]*/artifacts/math/'"$SLUG"'/' | tail -1)"

if [ "$status" -ne 0 ]; then
  log "NG: 公開に失敗した（版 ${commit}）"
  exit 1
fi
if [ -z "$url" ]; then
  log "NG: 公開はできたが URL を取れなかった（版 ${commit}）"
  exit 1
fi
if ! curl -sfI "$url" >/dev/null 2>&1; then
  log "NG: 公開した URL が読めない（版 ${commit}・$url）"
  exit 1
fi
log "OK: 公開した（版 ${commit}）→ $url"

# tick の完了を Slack へ報告する（ユーザー指示）。作業内容の概要と公開 URL を添える。
# **同じ版で二度は送らない**（別経路から呼ばれても重複しないため）。
NOTIFIED="$LOG_DIR/last-notified-commit"
if [ "$(cat "$NOTIFIED" 2>/dev/null || true)" != "$commit" ]; then
  message="${title}（${agent} / 版 ${commit}）
${summary}
${url}"
  if curl -sS -X POST 'https://hooks.slack.com/triggers/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' \
      -H "Content-Type: application/json" \
      --data "$(jq -n --arg message "$message" --arg repository "$repository" \
        '{message: $message, repository: $repository}')" >> "$LOG_FILE" 2>&1; then
    printf '%s' "$commit" > "$NOTIFIED"
  else
    log "NG: Slack への通知に失敗した（版 ${commit}）"
  fi
fi
