#!/usr/bin/env bash
# 本文の定義・主張・定理の全てに対応する具体版の宣言があり、本文の証明が根拠として引く主張と具体版の証明が使う主張が
# 一致することを確かめる（docs/tasks/lean-end-to-end-runbook.md のゴールラインの条件「一対一」）。
#
# 使い方（lean/ で lake build の後。本文を読むので structured-latex で pnpm install を済ませておく）:
#   bash scripts/text-and-concrete-one-to-one/check.sh
#
# Lean の側はビルド後の環境から書き出す（Dependencies.lean）。本文の側の読み方と突き合わせの規則は compare.ts にある。
# 具体版の宣言とブロックの対応は、本文のブロックの欄 `lean`（具体版の宣言の完全な名前）だけで決める。
# 欄の無いブロックは具体版の宣言を持たないとみなし、NO_CONCRETE_DECLARATION の行に出す。
# 欄の誤りの行（`LEAN_FIELD_` で始まる行。具体版でない名前、二つのブロックの欄に同じ宣言、欄と docstring が別のブロックを指す、
# docstring がブロックを指すのにどの欄にも無い宣言。規則は compare.ts）は台帳に載せられない。出たら欄か docstring を直す。
#
# 既に在る食い違いは lean/text-and-concrete-one-to-one-ledger.txt に一行ずつ載せる（行の形は compare.ts の書き出しと同じ）。
#   - 台帳に無い食い違いが現れたら落ちる。
#   - 台帳にあるのに食い違いでなくなった行（直した行、消えたブロック）が残っていたら落ちる（同じ回に台帳から消す）。
# 台帳の行は減らすだけにする。行を足して通すことはしない。
#
# 終了コード 0 = 台帳と一致。1 = 新しい食い違いか、消し忘れた台帳の行がある。
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

ledger=text-and-concrete-one-to-one-ledger.txt
work=.lake/text-and-concrete-one-to-one
dump="$work/lean.tsv"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

mkdir -p "$work"
rm -f "$dump" "$work/mismatches.tsv" "$work/counts.tsv"
lake env lean "$here/Dependencies.lean"
[ -f "$dump" ] || { echo "NG: 宣言の書き出しが作られなかった" >&2; exit 1; }
node "$here/negative-test.ts"
node "$here/compare.ts" "$dump" ../structured-latex/content "$work/counts.tsv" > "$work/mismatches.tsv"

LC_ALL=C sort -u "$work/mismatches.tsv" > "$tmp/now.txt"
if [ -f "$ledger" ]; then
  { grep -v -e '^#' -e '^$' "$ledger" || true; } | LC_ALL=C sort -u > "$tmp/ledger.txt"
else
  : > "$tmp/ledger.txt"
fi

new="$(LC_ALL=C comm -23 "$tmp/now.txt" "$tmp/ledger.txt")"
stale="$(LC_ALL=C comm -13 "$tmp/now.txt" "$tmp/ledger.txt")"

while IFS=$'\t' read -r k v; do echo "Ising2D: $k: $v"; done < "$work/counts.tsv"
echo "Ising2D: 具体版の宣言が無いブロック: $(grep -c $'^NO_CONCRETE_DECLARATION\t' "$tmp/now.txt" || true)"
echo "Ising2D: docstring が本文に無いラベルを指す具体版の宣言: $(grep -c $'^UNKNOWN_LABEL_IN_DOCSTRING\t' "$tmp/now.txt" || true)"
echo "Ising2D: 本文が引くのに具体版が使わない組: $(grep -c $'^CITED_ONLY_IN_TEXT\t' "$tmp/now.txt" || true)"
echo "Ising2D: 具体版が使うのに本文が引かない組: $(grep -c $'^USED_ONLY_IN_LEAN\t' "$tmp/now.txt" || true)"

status=0
if grep -q '^LEAN_FIELD_' "$tmp/ledger.txt"; then
  echo "NG: 台帳に欄 lean の誤りの行がある（この行は台帳に載せられない。欄を直して台帳から消す）:" >&2
  grep '^LEAN_FIELD_' "$tmp/ledger.txt" >&2
  status=1
fi
if [ -n "$new" ]; then
  echo "NG: 台帳に無い、本文と具体版の食い違いがある（本文に根拠を足すか、具体版を本文の経路に直す）:" >&2
  printf '%s\n' "$new" >&2
  status=1
fi
if [ -n "$stale" ]; then
  echo "NG: 食い違いでなくなった台帳の行がある（$ledger から消す）:" >&2
  printf '%s\n' "$stale" >&2
  status=1
fi
[ "$status" -eq 0 ] && echo "OK: 本文と具体版の食い違いは台帳と一致する"
exit "$status"
