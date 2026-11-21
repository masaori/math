#!/usr/bin/env bash
# 台帳を、いまの違反の一覧で書き直す。使ってよいのは、プロジェクトに台帳を初めて置くときと、
# 一般論の接頭辞の一覧（general-theory-prefixes.txt）か分類の決まりを変えたときだけである。違反を足して検査を通すために使わない。
#
# 使い方（check.sh を一度走らせ、uses.tsv を作った後）:
#   bash scripts/lean-concrete-general-theory/write-ledger.sh <プロジェクト>/lean
set -euo pipefail
cd "$1"
dump=.lake/concrete-general-theory/uses.tsv
[ -f "$dump" ] || { echo "NG: $dump が無い（先に check.sh を走らせる）" >&2; exit 1; }
allowed="$(mktemp)"
trap 'rm -f "$allowed"' EXIT
if [ -f declared-general-theory.txt ]; then
  { grep -v -e '^#' -e '^$' declared-general-theory.txt || true; } | cut -f1 | LC_ALL=C sort -u > "$allowed"
fi
{
  printf '# 具体版が mathlib の線型代数の一般論を使っている既知の箇所。scripts/lean-concrete-general-theory/check.sh（リポジトリ直下）が読む。\n'
  printf '# GT 行は「具体版の宣言・使っている一般論の接頭辞」。人手の証明が定義・証明した主張を引く形に直すか、本文で明示して\n'
  printf '# declared-general-theory.txt に書いたら、同じ回にこの行を消す。行は減らすだけにする。\n'
  awk -F'\t' 'FILENAME == ARGV[1] { ok[$1] = 1; next } $1 == "GT" && !($3 in ok) { print "GT\t" $2 "\t" $3 }' "$allowed" "$dump" | LC_ALL=C sort -u
} > concrete-general-theory-ledger.txt
echo "$(grep -vc '^#' concrete-general-theory-ledger.txt) 行を書いた"
