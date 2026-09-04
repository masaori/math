#!/usr/bin/env bash
# スマートフォン幅で読むときの目次が、ハンバーガーから入れ子を含む全階層で開けることを検証する。
#
# 検証の対象は 2 つある。
#   1. 手元のビルド成果（各プロジェクトの structured-latex/build/document.html）— 既定
#   2. 公開済みの HTML（--published）— Firebase Hosting 上の各論文の index.html を取得して検証する
#
# この script は自己完結にしてある。remote default branch の版だけを取り出して
# そのまま実行できる（作業ツリーの状態に依存しない）:
#
#   git show origin/main:scripts/verify-structured-latex-mobile-toc-artifacts.sh | bash -s -- --published
#
# 「現行版が反映されているか」は、公開 HTML に埋め込まれた版表示（作成時の commit）を見て、
# それが remote default branch に含まれるコミットかどうかで判定する。
set -uo pipefail

MODE="build"
case "${1-}" in
  --published) MODE="published" ;;
  --build|'') MODE="build" ;;
  *) echo "usage: $0 [--build|--published]" >&2; exit 2 ;;
esac

BASE_URL="https://hexcomp-artifacts.web.app/math"

# 共通レンダラー（structured-latex/renderers/html/chapter-navigation.ts）を使う論文と、
# その論文が公開されている名前空間の対応。新しい論文を足したらここへ 1 行足す。
# 名前付きスナップショット（… -before-chapter-navigation / … -after-finite-graph-split など）は
# 撮った時点を残すための公開物なので、ここには入れない（更新すると何を写したのかが消える）。
PROJECTS=(
  "exact-solution-of-2d-ising-model|complex-matrix-ising-paper"
  "exact-solution-of-2d-ising-model-lambda|ising-lambda"
  "cellular-automata-statistical-mechanics|cellular-automata-statistical-mechanics"
  "countable-core-of-3d-ising|ising-3d-cut"
  "countable-ising-on-hyperbolic-surfaces|countable-hyperbolic-ising-mathjax"
  "finite-graph-ising-partition-polynomial-and-fisher-zeros|finite-graph-ising-partition-polynomial"
)

failures=0
fail() { echo "  NG: $1"; failures=$((failures + 1)); }

check_html() {
  local name="$1" file="$2"
  echo "== $name"

  if [ ! -s "$file" ]; then fail "HTML を取得できなかった"; return; fi

  # ハンバーガーは button であること（div にしない。キーボードで押せなくなる）
  local toggle
  toggle="$(grep -o '<button type="button" class="chapter-navigation__toggle"[^>]*>' "$file" | head -1)"
  if [ -z "$toggle" ]; then fail "ハンバーガーの button が無い"; return; fi
  case "$toggle" in
    *'aria-expanded="false"'*) ;;
    *) fail "button に aria-expanded の初期値が無い" ;;
  esac

  local menu_id
  menu_id="$(printf '%s' "$toggle" | sed -n 's/.*aria-controls="\([^"]*\)".*/\1/p')"
  if [ -z "$menu_id" ]; then fail "button に aria-controls が無い"; return; fi
  if ! grep -q "class=\"chapter-navigation__menu\" id=\"$menu_id\" hidden" "$file"; then
    fail "aria-controls=${menu_id} の指す目次パネルが（閉じた状態で）存在しない"
  fi

  # モバイルの目次が入れ子を含む全階層であること
  local menu
  menu="$(sed -n "s/.*<div class=\"chapter-navigation__menu\" id=\"$menu_id\" hidden>\(.*\)<\/div>.*<div class=\"page-layout\">.*/\1/p" "$file")"
  if [ -z "$menu" ]; then
    menu="$(tr '\n' ' ' < "$file" | sed -n "s/.*<div class=\"chapter-navigation__menu\" id=\"$menu_id\" hidden>\(.*\)<div class=\"page-layout\">.*/\1/p")"
  fi
  if [ -z "$menu" ]; then fail "目次パネルの中身を取り出せなかった"; return; fi

  local count nested
  count="$(printf '%s' "$menu" | grep -o 'class="chapter-link"' | wc -l | tr -d ' ')"
  nested="$(printf '%s' "$menu" | grep -o '<ul>' | wc -l | tr -d ' ')"
  if [ "$count" -lt 2 ]; then fail "目次の項目が ${count} 件しかない"; fi
  if [ "$nested" -lt 2 ]; then fail "目次が入れ子になっていない（<ul> が ${nested} 個）"; fi
  echo "  目次 $count 項目・入れ子 $nested 段（ハンバーガー: ${menu_id}）"

  # 閉じる手段（Escape・項目選択・外側の操作）が実際に実装されていること
  grep -q "event.key !== 'Escape'" "$file" || fail "Escape で閉じる処理が無い"
  grep -q "setMenuOpen(false)" "$file" || fail "閉じる処理が無い"
  grep -q "addEventListener('pointerdown'" "$file" || fail "外側の操作で閉じる処理が無い"

  # 旧実装（最上位だけを横並びにするタブ）が残っていないこと
  if grep -q 'chapter-navigation--mobile ul { display:flex' "$file"; then
    fail "モバイルが最上位だけの横並びタブのまま（改修前の版）"
  fi
}

if [ "$MODE" = "build" ]; then
  ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
  for entry in "${PROJECTS[@]}"; do
    project="${entry%%|*}"
    check_html "${project}（手元のビルド）" "$ROOT/$project/structured-latex/build/document.html"
  done
else
  tmp="$(mktemp -d)"
  trap 'rm -rf "$tmp"' EXIT
  for entry in "${PROJECTS[@]}"; do
    project="${entry%%|*}"
    slug="${entry##*|}"
    url="$BASE_URL/$slug/"
    file="$tmp/$slug.html"
    curl -sfL "$url" -o "$file" || true
    check_html "${slug}（${url}）" "$file"

    # 公開されているのが現行版であること: 埋め込まれた版が remote default branch に含まれるか
    commit="$(grep -o '版 [0-9a-f]\{7,40\}' "$file" | head -1 | awk '{print $2}')"
    if grep -q '版 [0-9a-f]\{7,40\}+' "$file"; then
      fail "未コミットの変更を含む状態で公開されている（版 ${commit}+）"
    elif [ -z "$commit" ]; then
      echo "  版表示なし（この論文は版を埋め込んでいない）"
    elif git cat-file -e "${commit}^{commit}" 2>/dev/null &&
         git merge-base --is-ancestor "$commit" origin/main 2>/dev/null; then
      echo "  公開版 ${commit} は origin/main に含まれる"
    else
      fail "公開版 ${commit} が origin/main に含まれない（再公開が要る）"
    fi
  done
fi

if [ "$failures" -ne 0 ]; then
  echo "NG: ${failures} 件"
  exit 1
fi
echo "OK: すべての論文でハンバーガーから全階層の目次を開ける"
