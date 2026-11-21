#!/usr/bin/env bash
# 台帳を、いま最終定理の依存に入らない具体版の宣言の一覧で書き直す。使ってよいのは、台帳を初めて置くときと、
# 数える宣言の分類（Connection.lean）を変えたときだけである。届かない宣言を足して検査を通すために使わない。
#
# 使い方（lean/ で check.sh を一度走らせ、unconnected.tsv を作った後）:
#   bash scripts/connection-to-final-theorem/write-ledger.sh
set -euo pipefail
cd "$(dirname "$0")/../.."
dump=.lake/connection-to-final-theorem/unconnected.tsv
[ -f "$dump" ] || { echo "NG: $dump が無い（先に check.sh を走らせる）" >&2; exit 1; }
{
  printf '# 最終定理 Ising2D.onsager_exact_solution_end_to_end の依存に入らない具体版の宣言の既知の一覧。scripts/connection-to-final-theorem/check.sh が読む。\n'
  printf '# 行は減らすだけにする。繋いだか消した宣言の行は同じ回に消す。\n'
  awk -F'\t' '$1 == "UNCONNECTED" { print $2 }' "$dump" | LC_ALL=C sort -u
} > unconnected-concrete-declarations-ledger.txt
echo "$(grep -vc '^#' unconnected-concrete-declarations-ledger.txt) 行を書いた"
