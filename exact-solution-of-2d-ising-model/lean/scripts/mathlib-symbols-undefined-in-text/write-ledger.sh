#!/usr/bin/env bash
# 台帳を、いま許可の一覧に無い記号の使用の一覧で書き直す。使ってよいのは、台帳を初めて置くときと、
# 記号の数え方（UndefinedSymbols.lean）を変えたときだけである。新しい使用を足して検査を通すために使わない。
#
# 使い方（lean/ で check.sh を一度走らせ、symbols.tsv を作った後）:
#   bash scripts/mathlib-symbols-undefined-in-text/write-ledger.sh
set -euo pipefail
cd "$(dirname "$0")/../.."
dump=.lake/mathlib-symbols-undefined-in-text/symbols.tsv
allowed=mathlib-symbols-defined-or-declared-in-text.txt
[ -f "$dump" ] || { echo "NG: $dump が無い（先に check.sh を走らせる）" >&2; exit 1; }
{
  printf '# 具体版の定義と主張に出る、許可の一覧（%s）に無い mathlib・Lean 本体の記号の既知の使用。\n' "$allowed"
  printf '# 一行に「具体版の宣言<TAB>記号」。scripts/mathlib-symbols-undefined-in-text/check.sh が読む。\n'
  printf '# 行は減らすだけにする。直した行（記号を許可の一覧に載せた、または宣言から記号を除いた）は同じ回に消す。\n'
  awk -F'\t' 'FILENAME == ARGV[1] { if ($0 !~ /^#/ && $0 != "") ok[$1] = 1; next }
    $1 == "UNDEF" && !($3 in ok) { print $2 "\t" $3 }' "$allowed" "$dump" | LC_ALL=C sort -u
} > mathlib-symbols-undefined-in-text-ledger.txt
echo "$(grep -vc '^#' mathlib-symbols-undefined-in-text-ledger.txt) 行を書いた"
