#!/usr/bin/env bash
# 研究の段取りが、正本・手元のビルド・公開ページの三つで一致していることを検査する。
#
#   verify-roadmap-artifact.sh              正本の内容検査と、手元でビルドした HTML との照合
#   verify-roadmap-artifact.sh --published  さらに公開ページを取得して同じ照合を行う
#
# 公開ページの照合を既定にしないのは、公開が済む前の検証でも使うためである。
# 逆に `--published` を付けたときは、取得できないこと・古いことを成功として通さない。
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
STRUCTURED_DIR="$PROJECT_DIR/structured-latex"
PUBLISHED_URL="https://hexcomp-artifacts.web.app/math/cellular-automata-statistical-mechanics/"

check_published=0
for arg in "$@"; do
  case "$arg" in
    --published) check_published=1 ;;
    *)
      echo "不明な引数: $arg" >&2
      exit 2
      ;;
  esac
done

PATH="$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:$PATH"
[ -d "$HOME/.local/share/mise/shims" ] && PATH="$HOME/.local/share/mise/shims:$PATH"
export PATH

for cli in node curl; do
  if ! command -v "$cli" >/dev/null 2>&1; then
    echo "必要なコマンドが PATH に無い: $cli" >&2
    exit 1
  fi
done

cd "$STRUCTURED_DIR"

echo "== 段取りの正本を検査する =="
node tools/verify-roadmap.ts

echo "== 手元でビルドした HTML と照合する =="
node tools/build-html.ts build/document.html >/dev/null
node tools/verify-roadmap-in-output.ts build/document.html "手元のビルド"

if [ "$check_published" -eq 0 ]; then
  echo "公開ページの照合は行っていない（--published を付けると行う）"
  exit 0
fi

echo "== 公開ページと照合する: $PUBLISHED_URL =="
tmp="$(mktemp -t roadmap-published)"
trap 'rm -f "$tmp"' EXIT
status="$(curl -sS -L -o "$tmp" -w '%{http_code}' "$PUBLISHED_URL")"
if [ "$status" != "200" ]; then
  echo "公開ページを取得できない（HTTP $status）: $PUBLISHED_URL" >&2
  exit 1
fi
node tools/verify-roadmap-in-output.ts "$tmp" "公開ページ $PUBLISHED_URL"
