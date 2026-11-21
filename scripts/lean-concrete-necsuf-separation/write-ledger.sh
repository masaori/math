#!/usr/bin/env bash
# 台帳を、いまの違反の一覧で書き直す。使ってよいのは、プロジェクトに台帳を初めて置くときと、
# 分類の決まり（Separation.lean.in）を変えたときだけである。違反を足して検査を通すために使わない。
#
# 使い方（check.sh を一度走らせ、dependencies.tsv を作った後）:
#   bash scripts/lean-concrete-necsuf-separation/write-ledger.sh <プロジェクト>/lean
set -euo pipefail
cd "$1"
dump=.lake/concrete-necsuf-separation/dependencies.tsv
[ -f "$dump" ] || { echo "NG: $dump が無い（先に check.sh を走らせる）" >&2; exit 1; }
{
  printf '# 具体版と必要十分版の分離の既知の違反。scripts/lean-concrete-necsuf-separation/check.sh（リポジトリ直下）が読む。\n'
  printf '# DEP 行は「使う側の分類・使う側の宣言」、IMPORT 行は「取り込む側の分類・モジュール・取り込まれる側の分類・モジュール」。\n'
  printf '# 行は減らすだけにする。直して違反でなくなった行は同じ回に消す。\n'
  {
    awk -F'\t' '$1 == "DEP" { print "DEP\t" $2 "\t" $3 }' "$dump"
    awk -F'\t' '$1 == "IMPORT"' "$dump"
  } | LC_ALL=C sort -u
} > concrete-necsuf-separation-ledger.txt
echo "$(grep -vc '^#' concrete-necsuf-separation-ledger.txt) 行を書いた"
