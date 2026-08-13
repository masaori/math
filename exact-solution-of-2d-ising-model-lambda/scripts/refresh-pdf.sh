#!/usr/bin/env bash
# 開きっぱなしの PDF を常に最新（＝`origin/main` の内容）に保つ。
#
# なぜ要るか: PDF は tick の最後にしか作り直されないので、tick の途中に人が作り直すと
# 「未コミットの変更を含む」中途半端な版になる。かといって放置すると、
# tick が push した内容が手元の PDF に反映されない。そこで `origin/main` が進んだら
# 自動で作り直す。**作業ツリーが汚れているときは作らない**（中途半端な版を見せないため）。
#
# 手で 1 回だけ回したいとき: bash scripts/refresh-pdf.sh
set -uo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
REPO_DIR="$(cd "$PROJECT_DIR/.." && pwd -P)"
LOG_DIR="$PROJECT_DIR/logs"
LOG_FILE="$LOG_DIR/refresh-pdf.log"
LOCK_DIR="$LOG_DIR/refresh-pdf.lock"
TEX="$PROJECT_DIR/structured-latex/build/document.tex"

mkdir -p "$LOG_DIR"
log() { printf '%s %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$1" >> "$LOG_FILE"; }

PATH="$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
if [ -s "$HOME/.nvm/alias/default" ]; then
  for dir in "$HOME"/.nvm/versions/node/v"$(cat "$HOME/.nvm/alias/default")"*; do
    [ -d "$dir/bin" ] && PATH="$dir/bin:$PATH"
  done
fi
export PATH

if ! mkdir "$LOCK_DIR" 2>/dev/null; then
  exit 0  # 前の実行がまだ走っている。黙って見送る。
fi
trap 'rm -rf "$LOCK_DIR"' EXIT

# tick が走っている間は作業ツリーが動くので触らない（tick は最後に自分で作り直す）。
if [ -d "$LOG_DIR/auto-loop.lock" ]; then
  exit 0
fi

cd "$REPO_DIR"
if [ -n "$(git status --porcelain)" ]; then
  exit 0  # 誰かが編集中。中途半端な版を作らない。
fi

git fetch origin --quiet 2>/dev/null || exit 0
head="$(git rev-parse --short origin/main)"

# いまの PDF がどのコミットで作られたかは、表紙の版の行に書いてある。
stamped=""
[ -f "$TEX" ] && stamped="$(grep -o '版 [0-9a-f]\{7,\}' "$TEX" | head -1 | awk '{print $2}')"

[ "$stamped" = "$head" ] && exit 0  # 既に最新。

# ローカルが origin/main より遅れているなら追いつく（早送りできる場合だけ）。
git merge-base --is-ancestor HEAD origin/main 2>/dev/null && git merge --ff-only origin/main --quiet 2>/dev/null

log "PDF を作り直す（${stamped:-なし} → ${head}）"
if (cd "$PROJECT_DIR/structured-latex" && npm run build:pdf >> "$LOG_FILE" 2>&1); then
  log "OK: PDF を ${head} で作り直した"
  bash "$PROJECT_DIR/scripts/publish-artifact.sh" >> "$LOG_FILE" 2>&1 || log "NG: アーティファクトの公開に失敗した"
else
  log "NG: PDF の生成に失敗した（内容の欠陥。監査が拾う）"
fi
