#!/usr/bin/env bash
# 具体版が mathlib の線型代数の一般論（基底・次元・部分加群・線型独立・直和など）を直接使っていないことを確かめる。
# 具体版は人手証明と 1 対 1 に対応させるので、人手が定義も証明もしていない一般論を Lean だけが mathlib で埋めると、
# 人手の証明の穴が Lean の検査を通ってしまう。リポジトリの全てのプロジェクトの Lean に共通の検査である
# （リポジトリ直下 CLAUDE.md「検証」）。
#
# 使い方（そのプロジェクトで lake build の後）:
#   bash scripts/lean-concrete-general-theory/check.sh <プロジェクト>/lean
#
# 一般論の接頭辞は general-theory-prefixes.txt にある。見るのはビルド後の Lean の環境で、具体版の各宣言の主張と本体が
# 直接使うライブラリの外の定数である（分類は scripts/lean-concrete-necsuf-separation/Separation.lean.in と同じ）。
# 使われた定数の名前が接頭辞で始まるか、その主張が接頭辞で始まる定数を含めば、その一般論を使ったとみなす。
#
# 許すのは次の二つだけである。
#   - 本文が一般論として定義せずに用いると明示したもの。<プロジェクト>/lean/declared-general-theory.txt に
#     「接頭辞<TAB>人手のラベル」を一行ずつ書く。ラベルのブロックの主張は「定義せずに用いる」と書いていなければならない
#     （check-declared.ts が確かめる。本文を読むので、そのプロジェクトの structured-latex で pnpm install を済ませておく）。
#     書いた接頭辞は、そのプロジェクトの具体版の全てで使ってよい。
#   - 既に在る違反。<プロジェクト>/lean/concrete-general-theory-ledger.txt に一行ずつ載せる（無ければ違反は零として扱う）。
#     台帳に無い違反が現れたら落ちる。台帳にあるのに違反でなくなった行が残っていても落ちる。台帳の行は減らすだけにする。
#
# 終了コード 0 = 台帳と一致。1 = 新しい違反、消し忘れた台帳の行、または宣言の一覧の誤りがある。
set -euo pipefail

here="$(cd "$(dirname "$0")" && pwd)"
[ $# -eq 1 ] || { echo "使い方: bash $0 <プロジェクト>/lean" >&2; exit 1; }
cd "$1"

if ! command -v lake >/dev/null 2>&1; then
  if [ -x "$HOME/.elan/bin/lake" ]; then
    PATH="$HOME/.elan/bin:$PATH"
    export PATH
  else
    echo "NG: lake が見つからない（elan を導入し PATH を通すこと）" >&2
    exit 1
  fi
fi

lib="$(awk '/^\[\[lean_lib\]\]/{f=1; next} f && /^name *=/{gsub(/^name *= *"|"$/, ""); print; exit}' lakefile.toml)"
[ -n "$lib" ] || { echo "NG: lakefile.toml から lean_lib の name を読めない" >&2; exit 1; }

prefixes="$here/general-theory-prefixes.txt"
ledger=concrete-general-theory-ledger.txt
declared=declared-general-theory.txt
work=.lake/concrete-general-theory
dump="$work/uses.tsv"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

status=0
: > "$tmp/allowed.txt"
if [ -f "$declared" ]; then
  if ! node "$here/check-declared.ts" "$declared" ../structured-latex/content "$prefixes"; then
    echo "NG: $lib の宣言した一般論の一覧（$1/$declared）に誤りがある" >&2
    status=1
  fi
  { grep -v -e '^#' -e '^$' "$declared" || true; } | cut -f1 | LC_ALL=C sort -u > "$tmp/allowed.txt"
fi

mkdir -p "$work"
rm -f "$dump"
sed -e "s/@LIB@/$lib/g" -e "s|@PREFIXES@|$prefixes|g" "$here/GeneralTheory.lean.in" > "$work/GeneralTheory.lean"
lake env lean "$work/GeneralTheory.lean"
[ -f "$dump" ] || { echo "NG: 使用の書き出しが作られなかった" >&2; exit 1; }

# 宣言した接頭辞の行を除き、具体版の宣言と接頭辞の組ごとに一行にする。
awk -F'\t' 'FILENAME == ARGV[1] { ok[$1] = 1; next } $1 == "GT" && !($3 in ok) { print "GT\t" $2 "\t" $3 }' \
  "$tmp/allowed.txt" "$dump" | LC_ALL=C sort -u > "$tmp/now.txt"
if [ -f "$ledger" ]; then
  { grep -v -e '^#' -e '^$' "$ledger" || true; } | LC_ALL=C sort -u > "$tmp/ledger.txt"
else
  : > "$tmp/ledger.txt"
fi

new="$(LC_ALL=C comm -23 "$tmp/now.txt" "$tmp/ledger.txt")"
stale="$(LC_ALL=C comm -13 "$tmp/now.txt" "$tmp/ledger.txt")"

echo "$lib: 一般論を使う具体版の宣言: $(cut -f2 "$tmp/now.txt" | LC_ALL=C sort -u | grep -c . || true)（宣言と接頭辞の組 $(grep -c . "$tmp/now.txt" || true)）"
echo "$lib: 本文が定義せずに用いると明示した接頭辞: $(grep -c . "$tmp/allowed.txt" || true)"

if [ -n "$new" ]; then
  echo "NG: $lib の具体版に台帳に無い一般論の使用がある（人手の証明が定義・証明している主張を引くか、本文で明示して $declared に書く）:" >&2
  printf '%s\n' "$new" >&2
  status=1
fi
if [ -n "$stale" ]; then
  echo "NG: $lib に違反でなくなった台帳の行がある（直したら $1/$ledger から消す）:" >&2
  printf '%s\n' "$stale" >&2
  status=1
fi
[ "$status" -eq 0 ] && echo "OK: $lib の具体版の一般論の使用は台帳と一致する"
exit "$status"
