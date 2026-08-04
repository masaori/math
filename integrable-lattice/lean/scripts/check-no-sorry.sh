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
  # 定理 L1・系 L2（DigitBranchRecursion.lean, cycle 20 step 1）
  IntegrableLattice.sigma_eq_of_max
  IntegrableLattice.exists_sigma_ne_zero
  IntegrableLattice.exists_sigma_ne_zero_lt
  IntegrableLattice.one_add_X_pow_split
  IntegrableLattice.branch_decomposition
  IntegrableLattice.coeff_branch_single
  IntegrableLattice.coeff_branch_sum
  IntegrableLattice.coeff_branch_lt
  IntegrableLattice.exists_coeff_ne_zero_of_branches
  IntegrableLattice.L1_bound
  IntegrableLattice.geom_sum_one_add_X_pow_char
  # 定理 W3・補題 W2・系 W6（SInfinityDecision.lean, cycle 20 step 2）
  IntegrableLattice.SInfinity.bucketVanish_iff
  IntegrableLattice.SInfinity.psi_chi_perp_sub_one
  IntegrableLattice.SInfinity.psi_eq_zero_of_dvd
  IntegrableLattice.SInfinity.psi_coeff
  IntegrableLattice.SInfinity.torus_diag
  IntegrableLattice.SInfinity.torus_anti
  IntegrableLattice.SInfinity.torus_not_e1
  IntegrableLattice.SInfinity.torus_Sinf_candidates
  IntegrableLattice.SInfinity.fam3_e1
  IntegrableLattice.SInfinity.fam3_not_diag
  IntegrableLattice.SInfinity.fam3_Sinf_singleton
  # 定理 Y′・系 Y″（EllTwoClosedForm.lean, cycle 20 step 3）
  IntegrableLattice.EllTwo.Aalpha_seq
  IntegrableLattice.EllTwo.Abeta_seq
  IntegrableLattice.EllTwo.Bsat_seq
  IntegrableLattice.EllTwo.B_seq
  IntegrableLattice.EllTwo.four_cases_distinct_at_three
  IntegrableLattice.EllTwo.caseA_or_caseB
  IntegrableLattice.EllTwo.not_caseA_and_caseB
  IntegrableLattice.EllTwo.lam0_ge_one
  IntegrableLattice.EllTwo.w_ge_one_of_lam1_one
  IntegrableLattice.EllTwo.Bsat_one_eq_B_one_add
  IntegrableLattice.EllTwo.Bsat_ne_B_at_one
  IntegrableLattice.EllTwo.Aalpha_one_eq_B_one
  IntegrableLattice.EllTwo.Abeta_one_eq_B_one
  IntegrableLattice.EllTwo.B_eq_Xprime
  IntegrableLattice.EllTwo.Aalpha_eq_Xprime_at_one_two
  IntegrableLattice.EllTwo.Aalpha_ne_Xprime_at_three
  IntegrableLattice.EllTwo.Abeta_ne_Xprime_at_two
  IntegrableLattice.EllTwo.Bsat_ne_Xprime_at_two
  # 定理 Q1（DropAssumptionBStar.lean, cycle 21 step 1）
  IntegrableLattice.DropBStar.unique_min_of_val_seq
  IntegrableLattice.DropBStar.min_eq_theta
  IntegrableLattice.DropBStar.BG_dominates
  IntegrableLattice.DropBStar.totient_pow_mul_pow
  IntegrableLattice.DropBStar.sum_totient_pow
  IntegrableLattice.DropBStar.layer_card_sum
  IntegrableLattice.DropBStar.lemma_Q3
  IntegrableLattice.DropBStar.lemma_Q3_old_formula_false
  IntegrableLattice.DropBStar.lemma_Q3_diff
  IntegrableLattice.DropBStar.lemma_Q5_rho_max
  IntegrableLattice.DropBStar.lemma_Q5_needs_strict
  IntegrableLattice.DropBStar.lemma_Q5_card
  IntegrableLattice.DropBStar.theorem_Q1_error
  IntegrableLattice.DropBStar.theorem_Q1_error_explicit
  # 定理 G4（GeneralTowerClosedForm.lean, cycle 21 step 2）
  IntegrableLattice.GeneralTower.S0_closed
  IntegrableLattice.GeneralTower.S1_closed
  IntegrableLattice.GeneralTower.S0_decomp
  IntegrableLattice.GeneralTower.S1_decomp
  IntegrableLattice.GeneralTower.theorem_G1
  IntegrableLattice.GeneralTower.theorem_G1_remark_2_2
  IntegrableLattice.GeneralTower.theorem_G1_e_indep
  IntegrableLattice.GeneralTower.twisted_unique_min
  IntegrableLattice.GeneralTower.twisted_unique_min_k_zero
  IntegrableLattice.GeneralTower.K_wellDefined
  IntegrableLattice.GeneralTower.K_zero_iff
  IntegrableLattice.GeneralTower.K_ge_one_of_ell_two
  IntegrableLattice.GeneralTower.K_ge_one_of_jstar_large
  IntegrableLattice.GeneralTower.K_example_ell_three
  IntegrableLattice.GeneralTower.G3_positivity
  IntegrableLattice.GeneralTower.G3_two_levels
  IntegrableLattice.GeneralTower.sum_totient_Ico
  IntegrableLattice.GeneralTower.layer_b_boundary
  IntegrableLattice.GeneralTower.theorem_G4_b
  IntegrableLattice.GeneralTower.theorem_G4_c
  IntegrableLattice.GeneralTower.G4_K_dependence
  # 定理 D1–D6・命題 D1a（CoefficientsDE.lean, cycle 23 step 4）
  IntegrableLattice.CoeffsDE.D1_d_formula
  IntegrableLattice.CoeffsDE.D1_c_bracket
  IntegrableLattice.CoeffsDE.D1_c_alpha_term
  IntegrableLattice.CoeffsDE.D1_d_integer
  IntegrableLattice.CoeffsDE.D1_d_empty
  IntegrableLattice.CoeffsDE.totient_step
  IntegrableLattice.CoeffsDE.D1a_d_invariant
  IntegrableLattice.CoeffsDE.D1a_c_invariant
  IntegrableLattice.CoeffsDE.D1a_Lambda_step
  IntegrableLattice.CoeffsDE.Tdef_Mstar_indep
  IntegrableLattice.CoeffsDE.D2_residual
  IntegrableLattice.CoeffsDE.D2_equiv_forward_false
  IntegrableLattice.CoeffsDE.D2_equiv_corrected
  IntegrableLattice.CoeffsDE.expand_at_one_plus_x
  IntegrableLattice.CoeffsDE.D3_stage_poly
  IntegrableLattice.CoeffsDE.D3_d_formula
  IntegrableLattice.CoeffsDE.D3_bracket
  IntegrableLattice.CoeffsDE.D3_c_formula
  IntegrableLattice.CoeffsDE.D3_theta_case_split
  IntegrableLattice.CoeffsDE.D3_values
  IntegrableLattice.CoeffsDE.D3_e_values
  IntegrableLattice.CoeffsDE.D3_ell2_torus_values
  IntegrableLattice.CoeffsDE.D3_p_eq_one_convention
  IntegrableLattice.CoeffsDE.V2_mul_odd
  IntegrableLattice.CoeffsDE.D4_congruence
  IntegrableLattice.CoeffsDE.D4_valuations
  IntegrableLattice.CoeffsDE.D4_Lambda_sum_shift
  IntegrableLattice.CoeffsDE.D4_c_shift
  IntegrableLattice.CoeffsDE.D4_d_invariant
  IntegrableLattice.CoeffsDE.D5_stage_poly
  IntegrableLattice.CoeffsDE.D5_val_facts
  IntegrableLattice.CoeffsDE.D5_V2
  IntegrableLattice.CoeffsDE.D5_theta_flip
  IntegrableLattice.CoeffsDE.D5_d_shift
  IntegrableLattice.CoeffsDE.D6_truncation
  IntegrableLattice.CoeffsDE.D6_boundary_sharp

  # cycle 24 step 5: cycle 24 step 1 の訂正の検算（Cycle24Corrections.lean）
  IntegrableLattice.Cycle24.D2_level_iff
  IntegrableLattice.Cycle24.D2_level_zero_iff
  IntegrableLattice.Cycle24.D2_all_iff_no_transient
  IntegrableLattice.Cycle24.D2_no_transient_imp_Tdef_zero
  IntegrableLattice.Cycle24.D3_conv_p_eq_one
  IntegrableLattice.Cycle24.D3_conv_p_ne_one
  IntegrableLattice.Cycle24.D5_conv_t_eq_q
  IntegrableLattice.Cycle24.D3_conv_c_p_eq_one
  IntegrableLattice.Cycle24.D3_old_conv_c_broken
  IntegrableLattice.Cycle24.G4_cond2_corrected_at_61
  IntegrableLattice.Cycle24.G4_cond2_empty_layer_ok
  IntegrableLattice.Cycle24.G4_note42_d_side_totient
  IntegrableLattice.Cycle24.G4_note42_c_side
  IntegrableLattice.Cycle24.Q5_c1_strict_of_logb
  IntegrableLattice.Cycle24.Q5_c1_exists_nat
  IntegrableLattice.Cycle24.Q5_c1_nat_least
  IntegrableLattice.Cycle24.Q1_C_corrected
  IntegrableLattice.Cycle24.G4_cond_all_at_61
  IntegrableLattice.Cycle24.Q5_logb_junk_at_b_zero
  IntegrableLattice.Cycle24.Q5_c1_zero_b
  IntegrableLattice.Cycle24.G2_cond32_sum_form_top
  IntegrableLattice.Cycle24.G2_cond32_sum_form_finite
  # cycle 24 step 5: まだ通していなかった定理群
  IntegrableLattice.Cycle24.corollary_G6
  IntegrableLattice.Cycle24.corollary_G6_c_as_Theta
  IntegrableLattice.Cycle24.Q7_char2_factorization
  IntegrableLattice.Cycle24.Q7_char2_binomial_form
  IntegrableLattice.Cycle24.Q7_b_eq_two
  # cycle 25 step 3: 訂正後の補題 Q5 の c_1（Cycle25Corrections.lean）
  IntegrableLattice.Cycle25.C1Set
  IntegrableLattice.Cycle25.Q5_c1_isLeast
  IntegrableLattice.Cycle25.Q5_c1_unique
  IntegrableLattice.Cycle25.Q5_c1_zero_of_b_zero
  IntegrableLattice.Cycle25.c1_isLeast_of
  IntegrableLattice.Cycle25.Q5_c1_table_check
  IntegrableLattice.Cycle25.Q5_old_logb_value_at_b_zero
  IntegrableLattice.Cycle25.Q5_old_junk_not_least
  IntegrableLattice.Cycle25.Q5_b_zero_iff_r_zero
  IntegrableLattice.Cycle25.Q5_BM_empty_of_b_zero
  IntegrableLattice.Cycle25.Q5_rho_max_of_isLeast
  IntegrableLattice.Cycle25.Q5_rho_max_at_top_layer
  IntegrableLattice.Cycle25.Q5_case_split
  IntegrableLattice.Cycle25.Q5_c1_new_le_old
  IntegrableLattice.Cycle25.Q1_C_mono_in_c1
  IntegrableLattice.Cycle25.Q1_C_at_b_zero
  IntegrableLattice.Cycle25.Q1_b_zero_matches_layer_count
  # cycle 25 step 3: 定理 G2 (3.2) の規約
  IntegrableLattice.Cycle25.G2_minEmpty_iff_ell_ge_four
  IntegrableLattice.Cycle25.G2_minEmpty_breaks_at_ell_three
  IntegrableLattice.Cycle25.G2_minEmpty_ok_at_ell_five_seven
  IntegrableLattice.Cycle25.G2_top_reading_ok_at_ell_three
  # cycle 25 step 3: 本文（命題 M・U）と根拠 report の照合
  IntegrableLattice.Cycle25.U1_c_from_M3_M4
  IntegrableLattice.Cycle25.U1_d_from_M3_M4
  IntegrableLattice.Cycle25.U2_bracket_eq_Tdef
  IntegrableLattice.Cycle25.U4_c_at_ell_two
  IntegrableLattice.Cycle25.U4_d_at_ell_two
  IntegrableLattice.Cycle25.U4_p_one_values
  IntegrableLattice.Cycle25.U4_p_three_values
  IntegrableLattice.Cycle25.U4_c_same_d_differs
  IntegrableLattice.Cycle25.M2_lambda_eq_ceil_logb
  IntegrableLattice.Cycle25.U6_trunc_determines_stage_data
  # cycle 25 step 3: まだ通していなかったもの
  IntegrableLattice.Cycle25.sum_of_uniform_fibers
  IntegrableLattice.Cycle25.Agen_level_indep
  # --- cycle 26 step 6: 命題 G′ の**証明そのもの**の検算（Cycle26ProofSteps.lean）---
  IntegrableLattice.phi_pow_ge
  IntegrableLattice.line_hypothesis_suffices
  IntegrableLattice.sum_phi_pow_prime
  IntegrableLattice.line_contribution
  IntegrableLattice.level_ratio
  IntegrableLattice.g3_coefficients_match
  IntegrableLattice.gprime3_hypothesis_holds
  IntegrableLattice.junk_reading_excludes_ell_three
  IntegrableLattice.junk_reading_keeps_five_and_seven
  # cycle 27 step 2（未検算だった 6 命題の証明ステップ + step 1 が本文へ入れた議論）
  IntegrableLattice.gpp1_both_even
  IntegrableLattice.gpp1_not_both_four
  IntegrableLattice.gpp1_lambda_ne
  IntegrableLattice.gpp1_st_not_both_ge
  IntegrableLattice.sigma_ne_zero_of_lambda_ne_zero
  IntegrableLattice.k5_argmin_unique_above
  IntegrableLattice.r0_add_one_comm
  IntegrableLattice.r0_empty_case
  IntegrableLattice.lambda_u_at_zero
  IntegrableLattice.lambda_u_eq_succ_log
  IntegrableLattice.K_set_nonempty
  IntegrableLattice.K_set_bounded
  IntegrableLattice.u_ell2_four_dvd_iff
  IntegrableLattice.u_ell2_two_dvd
  IntegrableLattice.u_ell2_junk_reading_differs
  IntegrableLattice.u4_ell2_five_coefficients
  IntegrableLattice.u1_d_empty_case
  IntegrableLattice.j1_freshman_dream
  IntegrableLattice.w_lifting_step
  IntegrableLattice.w_lifting_pow
  IntegrableLattice.w_lifting_pow_specializes
  # cycle 28 step 1: 命題 W* の微分の段と付値の段（PropWStarDifferent.lean）
  IntegrableLattice.derivative_prod_pow
  IntegrableLattice.ceilDivNat
  IntegrableLattice.ceilDivNat_le_iff
  IntegrableLattice.isLeast_wStar
  IntegrableLattice.wStar_eq_zero_of_unramified
  IntegrableLattice.wStar_le_of_tame
  # cycle 28 step 1: 命題 F の「非可算な添字集合が有限に落ちる」段（PropFFiniteSupport.lean）
  IntegrableLattice.exists_ne_of_fibers_sum_eq_zero
  IntegrableLattice.vecGcd
  IntegrableLattice.prim
  IntegrableLattice.vecGcd_dvd
  IntegrableLattice.eq_vecGcd_mul_prim
  IntegrableLattice.isUnit_vecGcd_prim
  IntegrableLattice.directions
  IntegrableLattice.mem_directions_of_fibers_sum_eq_zero
  # cycle 28 step 4: 検査 M の「構成から空でない」の裏取り（ExtremumNonempty.lean）
  IntegrableLattice.range_nonempty_of_one_le
  IntegrableLattice.digit_range_nonempty
  IntegrableLattice.Icc_zero_nonempty
  IntegrableLattice.nat_index_nonempty
  IntegrableLattice.fin_nonempty_of_one_le
  IntegrableLattice.support_nonempty_of_ne_zero
  IntegrableLattice.mv_support_nonempty_of_ne_zero
  IntegrableLattice.exists_pow_gt
  IntegrableLattice.exists_root_of_one_le_natDegree
  # cycle 28 step 5: 救済 PR #69 から移植した「最終周期の最小値＝orderOf」の段
  IntegrableLattice.isLeast_eventualPeriod
  IntegrableLattice.isOfFinOrder_of_isUnit_of_finite
  IntegrableLattice.isLeast_eventualPeriod_reduction
  # cycle 29 step 1: 命題 C′ の上界の組み立てと命題 C″ の (2)(4)（TracePeriodAssembly.lean）
  IntegrableLattice.isPeriodMod_zero
  IntegrableLattice.IsPeriodMod.add
  IntegrableLattice.IsPeriodMod.nsmul
  IntegrableLattice.IsPeriodMod.sub_right
  IntegrableLattice.dvd_of_isLeast_isPeriodMod
  IntegrableLattice.isTracePeriodAt_iff_isPeriodMod
  IntegrableLattice.isTracePeriodAt_of_le
  IntegrableLattice.isTracePeriodAt_iterate
  IntegrableLattice.dvd_of_isLeast_tracePeriod
  IntegrableLattice.tracePeriod_dvd_of_le
  IntegrableLattice.tracePeriod_dvd_pow_mul
  IntegrableLattice.tracePeriod_propC_bound
  IntegrableLattice.tThree_five
  IntegrableLattice.tThree_six
  IntegrableLattice.tThree_values
  IntegrableLattice.no_affine_trace_period_exponent
  # cycle 29 step 1: 周期点数の終結式表示（PeriodicPointResultant.lean）
  IntegrableLattice.resultant_X_pow_sub_one_eq_prod_eval
  IntegrableLattice.eval_innerRes
  IntegrableLattice.outerRes_eq_prod_prod_eval
  # cycle 29 step 3b: 周期点数の終結式表示の一般の d（PeriodicPointResultant.lean §3）
  IntegrableLattice.unityRoots
  IntegrableLattice.peelRes
  IntegrableLattice.nestedRes
  IntegrableLattice.rootTuples
  IntegrableLattice.tupleProdHom
  IntegrableLattice.eval_cons_eq_eval_eval
  IntegrableLattice.tupleProdHom_succ
  IntegrableLattice.peelRes_eq_prod_eval
  IntegrableLattice.nestedRes_eq_tupleProd
  IntegrableLattice.nestedRes_two_eq_tupleProd
  IntegrableLattice.card_rootTuples
  IntegrableLattice.splits_X_sq_sub_one_rat
  IntegrableLattice.card_unityRoots_two_rat
  IntegrableLattice.nestedRes_rat_two_three
  # cycle 29 step 2: 双対命題 D の p 素点側・有限 L の段（DualityPAdicFiniteL.lean）
  IntegrableLattice.mem_goodRoots
  IntegrableLattice.aRedOne_ne_zero
  IntegrableLattice.redFactor_monic
  IntegrableLattice.redFactor_splits
  IntegrableLattice.roots_redFactor
  IntegrableLattice.redFactor_dvd
  IntegrableLattice.resultant_redFactor_eq_aRedOne
  IntegrableLattice.aRedOne_eq_resultant_of_no_root
  IntegrableLattice.monic_X_pow_sub_one
  IntegrableLattice.gcdQ_ne_zero
  IntegrableLattice.gcdMonicQ_monic
  IntegrableLattice.gcdMonicQ_dvd
  IntegrableLattice.X_pow_sub_one_eq_gcdMonicQ_mul
  IntegrableLattice.redFactorQ_monic
  IntegrableLattice.redFactorQ_dvd
  IntegrableLattice.exists_int_redFactorQ
  IntegrableLattice.isRoot_gcdMonicQ_map_iff
  IntegrableLattice.map_redFactorQ_eq_redFactor
  IntegrableLattice.exists_int_aRedOne

  # cycle 29 step 3: w* を適合基底（Smith 標準形）で書く（WStarElementaryDivisors.lean）
  IntegrableLattice.isPLevel_mono
  IntegrableLattice.exists_dvd_mul_pow_iff
  IntegrableLattice.mem_iff_dvd_repr
  IntegrableLattice.isLeast_isPLevel
  IntegrableLattice.wStarOfCoeffs_eq_zero_iff
  IntegrableLattice.isLeast_isPLevel_ideal
  IntegrableLattice.exists_isPLevel_ideal
  IntegrableLattice.isPLevel_range_comp
  IntegrableLattice.weightedGram_eq
  IntegrableLattice.det_weightedGram
  IntegrableLattice.det_weightedGram_ne_zero
  IntegrableLattice.trace_coeff_minpolyDiv_mul
  IntegrableLattice.eulerMatrix_mul_weightedGram
  IntegrableLattice.det_eulerMatrix_sq

  # cycle 30 step 1: 命題 W* の整数への降下（WStarIntegralDescent.lean）
  IntegrableLattice.eulerHankel_apply_of_lt
  IntegrableLattice.eulerHankel_apply_antidiag
  IntegrableLattice.isUnit_det_eulerHankel
  IntegrableLattice.coeff_minpolyDiv_eq_sum
  IntegrableLattice.eulerMatrix_eq_eulerHankel
  IntegrableLattice.range_mulLeft_eq_span
  IntegrableLattice.isLeast_isPLevel_range_of_euler

  # cycle 30 step 2: matrix-tree 定理の入口（MultigraphLaplacian.lean）
  IntegrableLattice.lapMatrixOfInc_apply
  IntegrableLattice.incMatrixSigned_loop
  IntegrableLattice.lapMatrix_diag
  IntegrableLattice.lapMatrix_offDiag
  IntegrableLattice.lapMatrix_row_sum

  # cycle 31 step 3: Cauchy-Binet の公式（CauchyBinet.lean）。matrix-tree の 2 段目。
  IntegrableLattice.det_mul_eq_sum_over_maps
  IntegrableLattice.det_submatrix_eq_zero_of_not_injective
  IntegrableLattice.det_mul_eq_sum_over_injective
  IntegrableLattice.det_mul_eq_zero_of_card_lt
)

# 一時ファイルは固定名にしない。固定名だと別 worktree で同時に走った別セッションと
# 中身を奪い合う（cycle 28 に実際に /tmp のファイル名衝突が起きた）。
axiom_check_file="$(mktemp -t integrable_lattice_axiom_check).lean"
trap 'rm -f "$axiom_check_file"' EXIT

{
  echo "import IntegrableLattice"
  for t in "${targets[@]}"; do
    echo "#print axioms $t"
  done
} > "$axiom_check_file"

out="$(lake env lean --stdin < "$axiom_check_file")"
echo "$out"

if echo "$out" | grep -q 'sorryAx'; then
  echo "NG: sorryAx に依存している定理がある" >&2
  status=1
else
  echo "OK: 列挙した定理はいずれも sorryAx に依存していない"
fi

exit "$status"
