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
  # 命題 C の周期そのものの整除（PropCPeriod.lean）
  IntegrableLattice.eq_natCast_mul_of_castHom_eq_zero
  IntegrableLattice.matrix_eq_natCast_mul_of_map_castHom_eq_zero
  IntegrableLattice.map_pow_castHom
  IntegrableLattice.map_sub_castHom
  IntegrableLattice.map_one_castHom
  IntegrableLattice.matrix_pow_mul_prime_pow_eq_one
  IntegrableLattice.orderOf_dvd_mul_prime_pow
  IntegrableLattice.orderOf_reduction_dvd
  IntegrableLattice.isUnit_pow_add_eq_iff
  IntegrableLattice.isUnit_intCast_of_not_dvd
  IntegrableLattice.isUnit_map_of_not_dvd_det
  # 命題 B の片方向（PropB.lean）。等式ではなく lcm ∣ ord の側だけ
  IntegrableLattice.mulVec_pow_eq_pow_smul
  IntegrableLattice.eigenvalue_pow_eq_one_of_pow_eq_one
  IntegrableLattice.orderOf_eigenvalue_dvd_orderOf
  IntegrableLattice.lcm_orderOf_eigenvalues_dvd_orderOf
  # 命題 B（訂正後）の等式本体と反例（PropBTracePeriod.lean）
  IntegrableLattice.expSum
  IntegrableLattice.eq_zero_of_expSum_pow_eq_zero
  IntegrableLattice.expSum_eventually_periodic_iff
  IntegrableLattice.expSum_eventually_periodic_iff_lcm_dvd
  IntegrableLattice.isLeast_period_expSum
  IntegrableLattice.trace_pow_eventually_periodic_iff_lcm_dvd
  IntegrableLattice.trace_pow_restrict_maxGenEigenspace
  IntegrableLattice.trace_pow_eq_sum_maxGenEigenspace
  IntegrableLattice.finrank_maxGenEigenspace_eq_rootMultiplicity
  IntegrableLattice.trace_pow_eventually_periodic_iff
  IntegrableLattice.natCast_ne_zero_iff_not_dvd
  IntegrableLattice.cexMat
  IntegrableLattice.cexMat_pow_three
  IntegrableLattice.cexMat_ne_one
  IntegrableLattice.orderOf_cexMat
  IntegrableLattice.trace_cexMat_pow
  IntegrableLattice.cexMat_period_ne
  # 命題 N（PropN.lean）: Cayley–Hamilton 由来の下界と、例外集合が無限になる反例
  IntegrableLattice.trace_pow_add_eq_neg_sum
  IntegrableLattice.trace_pow_dvd_of_charpoly_coeff_dvd
  IntegrableLattice.le_padicValInt_trace_pow
  IntegrableLattice.cexN
  IntegrableLattice.cexN_sq
  IntegrableLattice.cexN_pow_add_two
  IntegrableLattice.trace_cexN_pow_add_two
  IntegrableLattice.trace_cexN_pow_even
  IntegrableLattice.trace_cexN_pow_odd
  IntegrableLattice.cexN_exceptional_unbounded
  # 命題 T（PropT.lean）: 段 2 の代数核・奇数性の 2 箇所・段 4 の組合せ核・段 5 の総和
  IntegrableLattice.prod_sub_pow_eq
  IntegrableLattice.prod_A_sub_zeta_eq
  IntegrableLattice.not_dvd_two_mul_of_odd
  IntegrableLattice.padicValNat_two_eq_zero_of_odd
  IntegrableLattice.newton_two_root_valuations
  IntegrableLattice.v2_tau_eq_of_root_valuations
  # 命題 W（PropW.lean）: 非退化性の判定と、閉形式の ν の帰属
  IntegrableLattice.NoProjZero
  IntegrableLattice.torus_nondegenerate_three
  IntegrableLattice.torus_degenerate_two
  IntegrableLattice.exists_proj_zero_of_linear
  IntegrableLattice.quintic_cubic_nondegenerate
  IntegrableLattice.propW_nu_not_integer_of_ell_five_k_three
  # 命題 C′ と cycle 19 の定理 A′（PropCTracePeriod.lean）
  IntegrableLattice.TraceOrth
  IntegrableLattice.tr_natCast_pow_mul
  IntegrableLattice.traceOrth_pow_succ
  IntegrableLattice.traceOrth_one_add_pow
  IntegrableLattice.traceOrth_of_forall_pow
  IntegrableLattice.IsTracePeriodAt
  IntegrableLattice.isTracePeriodAt_mul_prime
  IntegrableLattice.dvd_of_mulVec_dvd
  IntegrableLattice.luc
  IntegrableLattice.luc_add_two
  IntegrableLattice.luc_add_three
  IntegrableLattice.luc2
  IntegrableLattice.luc2_periodic
  IntegrableLattice.luc2_mod_three
  IntegrableLattice.two_pow_mod_three
  IntegrableLattice.lucas_period_one_level_one
  IntegrableLattice.lucas_two_power_not_period
  IntegrableLattice.orderOf_three_zmod_two
  IntegrableLattice.orderOf_three_zmod_four
  IntegrableLattice.orderOf_three_zmod_eight
  IntegrableLattice.orderOf_three_zmod_sixteen
  IntegrableLattice.trace_period_not_affine
  # 定理 J2（桁定理）と命題 J2′（DigitTheorem.lean, cycle 19 step 1 §2）
  IntegrableLattice.digit_mod_pow
  IntegrableLattice.choose_cast_eq_prod
  IntegrableLattice.choose_cast_of_lt
  IntegrableLattice.choose_cast_pow
  IntegrableLattice.choose_cast_pow_succ
  IntegrableLattice.Abar
  IntegrableLattice.Bbar
  IntegrableLattice.Abar_one
  IntegrableLattice.Abar_shift_lt
  IntegrableLattice.Abar_shift
  IntegrableLattice.Abar_mod
  IntegrableLattice.Abar_congr
  IntegrableLattice.Abar_shift_pow_succ
  IntegrableLattice.Bbar_diag
  IntegrableLattice.cexDigitS
  IntegrableLattice.cexDigit_A1_ne_zero
  IntegrableLattice.cexDigit_fails
  IntegrableLattice.cexDigit_lt_holds
  # 命題 8・定理 X′（BouquetClosedForm.lean, cycle 19 step 2 §5）
  IntegrableLattice.bouquet_cases_exclusive
  IntegrableLattice.diagCard
  IntegrableLattice.oneZeroCard
  IntegrableLattice.genericCard
  IntegrableLattice.card_diag_three
  IntegrableLattice.card_diag_five
  IntegrableLattice.card_diag_seven
  IntegrableLattice.card_one_zero_three
  IntegrableLattice.card_one_zero_five
  IntegrableLattice.card_one_zero_seven
  IntegrableLattice.card_generic_three
  IntegrableLattice.card_generic_five
  IntegrableLattice.card_generic_seven
  IntegrableLattice.card_diag_two
  IntegrableLattice.card_generic_two
  IntegrableLattice.levelA
  IntegrableLattice.sum_level_A
  IntegrableLattice.sum_pow_rev
  IntegrableLattice.pow_split
  IntegrableLattice.sum_level_B
  IntegrableLattice.ordKappa_of_sigma
  IntegrableLattice.theoremJ8_eq_XPrime
  IntegrableLattice.cycle19_5_4_example_mismatch
  # 定理 J6・J7・J8（TowerTypeCoefficients.lean, cycle 19 step 1 §5）
  IntegrableLattice.sum_level_stab
  IntegrableLattice.level_ratio_indep
  IntegrableLattice.layer_sum
  IntegrableLattice.sum_mul_pow
  IntegrableLattice.J8_direction_sum
  IntegrableLattice.sum_Theta_J8
  IntegrableLattice.ordKappa_J8
  IntegrableLattice.J6_no_n_pow_term
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
