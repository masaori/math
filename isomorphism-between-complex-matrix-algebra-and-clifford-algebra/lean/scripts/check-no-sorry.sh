#!/usr/bin/env bash
# 形式化した宣言が sorry に依存していないことを確かめる。
#
# 使い方:
#   cd isomorphism-between-complex-matrix-algebra-and-clifford-algebra/lean && bash scripts/check-no-sorry.sh
#
# 終了コード 0 = 全検査通過。1 = 検査の失敗。
set -euo pipefail

cd "$(dirname "$0")/.."

# lake は elan 経由で入るため、非対話シェルの PATH に無いことがある。
if ! command -v lake >/dev/null 2>&1; then
  if [ -x "$HOME/.elan/bin/lake" ]; then
    PATH="$HOME/.elan/bin:$PATH"
    export PATH
  else
    echo "NG: lake が見つからない（elan を導入し PATH を通すこと）" >&2
    exit 1
  fi
fi

status=0
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

# 1. どの .lean も入口から import されていること（import されないファイルはビルドも検査もされない）。
find CliffordMatrixIsomorphism -name '*.lean' | sort > "$tmp/files.txt"
sed -n 's/^import \(CliffordMatrixIsomorphism\..*\)$/\1/p' CliffordMatrixIsomorphism.lean |
  sed 's#\.#/#g; s#$#.lean#' | sort > "$tmp/imports.txt"
orphans="$(comm -23 "$tmp/files.txt" "$tmp/imports.txt")"
if [ -n "$orphans" ]; then
  echo "NG: 入口 CliffordMatrixIsomorphism.lean から import されていない .lean がある:" >&2
  printf '%s\n' "$orphans" >&2
  status=1
else
  echo "OK: すべての .lean が入口から import されている"
fi

# 2. ソース中に sorry / admit が残っていないか。
if grep -rn --include='*.lean' -E '\bsorry\b|\badmit\b' CliffordMatrixIsomorphism.lean CliffordMatrixIsomorphism/; then
  echo "NG: ソース中に sorry / admit が残っている" >&2
  status=1
else
  echo "OK: ソース中に sorry / admit は無い"
fi

# 3. 名前空間 CliffordMatrixIsomorphism のすべての宣言について、依存する公理に sorryAx が無いこと。
#    宣言の一覧を手で保つと追加漏れが検査の穴になるので、環境から全部を拾う。
cat > "$tmp/CheckAxioms.lean" <<'LEAN'
import CliffordMatrixIsomorphism
open Lean Elab Command

elab "#check_no_sorry_in_project" : command => do
  let env ← getEnv
  let mut count : Nat := 0
  let mut bad : Array Name := #[]
  for (n, _) in env.constants.toList do
    if (`CliffordMatrixIsomorphism).isPrefixOf n && !n.isInternal then
      count := count + 1
      let axs ← liftCoreM (Lean.collectAxioms n)
      if axs.contains ``sorryAx then
        bad := bad.push n
  if bad.isEmpty then
    logInfo m!"OK: {count} 個の宣言のどれも sorryAx に依存しない"
  else
    logError m!"NG: sorryAx に依存する宣言: {bad}"

#check_no_sorry_in_project
LEAN
if out="$(lake env lean "$tmp/CheckAxioms.lean" 2>&1)"; then
  echo "$out"
  if ! echo "$out" | grep -q '^.*OK: '; then
    status=1
  fi
else
  echo "$out" >&2
  status=1
fi

exit "$status"
