#!/usr/bin/env bash
# 本プロジェクトで実際に証明した定理が sorry に依存していないことを確認する。
#
# 使い方:
#   cd integrable-lattice/lean && ./scripts/check-no-sorry.sh
#
# 終了コード 0 = すべて sorry 非依存。1 = sorryAx への依存またはソース中の sorry を検出。
#
# 方式は exact-solution-of-2d-ising-model/lean/scripts/check-no-sorry.sh と同じ:
#   1. ソース中の sorry / admit を grep で検出する。
#   2. targets に列挙した定理の #print axioms に sorryAx が現れないことを確認する。
# targets には「自分が実際に証明したもの」だけを列挙する。
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

# 1. ソース中に sorry / admit が残っていないか
if grep -rn --include='*.lean' -E '\bsorry\b|\badmit\b' IntegrableLattice.lean IntegrableLattice/; then
  echo "NG: ソース中に sorry / admit が残っている" >&2
  status=1
else
  echo "OK: ソース中に sorry / admit は無い"
fi

# 2. 実際に証明した定理の依存公理に sorryAx が含まれていないか
targets=(
  # 命題 A (3) の切断付値（TruncVal.lean）
  IntegrableLattice.findGreatest_congr
  IntegrableLattice.truncVal
  IntegrableLattice.truncVal_le
  IntegrableLattice.truncVal_congr_of_dvd
  IntegrableLattice.truncVal_eq_min_padicValInt
  # 命題 A（PropA.lean）
  IntegrableLattice.exists_eventually_periodic_pow
  IntegrableLattice.redMat
  IntegrableLattice.exists_eventually_periodic_matrixPow
  IntegrableLattice.exists_eventually_periodic_trace
  IntegrableLattice.exists_eventually_periodic_truncVal
  IntegrableLattice.exists_eventually_periodic_min_padicValInt
  # 命題 L（PropL.lean）
  IntegrableLattice.padicValNat_pow_sub_one_of_dvd
  IntegrableLattice.multOrder_dvd_sub_one
  IntegrableLattice.padicValNat_pow_sub_one_of_not_dvd_order
  IntegrableLattice.padicValNat_pow_sub_one_odd
  IntegrableLattice.padicValNat_two_pow_sub_one_odd_exp
  IntegrableLattice.padicValNat_two_pow_sub_one_even_exp
  # 命題 V（PropV.lean）
  IntegrableLattice.X_pow_char_pow_sub_one
  IntegrableLattice.resultant_X_pow_char_pow_sub_one
  IntegrableLattice.aOne
  IntegrableLattice.aOne_cast_zmod
  IntegrableLattice.dvd_aOne_iff
  IntegrableLattice.aTwoInner
  IntegrableLattice.aTwo
  IntegrableLattice.evalOneOne
  IntegrableLattice.aTwo_cast_zmod
  IntegrableLattice.dvd_aTwo_iff
  # 命題 C の核（PropC.lean）
  IntegrableLattice.dvd_one_add_pow_prime_sub_one
  IntegrableLattice.dvd_pow_prime_pow_sub_one
  IntegrableLattice.pow_prime_pow_eq_one_of_eq_one_add
  IntegrableLattice.matrix_pow_prime_pow_eq_one
)

{
  echo "import IntegrableLattice"
  for t in "${targets[@]}"; do
    echo "#print axioms $t"
  done
} > /tmp/integrable_lattice_axiom_check.lean

out="$(lake env lean --stdin < /tmp/integrable_lattice_axiom_check.lean)"
echo "$out"

if echo "$out" | grep -q 'sorryAx'; then
  echo "NG: sorryAx に依存している定理がある" >&2
  status=1
else
  echo "OK: 列挙した定理はいずれも sorryAx に依存していない"
fi

exit "$status"
