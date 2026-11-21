#!/usr/bin/env bash
# 台帳を、いまの本文と具体版の食い違いの一覧で書き直す。使ってよいのは、台帳を初めて置くときと、
# 突き合わせの規則（Dependencies.lean・compare.ts）を変えたときだけである。新しい食い違いを足して検査を通すために使わない。
#
# 使い方（lean/ で check.sh を一度走らせ、mismatches.tsv を作った後）:
#   bash scripts/text-and-concrete-one-to-one/write-ledger.sh
set -euo pipefail
cd "$(dirname "$0")/../.."
dump=.lake/text-and-concrete-one-to-one/mismatches.tsv
[ -f "$dump" ] || { echo "NG: $dump が無い（先に check.sh を走らせる）" >&2; exit 1; }
{
  printf '# 本文のブロックと具体版の宣言の既知の食い違いの一覧。scripts/text-and-concrete-one-to-one/check.sh が読む。\n'
  printf '# NO_CONCRETE_DECLARATION <ブロック>: 対応する具体版の宣言が無い。\n'
  printf '# UNKNOWN_LABEL_IN_DOCSTRING <具体版の宣言> <語>: docstring の先頭の太字が本文に無いラベルを指す。\n'
  printf '# CITED_ONLY_IN_TEXT <ブロック> <主張>: 本文の証明か主張が引くのに具体版の証明が使わない。\n'
  printf '# USED_ONLY_IN_LEAN <ブロック> <主張>: 具体版の証明が使うのに本文の証明も主張も引かない。\n'
  printf '# 行は減らすだけにする。直した行は同じ回に消す。\n'
  LC_ALL=C sort -u "$dump"
} > text-and-concrete-one-to-one-ledger.txt
echo "$(grep -vc '^#' text-and-concrete-one-to-one-ledger.txt) 行を書いた"
