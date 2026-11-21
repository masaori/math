#!/usr/bin/env bash
# 具体版の定義と主張に出る mathlib・Lean 本体の記号が、本文が定義するか外から持ち込むと宣言したものだけであることを確かめる
# （docs/tasks/lean-end-to-end-runbook.md のゴールラインの条件「未定義の記号」）。
#
# 使い方（lean/ で lake build の後。本文を読むので structured-latex で pnpm install を済ませておく）:
#   bash scripts/mathlib-symbols-undefined-in-text/check.sh
#
# 見るのはビルド後の Lean の環境で、具体版（必要十分版・導出・RoutesNotAdopted を除く）の各宣言の主張と定義の本体である
# （証明は見ない）。何を記号として数えるかは UndefinedSymbols.lean にある。
#
# 許すのは次の二つだけである。
#   - 許可の一覧 lean/mathlib-symbols-defined-or-declared-in-text.txt に「記号<TAB>ラベル」で載せた記号。
#     ラベルは、その記号を本文で定義するか、外から持ち込むと宣言する本文の定義のブロックである（check-allowed.ts が確かめる）。
#     載せてよいのは、本文が定義し、具体版がそれを本文の定義どおりに定めている記号（mathlib の構成の別名ではない）か、
#     本文が外から持ち込み、使う性質を列挙している記号だけである。
#   - 既に在る使用。lean/mathlib-symbols-undefined-in-text-ledger.txt に「具体版の宣言<TAB>記号」で一行ずつ載せる。
#     台帳に無い使用が現れたら落ちる。台帳にあるのに使用でなくなった行が残っていても落ちる。台帳の行は減らすだけにする。
#
# 終了コード 0 = 台帳と一致。1 = 新しい使用、消し忘れた台帳の行、または許可の一覧の誤りがある。
set -euo pipefail

here="$(cd "$(dirname "$0")" && pwd)"
cd "$here/../.."

if ! command -v lake >/dev/null 2>&1; then
  if [ -x "$HOME/.elan/bin/lake" ]; then
    PATH="$HOME/.elan/bin:$PATH"
    export PATH
  else
    echo "NG: lake が見つからない（elan を導入し PATH を通すこと）" >&2
    exit 1
  fi
fi

allowed=mathlib-symbols-defined-or-declared-in-text.txt
ledger=mathlib-symbols-undefined-in-text-ledger.txt
work=.lake/mathlib-symbols-undefined-in-text
dump="$work/symbols.tsv"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

status=0
[ -f "$allowed" ] || { echo "NG: 許可の一覧 $allowed が無い" >&2; exit 1; }
if ! node "$here/check-allowed.ts" "$allowed" ../structured-latex/content; then
  echo "NG: 許可の一覧（$allowed）に誤りがある" >&2
  status=1
fi
{ grep -v -e '^#' -e '^$' "$allowed" || true; } | cut -f1 | LC_ALL=C sort -u > "$tmp/allowed.txt"

mkdir -p "$work"
rm -f "$dump"
lake env lean "$here/UndefinedSymbols.lean"
[ -f "$dump" ] || { echo "NG: 記号の書き出しが作られなかった" >&2; exit 1; }

awk -F'\t' 'FILENAME == ARGV[1] { ok[$1] = 1; next } $1 == "UNDEF" && !($3 in ok) { print $2 "\t" $3 }' \
  "$tmp/allowed.txt" "$dump" | LC_ALL=C sort -u > "$tmp/now.txt"
total="$(awk -F'\t' '$1 == "TOTAL" { print $2 }' "$dump")"
if [ -f "$ledger" ]; then
  { grep -v -e '^#' -e '^$' "$ledger" || true; } | LC_ALL=C sort -u > "$tmp/ledger.txt"
else
  : > "$tmp/ledger.txt"
fi

new="$(LC_ALL=C comm -23 "$tmp/now.txt" "$tmp/ledger.txt")"
stale="$(LC_ALL=C comm -13 "$tmp/now.txt" "$tmp/ledger.txt")"

echo "Ising2D: 数えた具体版の宣言: $total"
echo "Ising2D: 許可の一覧に載る記号: $(grep -c . "$tmp/allowed.txt" || true)"
echo "Ising2D: 許可の一覧に無い記号を使う具体版の宣言: $(cut -f1 "$tmp/now.txt" | LC_ALL=C sort -u | grep -c . || true)（宣言と記号の組 $(grep -c . "$tmp/now.txt" || true)、記号 $(cut -f2 "$tmp/now.txt" | LC_ALL=C sort -u | grep -c . || true)）"

if [ -n "$new" ]; then
  echo "NG: 台帳に無い、許可の一覧に無い記号の使用がある（本文の定義どおりの具体版の定義を使うか、本文で定義か宣言して $allowed に載せる）:" >&2
  printf '%s\n' "$new" >&2
  status=1
fi
if [ -n "$stale" ]; then
  echo "NG: 使用でなくなった台帳の行がある（$ledger から消す）:" >&2
  printf '%s\n' "$stale" >&2
  status=1
fi
[ "$status" -eq 0 ] && echo "OK: 許可の一覧に無い記号の使用は台帳と一致する"
exit "$status"
