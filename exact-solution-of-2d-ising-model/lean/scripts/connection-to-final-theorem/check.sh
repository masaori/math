#!/usr/bin/env bash
# 具体版の宣言が全て、ただ一つの最終定理 `Ising2D.onsager_exact_solution_end_to_end` の依存に入っていることを確かめる
# （docs/tasks/lean-end-to-end-runbook.md のゴールラインの条件「繋がり」）。
#
# 使い方（lean/ で lake build の後）:
#   bash scripts/connection-to-final-theorem/check.sh
#
# 見るのはビルド後の Lean の環境で、最終定理から主張・本体・構成子を推移的にたどった依存である。
# 数える宣言の分類（具体版だけ。必要十分版・導出・RoutesNotAdopted を除く）は Connection.lean にある。
#
# 既に在る、届かない具体版の宣言は lean/unconnected-concrete-declarations-ledger.txt に一行ずつ載せる。
#   - 台帳に無い、届かない宣言が現れたら落ちる（繋がらない具体版を新しく足さない）。
#   - 台帳にあるのに届くようになった行（または消えた宣言の行）が残っていたら落ちる（直したら同じ回に台帳から消す）。
# 台帳の行は減らすだけにする。行を足して通すことはしない。
#
# 終了コード 0 = 台帳と一致。1 = 新しく繋がらない宣言か、消し忘れた台帳の行がある。
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

ledger=unconnected-concrete-declarations-ledger.txt
work=.lake/connection-to-final-theorem
dump="$work/unconnected.tsv"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

mkdir -p "$work"
rm -f "$dump"
lake env lean "$here/Connection.lean"
[ -f "$dump" ] || { echo "NG: 依存の書き出しが作られなかった" >&2; exit 1; }

awk -F'\t' '$1 == "UNCONNECTED" { print $2 }' "$dump" | LC_ALL=C sort -u > "$tmp/now.txt"
total="$(awk -F'\t' '$1 == "TOTAL" { print $2 }' "$dump")"
if [ -f "$ledger" ]; then
  { grep -v -e '^#' -e '^$' "$ledger" || true; } | LC_ALL=C sort -u > "$tmp/ledger.txt"
else
  : > "$tmp/ledger.txt"
fi

new="$(LC_ALL=C comm -23 "$tmp/now.txt" "$tmp/ledger.txt")"
stale="$(LC_ALL=C comm -13 "$tmp/now.txt" "$tmp/ledger.txt")"

echo "Ising2D: 数えた具体版の宣言: $total"
echo "Ising2D: 最終定理の依存に入らない具体版の宣言: $(wc -l < "$tmp/now.txt" | tr -d ' ')"
echo "Ising2D: 宣言が一つも最終定理の依存に入らないモジュール: $(grep -c $'^MODULE_WITHOUT_CONNECTED\t' "$dump" || true)"

status=0
if [ -n "$new" ]; then
  echo "NG: 台帳に無い、最終定理の依存に入らない具体版の宣言がある:" >&2
  printf '%s\n' "$new" >&2
  echo "宣言のモジュールは $(pwd)/$dump にある。" >&2
  status=1
fi
if [ -n "$stale" ]; then
  echo "NG: 最終定理の依存に入るようになったか、消えた宣言の台帳の行がある（$ledger から消す）:" >&2
  printf '%s\n' "$stale" >&2
  status=1
fi
[ "$status" -eq 0 ] && echo "OK: 最終定理の依存に入らない具体版の宣言は台帳と一致する"
exit "$status"
