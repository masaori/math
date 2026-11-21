#!/usr/bin/env bash
# 具体版と必要十分版が、定数の依存でもモジュールの import でも互いを参照していないことを確かめる。
#
# 使い方（lake build の後）:
#   cd exact-solution-of-2d-ising-model-lambda/lean && bash scripts/check-concrete-necsuf-separation.sh
#
# 見るのはビルド後の Lean の環境で、各定数の主張と本体が直接使う定数である。ソースの字面ではないので、
# 定義を介した依存・型の中の依存・開いた名前空間からの修飾なしの呼び出しも拾う。
# 推移的な依存は、途中の宣言の直接の依存として必ずどこかに現れる。
#
# 許すのは導出（`*FromNecSuf.lean` と `*_from_necSuf`）が両方を使うことだけである。
# 既に在る違反は台帳 concrete-necsuf-separation-ledger.txt に一行ずつ載せてある。
#   - 台帳に無い違反が現れたら落ちる（新しく混ぜない）。
#   - 台帳にあるのに違反でなくなった行が残っていたら落ちる（直したら同じ回に台帳から消す）。
# 台帳の行は減らすだけにする。行を足して通すことはしない。
#
# 終了コード 0 = 台帳と一致。1 = 新しい違反か、消し忘れた台帳の行がある。
set -euo pipefail

cd "$(dirname "$0")/.."

if ! command -v lake >/dev/null 2>&1; then
  if [ -x "$HOME/.elan/bin/lake" ]; then
    PATH="$HOME/.elan/bin:$PATH"
    export PATH
  else
    echo "NG: lake が見つからない（elan を導入し PATH を通すこと）" >&2
    exit 1
  fi
fi

ledger=concrete-necsuf-separation-ledger.txt
dump=.lake/concrete-necsuf-separation.tsv
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

rm -f "$dump"
lake env lean scripts/ConcreteNecSufSeparation.lean
# 台帳が無ければ作らずに落とす（空の台帳と区別する）。
[ -f "$ledger" ] || { echo "NG: 台帳 $ledger が無い" >&2; exit 1; }
[ -f "$dump" ] || { echo "NG: 依存の書き出しが作られなかった" >&2; exit 1; }

# 定数の違反は使う側の宣言ごとに一行、import の違反はモジュールの組ごとに一行にする。
{
  awk -F'\t' '$1 == "DEP" { print "DEP\t" $2 "\t" $3 }' "$dump"
  awk -F'\t' '$1 == "IMPORT"' "$dump"
} | LC_ALL=C sort -u > "$tmp/now.txt"
{ grep -v -e '^#' -e '^$' "$ledger" || true; } | LC_ALL=C sort -u > "$tmp/ledger.txt"

new="$(LC_ALL=C comm -23 "$tmp/now.txt" "$tmp/ledger.txt")"
stale="$(LC_ALL=C comm -13 "$tmp/now.txt" "$tmp/ledger.txt")"

count() { grep -c "$1" "$tmp/now.txt" || true; }
echo "具体版が必要十分版か導出を使う宣言: $(count $'^DEP\tconcrete')"
echo "必要十分版が具体版か導出を使う宣言: $(count $'^DEP\tnecsuf')"
echo "具体版のモジュールが必要十分版か導出を import する組: $(count $'^IMPORT\tconcrete')"
echo "必要十分版のモジュールが具体版か導出を import する組: $(count $'^IMPORT\tnecsuf')"

status=0
if [ -n "$new" ]; then
  echo "NG: 台帳に無い違反がある（具体版と必要十分版を新しく混ぜた）:" >&2
  printf '%s\n' "$new" >&2
  echo "使われている側は $dump の DEP 行の第 5 列にある。" >&2
  status=1
fi
if [ -n "$stale" ]; then
  echo "NG: 違反でなくなった台帳の行がある（直したら $ledger から消す）:" >&2
  printf '%s\n' "$stale" >&2
  status=1
fi
[ "$status" -eq 0 ] && echo "OK: 違反は台帳と一致する"
exit "$status"
