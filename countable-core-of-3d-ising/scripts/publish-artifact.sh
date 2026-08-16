#!/usr/bin/env bash
# 論文そのものを HTML で公開する（ユーザー指示）。**Slack への通知はここではしない**
# （tick 側 `auto-loop-tick.sh` に一本化した。公開結果は `logs/last-published` で渡す）。
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

if ! (cd "$PROJECT_DIR/structured-latex" && npm run --silent build:html >> "$LOG_FILE" 2>&1); then
  log "NG: 論文 HTML の生成に失敗した（版 ${commit}）"
  exit 1
fi

mkdir -p "$STAGE"
cp "$HTML" "$STAGE/index.html"

out="$(/Users/masaori/git/masaori/artifacts/publish.py --src "$STAGE" --repo math --path "$SLUG" 2>&1)"
status=$?
printf '%s\n' "$out" >> "$LOG_FILE"
# 公開先が GitHub Pages から Firebase Hosting へ移り、URL から /artifacts/ の階層が
# 消えた。それを含む形で探していたため、公開は成功しているのに URL だけ取れず、毎回
# 失敗として記録されていた（2026-08-16）。名前空間から下だけを頼りに探す。
url="$(printf '%s\n' "$out" | grep -o 'https://[^ ]*/math/'"$SLUG"'/' | tail -1)"

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

# **このスクリプトは Slack へ通知しない**（2026-08-15 のユーザー指示で tick 側へ一本化した）。
# ここは公開だけを担い、通知に必要な公開結果（版と URL）を tick へ渡す。
# 通知を tick 側に置くのは、tick だけが打ち切り・異常終了を知っているからでもある
# （公開に至らなかった tick は、ここが呼ばれないので永遠に報告されなかった）。
printf '%s\t%s\n' "$commit" "$url" > "$LOG_DIR/last-published"
