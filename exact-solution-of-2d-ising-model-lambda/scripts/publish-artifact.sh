#!/usr/bin/env bash
# 論文そのものを HTML で公開する（ユーザー指示）。
#
# 公開するのは**論文**であって、進捗の報告ではない。`structured-latex/content/` から
# `tools/build-html.ts` が 1 枚の HTML を作り、それをそのまま index.html として置く。
# PDF は公開しない（手元で開いて読む）。
#
# 公開先は artifacts リポジトリの GitHub Pages。**URL を決め打ちしない**
# （リポジトリの所有が masaori から hexagonal-computation へ移り、決め打ちした URL が
#  実測 2026-08-13 に 404 になった）。公開スクリプトが出力した URL をそのまま使う。
# エージェント CLI 内蔵の公開機能は使わない（グローバル指示。アカウントが切り替わると閲覧できなくなる）。
#
# **その場で見るためのものだけを置く。** ここは予告なく消えうる場所なので、
# 恒久的にリンクされるものは置かない（グローバル指示）。
#
# **このスクリプトは Slack へ送らない**（ユーザー指示 2026-08-15）。人間への報告は tick 側に
# 一本化してある。公開した URL は下の「OK: 公開した」の行に出るので、tick はそれを読んで添える。
set -uo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
REPO_DIR="$(cd "$PROJECT_DIR/.." && pwd -P)"
LOG_DIR="$PROJECT_DIR/logs"
LOG_FILE="$LOG_DIR/publish-artifact.log"
LOCK_DIR="$LOG_DIR/publish-artifact.lock"
HTML="$PROJECT_DIR/structured-latex/build/document.html"
SLUG="ising-lambda"
STAGE="$HOME/.artifact-uploads/math/$SLUG"

mkdir -p "$LOG_DIR"
log() { printf '%s %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$1" >> "$LOG_FILE"; }

PATH="$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
if [ -d "$HOME/.nvm/versions/node" ]; then
  nvm_bin="$(ls -d "$HOME"/.nvm/versions/node/v* 2>/dev/null | sort -V | tail -1)"
  [ -n "$nvm_bin" ] && PATH="$nvm_bin/bin:$PATH"
fi
export PATH

if ! mkdir "$LOCK_DIR" 2>/dev/null; then exit 0; fi
trap 'rm -rf "$LOCK_DIR"' EXIT

commit="$(git -C "$REPO_DIR" rev-parse --short HEAD)"

# **公開してよいのは、再現できる版だけである。** 判定はここに直書きせず、
# scripts/require-publishable-version.sh に置いてある（回帰試験を当てるため）。
# dirty 印を隠すのではなく、dirty なら公開しない。remote default に含まれることも確かめる。
if ! gate_output="$(bash "$PROJECT_DIR/scripts/require-publishable-version.sh" "$REPO_DIR" 2>&1)"; then
  log "NG: 公開できる版ではない（版 ${commit}）"
  printf '%s\n' "$gate_output" | tee -a "$LOG_FILE"
  exit 1
fi

PUBLISHED="$LOG_DIR/last-published-commit"
published="$(cat "$PUBLISHED" 2>/dev/null || true)"

# 同じリポジトリで別プロジェクト（3 次元 Ising 側）のループも push しているため、
# 版が変わっただけでは論文は変わらない。**このプロジェクトの中身が動いていなければ何もしない**
# （実測 2026-08-14: 姉妹側の push で公開が余分に走っていた）。
if [ -n "$published" ] && git -C "$REPO_DIR" cat-file -e "$published^{commit}" 2>/dev/null; then
  if [ -z "$(git -C "$REPO_DIR" diff --name-only "$published" HEAD -- "$PROJECT_DIR" 2>/dev/null)" ]; then
    exit 0
  fi
fi

if ! (cd "$PROJECT_DIR/structured-latex" && npm run --silent build:html >> "$LOG_FILE" 2>&1); then
  log "NG: 論文 HTML の生成に失敗した（版 ${commit}）"
  exit 1
fi

mkdir -p "$STAGE"
rm -f "$STAGE/document.pdf"   # 以前は PDF も置いていた。もう置かない。
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
printf '%s' "$commit" > "$PUBLISHED"

# **Slack へはここから送らない**（ユーザー指示 2026-08-15）。通知は tick 側に一本化した。
# 通知に要る公開結果（版と URL）はここで渡す。tick はログを読まずにこの 1 行を見る。
printf '%s\t%s\n' "$commit" "$url" > "$LOG_DIR/last-published"
