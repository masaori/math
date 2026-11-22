#!/usr/bin/env bash
# 必要十分版の仮定のうち、証明で使わないものを主張ごとに並べ、台帳と突き合わせる（lean/ で lake build の後に打つ）。
# 一覧は lean/.lake/necsuf-unused-assumptions/report.tsv に書く。
# 台帳 lean/necsuf-unused-assumptions-ledger.txt に無い行（新しく使わない仮定を足した）も、
# 台帳に在るのに一覧から消えた行（絞ったのに台帳から消していない）も落ちる。台帳の行は減らすだけにする。
set -euo pipefail
cd "$(dirname "$0")/../.."
if ! command -v lake >/dev/null 2>&1 && [ -x "$HOME/.elan/bin/lake" ]; then PATH="$HOME/.elan/bin:$PATH"; fi
lake env lean scripts/necsuf-unused-assumptions/Audit.lean
node scripts/necsuf-unused-assumptions/aggregate.ts .

ledger=necsuf-unused-assumptions-ledger.txt
report=.lake/necsuf-unused-assumptions/report.tsv
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
{ grep -v -e '^$' "$report" || true; } | LC_ALL=C sort -u > "$tmp/now.txt"
if [ -f "$ledger" ]; then
  # 台帳の行は「ラベル<TAB>種類<TAB>仮定」。# で始まる行は理由の注記で、行の末尾の「<TAB># …」も注記として外す。
  { grep -v -e '^#' -e '^$' "$ledger" || true; } | sed 's/\t#.*$//' | LC_ALL=C sort -u > "$tmp/ledger.txt"
else
  : > "$tmp/ledger.txt"
fi
new="$(LC_ALL=C comm -23 "$tmp/now.txt" "$tmp/ledger.txt")"
stale="$(LC_ALL=C comm -13 "$tmp/now.txt" "$tmp/ledger.txt")"
echo "使わない仮定の行: $(wc -l < "$tmp/now.txt")（台帳: $(wc -l < "$tmp/ledger.txt")）"
status=0
if [ -n "$new" ]; then
  echo "NG: 台帳に無い使わない仮定がある（必要十分版に証明で使わない仮定を足した）:" >&2
  printf '%s\n' "$new" >&2
  status=1
fi
if [ -n "$stale" ]; then
  echo "NG: 使わない仮定でなくなった台帳の行がある（絞ったら $ledger から消す）:" >&2
  printf '%s\n' "$stale" >&2
  status=1
fi
[ "$status" -eq 0 ] && echo "OK: 使わない仮定は台帳と一致する"
exit "$status"
