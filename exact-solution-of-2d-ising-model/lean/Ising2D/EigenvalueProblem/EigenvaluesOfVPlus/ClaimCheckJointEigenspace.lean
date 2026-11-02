/-
# 数演算子の同時固有空間分解（各空間は 1 次元）（**具体版**）

対応する人手証明（`structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`）:
`check_joint_eigenspace_decomposition`（`evenEigen_005_claim_...`）。

**必要十分版**は `Ising2D/NecSuf/JointEigenspace.lean`（章 009 と共通）。
(1)(2)(3)(4) は、(1) 前半の `Qproj_mul_Qproj_of_ne`（人手の範囲 `M_col ≥ 2` では Step 1 の鎖を使い、特殊化は `Qproj_mul_Qproj_of_ne_of_necSuf`）を除き、**必要十分版の特殊化として導出する**。
ただし証明の Step 0 の冒頭の `ň_μň_μ = ň_μ` と 4 本の鎖（`R_μ^{(1)}R_μ^{(0)} = 0`・`R_μ^{(0)}R_μ^{(1)} = 0`・
`R_μ^{(0)}R_μ^{(0)} = R_μ^{(0)}`・`R_μ^{(1)} + R_μ^{(0)} = I`）は、人手の行と 1 対 1 の `calc` を
`nOp_mul_nOp_of_sq`・`nOp_mul_one_sub_nOp`・`one_sub_nOp_mul_nOp`・`one_sub_nOp_mul_self`・`nOp_add_one_sub_nOp` に置く
（Step 3 の `ε_ν = 0` の場合の `ň_ν R_ν^{(0)} = 0` も `nOp_mul_one_sub_nOp` と同じ行である。`R_μ^{(1)}R_μ^{(1)} = R_μ^{(1)}` と
Step 3 の `ε_ν = 1` の場合の `ň_ν R_ν^{(1)} = R_ν^{(1)}` は、定義の行を除くと `nOp_mul_nOp_of_sq` の 1 行である）。
Step 3 の二つの場合の鎖（`ň_ν R_ν^{(ε_ν)} = ε_ν R_ν^{(ε_ν)}`）は、場合の仮定の行まで含めて `nOp_mul_projFactor_of_mem`（`ε_ν = 1`）・
`nOp_mul_projFactor_of_not_mem`（`ε_ν = 0`）に置く。人手の `R_ν^{(ε_ν)}` は `NecSuf.projFactor F.nOp T ν`、`ε_ν` は
`if ν ∈ T then (1 : ℂ) else 0` である。
Step 0 の異なる添字の因子の可換性の鎖（`YI = IY` の 2 行と、4 通りの上付き添字の組 `R_ν^{(e')}R_μ^{(e)} = R_μ^{(e)}R_ν^{(e')}` の鎖）は、
`mul_identity_eq_identity_mul_step0`・`nOp_mul_nOp_comm_step0`・`nOp_mul_one_sub_nOp_comm_step0`・`one_sub_nOp_mul_nOp_comm_step0`・
`one_sub_nOp_mul_one_sub_nOp_comm_step0` に人手の行と 1 対 1 の `calc` で置き、まとめた「Step 0 の可換性」を `projFactor_mul_comm_step0` に置く。
`Qproj`（`Finset.noncommProd`）が人手の冒頭の `Q̌_ε = ∏_{μ=1}^{M_col} R_μ^{(ε_μ)}`（`def_finite_product_of_matrices` の左から掛ける積）に
等しいことは `Qproj_eq_finProdLeft` に置く（人手の `μ = j + 1` は `checkIdxOfFin j`）。人手の定義の因子
`ε_μň_μ + (1-ε_μ)(I-ň_μ)` が `R_μ^{(ε_μ)}` に等しいことは、人手も Lean もまだ鎖として書いていない。
Step 1 の `ε ≠ ε'` の鎖（`R_ν^{(ε_ν)}` と `Q̌_{ε'}` の因子の可換性と、10 行の鎖）は
`projFactor_mul_projFactor_eq_zero_step1`・`projFactor_comm_factor_step1`・`Qproj_mul_Qproj_of_ne_step1` に置き、
(1) 前半の `Qproj_mul_Qproj_of_ne` は人手の範囲 `M_col ≥ 2` でこの鎖を使う。
Step 1 の `ε = ε'` の鎖、Step 2、Step 3 の `ň_νQ̌_ε` の鎖（`moving_one_factor_of_finite_product_to_the_end` で `R_ν^{(ε_ν)}` を末尾へ寄せる 9 行）と
`Q̌_εň_ν` の鎖と 1 対 1 の具体版はまだ無い。
Step 4 の `tr(Q̌_ε) = 2^{M−M} = 2^0 = 1`（人手は `trace_of_check_number_operator_product` と `def_power_of_complex_number` の `z^0 := 1_ℂ`）は、
下の `trace_Qproj` では必要十分版から `2^M · tr(Q̌_ε) = 2^M` を出して `2^M` で約分しており、人手の 3 行と 1 対 1 の版はまだ無い。Step 5 の人手の根拠
`identity_matrix_is_left_unit_of_mat_mult`（`n → 1`）・`sum_over_binary_words_distributes_in_left_factor`・
`sum_over_binary_words_distributes_in_right_factor`（`p → 1`）・`zero_matrix_is_right_zero_of_mat_mult`（`p → 1`）は、
下の `sum_Qproj_mulVec`・`eq_zero_of_sum_eq_zero` ではまだ mathlib の `Matrix.one_mulVec`・`Matrix.sum_mulVec`・`Matrix.mulVec_sum`・
`Matrix.mulVec_zero` で閉じている（人手の数ベクトルは 1 列の行列、Lean は `Conf M → ℂ` で、和も `Finset.sum`）。
(5)（`ℂ^{2^M}` の直和分解）だけは台が行列環であることを本質的に使うので、ここにしか無い。

## 章 009 との違い（本章の要点）

章 009 の `joint_eigenspace_decomposition` (4) は `tr(Q_ε) = 2^{M-m}`（`m = |I|`）で、
臨界点では `m = M-1` なので `2` になりえた。半整数運動量では
`𝓜̌ = {1,…,M}` すなわち `m = M` が**無条件に**確定するので、
`tr(Q̌_ε) = 2^0 = 1` であり、同時固有空間は**すべて 1 次元**である。

計算そのものは章 009 とまったく同じ（同じ必要十分版の特殊化）で、
違うのは `Fintype.card (CheckIdx M) = M` という 1 行だけである。
-/
import Ising2D.EigenvalueProblem.EigenvaluesOfVPlus.ClaimTraceCheckNumberOperatorProduct
import Ising2D.NecSuf.FiniteProductLeftAsNoncommProd
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimAddAndSubtractZeroMatrixFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimCommutingWithDifferenceFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityScalarMultipleAndDifferenceOnVectorsFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatrixPlusDifferenceCancelsFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultipleByOneFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimZeroScalarMultipleAndMatrixSumCommutativeFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimFiniteProductsOfCommutingMatricesFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimZeroMatrixIsRightZeroOfMatMultFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.DefinitionFiniteProductOfMatricesOmittingOneIndexFromNecSuf

namespace Ising2D

open Matrix

namespace CheckFermiSetup

variable {M : ℕ} (F : CheckFermiSetup M)

/-! ## 原文 Step 0（1 つの添字についての関係）

人手の `R_μ^{(1)} := ň_μ`、`R_μ^{(0)} := I - ň_μ` を、そのまま `F.nOp i`・`1 - F.nOp i` と書く。
各行の右のコメントは、人手の鎖の同じ行の根拠である。 -/

/-- **原文 Step 0 の冒頭**: `check_number_operator_idempotent` (3) の `ň_μ^2 = ň_μ` を積の形 `ň_μň_μ = ň_μ` にする 5 行。 -/
theorem nOp_mul_nOp_of_sq (i : CheckIdx M) : F.nOp i * F.nOp i = F.nOp i :=
  calc F.nOp i * F.nOp i
      = (1 * F.nOp i) * F.nOp i := by rw [identity_matrix_mul_tensorPow]
                                                        -- `identity_matrix_is_left_unit_of_mat_mult` を右辺から左辺へ
    _ = (F.nOp i ^ 0 * F.nOp i) * F.nOp i := by rw [pow_zero]
                                                        -- `def_exp` (1) の `A^0 := I` を右辺から左辺へ
    _ = F.nOp i ^ 1 * F.nOp i := by rw [← pow_succ (F.nOp i) 0]
                                                        -- `def_exp` (1) の `A^{m+1} := A^m A`（`m → 0`）を右辺から左辺へ
    _ = F.nOp i ^ 2 := (pow_succ _ _).symm              -- `def_exp` (1) の `A^{m+1} := A^m A`（`m → 1`）を右辺から左辺へ
    _ = F.nOp i := F.nOp_sq i                           -- `check_number_operator_idempotent` (3)

/-- **原文 Step 0** の `R_μ^{(1)}R_μ^{(0)} = 0`（と Step 3 の `ε_ν = 0` の場合の `ň_ν R_ν^{(0)} = 0`）。 -/
theorem nOp_mul_one_sub_nOp (i : CheckIdx M) : F.nOp i * (1 - F.nOp i) = 0 :=
  calc F.nOp i * (1 - F.nOp i)
      = F.nOp i * (1 + (-F.nOp i)) := by rw [sub_eq_add_neg_tensorPow]
                                                        -- `matrix_difference_is_sum_with_negation`
    _ = F.nOp i * 1 + F.nOp i * (-F.nOp i) := mul_add_matrix_tensorPow _ _ _
                                                        -- `mat_mult_distributes_over_sum_in_right_factor`
    _ = F.nOp i + F.nOp i * (-F.nOp i) := by rw [mul_identity_matrix_tensorPow]
                                                        -- `identity_matrix_is_right_unit_of_mat_mult`
    _ = F.nOp i + (-(F.nOp i * F.nOp i)) := by rw [mul_neg_matrix_tensorPow]
                                                        -- `negation_factors_out_of_right_factor`
    _ = F.nOp i - F.nOp i * F.nOp i := (sub_eq_add_neg_tensorPow _ _).symm
                                                        -- `matrix_difference_is_sum_with_negation` を右辺から左辺へ
    _ = F.nOp i - F.nOp i := by rw [F.nOp_mul_nOp_of_sq i]
                                                        -- Step 0 冒頭の `ň_μň_μ = ň_μ`
    _ = 0 := (matrix_sub_eq_zero_iff_tensorPow _ _).mpr rfl
                                                        -- `matrix_difference_zero_iff_equal` の `⟸`

/-- **原文 Step 0** の `R_μ^{(0)}R_μ^{(1)} = 0`。 -/
theorem one_sub_nOp_mul_nOp (i : CheckIdx M) : (1 - F.nOp i) * F.nOp i = 0 :=
  calc (1 - F.nOp i) * F.nOp i
      = (1 + (-F.nOp i)) * F.nOp i := by rw [sub_eq_add_neg_tensorPow]
                                                        -- `matrix_difference_is_sum_with_negation`
    _ = 1 * F.nOp i + (-F.nOp i) * F.nOp i := add_mul_matrix_tensorPow _ _ _
                                                        -- `mat_mult_distributes_over_sum_in_left_factor`
    _ = F.nOp i + (-F.nOp i) * F.nOp i := by rw [identity_matrix_mul_tensorPow]
                                                        -- `identity_matrix_is_left_unit_of_mat_mult`
    _ = F.nOp i + (-(F.nOp i * F.nOp i)) := by rw [neg_mul_matrix_tensorPow]
                                                        -- `negation_factors_out_of_left_factor`
    _ = F.nOp i - F.nOp i * F.nOp i := (sub_eq_add_neg_tensorPow _ _).symm
                                                        -- `matrix_difference_is_sum_with_negation` を右辺から左辺へ
    _ = F.nOp i - F.nOp i := by rw [F.nOp_mul_nOp_of_sq i]
                                                        -- Step 0 冒頭の `ň_μň_μ = ň_μ`
    _ = 0 := (matrix_sub_eq_zero_iff_tensorPow _ _).mpr rfl
                                                        -- `matrix_difference_zero_iff_equal` の `⟸`

/-- **原文 Step 0** の `R_μ^{(0)}R_μ^{(0)} = R_μ^{(0)}`。 -/
theorem one_sub_nOp_mul_self (i : CheckIdx M) : (1 - F.nOp i) * (1 - F.nOp i) = 1 - F.nOp i :=
  calc (1 - F.nOp i) * (1 - F.nOp i)
      = (1 + (-F.nOp i)) * (1 - F.nOp i) :=
        congrArg (· * (1 - F.nOp i)) (sub_eq_add_neg_tensorPow _ _)
                                                        -- `matrix_difference_is_sum_with_negation`（左の因子）
    _ = 1 * (1 - F.nOp i) + (-F.nOp i) * (1 - F.nOp i) := add_mul_matrix_tensorPow _ _ _
                                                        -- `mat_mult_distributes_over_sum_in_left_factor`
    _ = (1 - F.nOp i) + (-F.nOp i) * (1 - F.nOp i) := by rw [identity_matrix_mul_tensorPow]
                                                        -- `identity_matrix_is_left_unit_of_mat_mult`
    _ = (1 - F.nOp i) + (-(F.nOp i * (1 - F.nOp i))) := by rw [neg_mul_matrix_tensorPow]
                                                        -- `negation_factors_out_of_left_factor`
    _ = (1 - F.nOp i) - F.nOp i * (1 - F.nOp i) := (sub_eq_add_neg_tensorPow _ _).symm
                                                        -- `matrix_difference_is_sum_with_negation` を右辺から左辺へ
    _ = (1 - F.nOp i) - 0 := by rw [F.nOp_mul_one_sub_nOp i]
                                                        -- 上の `R_μ^{(1)}R_μ^{(0)} = 0`
    _ = 1 - F.nOp i := matrix_sub_zero_matrix_tensorPow _
                                                        -- `matrix_minus_zero_matrix`

/-- **原文 Step 0** の `R_μ^{(1)} + R_μ^{(0)} = I`。 -/
theorem nOp_add_one_sub_nOp (i : CheckIdx M) : F.nOp i + (1 - F.nOp i) = 1 :=
  calc F.nOp i + (1 - F.nOp i)
      = 1 := add_sub_cancel_tensorPow _ _               -- `matrix_plus_difference_cancels`（`A → ň_μ`、`B → I`）

/-! ## 原文 Step 0 の異なる添字の因子の可換性

人手の各鎖の最初と最後の行（`R_ν^{(e')}`・`R_μ^{(e)}` の定義（冒頭））は、Lean では `F.nOp`・`1 - F.nOp` をそのまま書くので同じ項である。
残りの行を `calc` の段に置く。 -/

/-- **原文 Step 0** の `YI = IY`（人手は `Y ∈ {ň_ν, I - ň_ν}` について書く。2 行の鎖は `Y` に依らない）。 -/
theorem mul_identity_eq_identity_mul_step0 (Y : TensorPow M) : Y * 1 = 1 * Y :=
  calc Y * 1
      = Y := mul_identity_matrix_tensorPow Y            -- `identity_matrix_is_right_unit_of_mat_mult`（`A → Y`）
    _ = 1 * Y := (identity_matrix_mul_tensorPow Y).symm -- `identity_matrix_is_left_unit_of_mat_mult`（`A → Y`）を右辺から左辺へ

/-- **原文 Step 0** の `R_ν^{(1)}R_μ^{(1)} = R_μ^{(1)}R_ν^{(1)}`（`μ ≠ ν`）。 -/
theorem nOp_mul_nOp_comm_step0 {μ ν : CheckIdx M} (h : μ ≠ ν) :
    F.nOp ν * F.nOp μ = F.nOp μ * F.nOp ν :=
  calc F.nOp ν * F.nOp μ
      = F.nOp μ * F.nOp ν := F.nOp_mul_nOp_of_ne h.symm -- `check_number_operators_commute` (2)（`μ → ν`、`ν → μ`）

/-- **原文 Step 0** の `R_ν^{(1)}R_μ^{(0)} = R_μ^{(0)}R_ν^{(1)}`（`μ ≠ ν`）。 -/
theorem nOp_mul_one_sub_nOp_comm_step0 {μ ν : CheckIdx M} (h : μ ≠ ν) :
    F.nOp ν * (1 - F.nOp μ) = (1 - F.nOp μ) * F.nOp ν :=
  calc F.nOp ν * (1 - F.nOp μ)
      = (1 - F.nOp μ) * F.nOp ν :=
        mul_sub_eq_sub_mul_of_commute_tensorPow (F.nOp ν) 1 (F.nOp μ)
          (mul_identity_eq_identity_mul_step0 (F.nOp ν)) (F.nOp_mul_nOp_of_ne h.symm)
                                                        -- `commuting_with_difference`（`G → ň_ν`、`X → I`、`W → ň_μ`）。
                                                        -- 前提は上の `ň_νI = Iň_ν` と `check_number_operators_commute` (2)（`μ → ν`、`ν → μ`）

/-- **原文 Step 0** の `R_ν^{(0)}R_μ^{(1)} = R_μ^{(1)}R_ν^{(0)}`（`μ ≠ ν`）。 -/
theorem one_sub_nOp_mul_nOp_comm_step0 {μ ν : CheckIdx M} (h : μ ≠ ν) :
    (1 - F.nOp ν) * F.nOp μ = F.nOp μ * (1 - F.nOp ν) :=
  calc (1 - F.nOp ν) * F.nOp μ
      = F.nOp μ * (1 - F.nOp ν) := (F.nOp_mul_one_sub_nOp_comm_step0 h.symm).symm
                                                        -- 直前の鎖を `(μ → ν, ν → μ)` で、右辺から左辺へ

/-- **原文 Step 0** の `R_ν^{(0)}R_μ^{(0)} = R_μ^{(0)}R_ν^{(0)}`（`μ ≠ ν`）。 -/
theorem one_sub_nOp_mul_one_sub_nOp_comm_step0 {μ ν : CheckIdx M} (h : μ ≠ ν) :
    (1 - F.nOp ν) * (1 - F.nOp μ) = (1 - F.nOp μ) * (1 - F.nOp ν) :=
  calc (1 - F.nOp ν) * (1 - F.nOp μ)
      = (1 - F.nOp μ) * (1 - F.nOp ν) :=
        mul_sub_eq_sub_mul_of_commute_tensorPow (1 - F.nOp ν) 1 (F.nOp μ)
          (mul_identity_eq_identity_mul_step0 (1 - F.nOp ν)) (F.one_sub_nOp_mul_nOp_comm_step0 h)
                                                        -- `commuting_with_difference`（`G → I - ň_ν`、`X → I`、`W → ň_μ`）。
                                                        -- 前提は上の `(I - ň_ν)I = I(I - ň_ν)` と直前の鎖

/-- **原文 Step 0 の可換性**: `μ ≠ ν` と全ての `e, e' ∈ {0,1}` について `R_ν^{(e')}R_μ^{(e)} = R_μ^{(e)}R_ν^{(e')}`。
人手の `e'` は `ν ∈ T'`、`e` は `μ ∈ T` で表す（`NecSuf.projFactor`）。4 通りの組は上の 4 本の鎖である。 -/
theorem projFactor_mul_comm_step0 {μ ν : CheckIdx M} (h : μ ≠ ν) (T T' : Finset (CheckIdx M)) :
    NecSuf.projFactor F.nOp T' ν * NecSuf.projFactor F.nOp T μ
      = NecSuf.projFactor F.nOp T μ * NecSuf.projFactor F.nOp T' ν := by
  by_cases hν : ν ∈ T' <;> by_cases hμ : μ ∈ T
  · rw [NecSuf.projFactor_of_mem hν, NecSuf.projFactor_of_mem hμ]
    exact F.nOp_mul_nOp_comm_step0 h                    -- `(e', e) = (1, 1)`
  · rw [NecSuf.projFactor_of_mem hν, NecSuf.projFactor_of_notMem hμ]
    exact F.nOp_mul_one_sub_nOp_comm_step0 h            -- `(e', e) = (1, 0)`
  · rw [NecSuf.projFactor_of_notMem hν, NecSuf.projFactor_of_mem hμ]
    exact F.one_sub_nOp_mul_nOp_comm_step0 h            -- `(e', e) = (0, 1)`
  · rw [NecSuf.projFactor_of_notMem hν, NecSuf.projFactor_of_notMem hμ]
    exact F.one_sub_nOp_mul_one_sub_nOp_comm_step0 h    -- `(e', e) = (0, 0)`

/-! ## 原文 Step 3 の二つの場合（`ň_ν R_ν^{(ε_ν)} = ε_ν R_ν^{(ε_ν)}`）

人手の `R_ν^{(ε_ν)}` を `NecSuf.projFactor F.nOp T ν`（`ν ∈ T` なら `ň_ν`、そうでなければ `I - ň_ν`）、
`R_ν^{(1)}` を `F.nOp ν`、`R_ν^{(0)}` を `1 - F.nOp ν`、`ε_ν` を `if ν ∈ T then (1 : ℂ) else 0` と書く。
人手は場合を分ける段落で `R_ν^{(ε_ν)}` を `R_ν^{(1)}`（`R_ν^{(0)}`）にしてから鎖を始めるので、Lean の 1 段目はその置き換えと定義の行を合わせて運ぶ。各行の右のコメントは、人手の鎖の同じ行の根拠である。 -/

/-- **原文 Step 3 の `ε_ν = 1` の場合**: `ň_ν R_ν^{(1)} = ň_νň_ν = ň_ν = R_ν^{(1)} = 1_ℂ R_ν^{(1)} = ε_ν R_ν^{(ε_ν)}`。 -/
theorem nOp_mul_projFactor_of_mem {ν : CheckIdx M} {T : Finset (CheckIdx M)} (hν : ν ∈ T) :
    F.nOp ν * NecSuf.projFactor F.nOp T ν
      = (if ν ∈ T then (1 : ℂ) else 0) • NecSuf.projFactor F.nOp T ν :=
  calc F.nOp ν * NecSuf.projFactor F.nOp T ν
      = F.nOp ν * F.nOp ν := by rw [NecSuf.projFactor_of_mem hν]
                                                        -- 場合の仮定で `R_ν^{(ε_ν)} = R_ν^{(1)}`、続けて `R_ν^{(1)}` の定義（冒頭）
    _ = F.nOp ν := F.nOp_mul_nOp_of_sq ν                -- Step 0 冒頭の `ň_μň_μ = ň_μ`（`μ → ν`）
    _ = (1 : ℂ) • F.nOp ν := (one_smul_tensorPow _).symm
                                                        -- `scalar_multiple_by_one` を右辺から左辺へ
                                                        -- （人手の `= R_ν^{(1)}`（定義）の行は、Lean では `F.nOp ν` のままで同じ項）
    _ = (if ν ∈ T then (1 : ℂ) else 0) • NecSuf.projFactor F.nOp T ν := by
        rw [if_pos hν, NecSuf.projFactor_of_mem hν]     -- 場合の仮定 `ε_ν = 1`

/-- **原文 Step 3 の `ε_ν = 0` の場合**: `ň_ν R_ν^{(0)} = ň_ν(I - ň_ν) = ⋯ = O = 0_ℂ R_ν^{(0)} = ε_ν R_ν^{(ε_ν)}`。 -/
theorem nOp_mul_projFactor_of_not_mem {ν : CheckIdx M} {T : Finset (CheckIdx M)} (hν : ν ∉ T) :
    F.nOp ν * NecSuf.projFactor F.nOp T ν
      = (if ν ∈ T then (1 : ℂ) else 0) • NecSuf.projFactor F.nOp T ν :=
  calc F.nOp ν * NecSuf.projFactor F.nOp T ν
      = F.nOp ν * (1 - F.nOp ν) := by rw [NecSuf.projFactor_of_notMem hν]
                                                        -- 場合の仮定で `R_ν^{(ε_ν)} = R_ν^{(0)}`、続けて `R_ν^{(0)}` の定義（冒頭）
    _ = 0 := F.nOp_mul_one_sub_nOp ν                    -- 人手の続く 7 行（`nOp_mul_one_sub_nOp` の calc と同じ行）
    _ = (0 : ℂ) • (1 - F.nOp ν) := (zero_smul_tensorPow _).symm
                                                        -- `zero_scalar_multiple_is_zero_matrix` を右辺から左辺へ
    _ = (if ν ∈ T then (1 : ℂ) else 0) • NecSuf.projFactor F.nOp T ν := by
        rw [if_neg hν, NecSuf.projFactor_of_notMem hν]  -- 場合の仮定 `ε_ν = 0`

/-- **原文 `check_joint_eigenspace_decomposition` の `Q̌_ε`**:
`Q̌_T = ∏_{μ∈𝓜̌} (μ ∈ T ? ň_μ : I - ň_μ)`。 -/
noncomputable def Qproj (T : Finset (CheckIdx M)) : TensorPow M :=
  NecSuf.projOn F.nOp F.commute_nOp_nOp Finset.univ T

/-- `ε : 𝓜̌ → Bool` の形（人手証明の記法に合わせた版）。 -/
noncomputable def Qproj' (ε : CheckIdx M → Bool) : TensorPow M :=
  F.Qproj (Finset.univ.filter fun i => ε i)

/-- 人手の添字 `μ = j + 1 ∈ 𝓜̌ = {1, …, M_col}`（`def_check_index_set`）。Lean の `j : Fin M` を人手の `μ` へ送る。 -/
def checkIdxOfFin (j : Fin M) : CheckIdx M :=
  ⟨(j : ℤ) + 1, Finset.mem_image.2 ⟨j, Finset.mem_range.2 j.2, rfl⟩⟩

theorem checkIdxOfFin_injective : Function.Injective (checkIdxOfFin (M := M)) := by
  intro j k h
  have h' : (j : ℤ) + 1 = (k : ℤ) + 1 := congrArg Subtype.val h
  exact Fin.ext (by omega)

theorem checkIdxOfFin_surjective : Function.Surjective (checkIdxOfFin (M := M)) := by
  rintro ⟨μ, hμ⟩
  obtain ⟨k, hk, rfl⟩ := Finset.mem_image.1 hμ
  exact ⟨⟨k, Finset.mem_range.1 hk⟩, rfl⟩

/-- **人手の `Q̌_ε = ∏_{μ=1}^{M_col} R_μ^{(ε_μ)}`**（証明の冒頭）: `Qproj`（`Finset.noncommProd`）は、
`def_finite_product_of_matrices`（`r → M_col`）の左から掛ける積 `NecSuf.finProdLeft` に等しい。
人手の `M_col` が Lean の `r + 1`、人手の因子 `R_μ^{(ε_μ)}`（`μ = j + 1`）が `NecSuf.projFactor F.nOp T (checkIdxOfFin j)` である。
必要十分版 `NecSuf.finProdLeft_eq_noncommProd_image`（`Ising2D/NecSuf/FiniteProductLeftAsNoncommProd.lean`）の特殊化で、
`𝓜̌` 全体が `checkIdxOfFin` の像であること（全射）で添字集合を付け替える。
`M_col = r + 1` の形でだけ述べる（人手の `M_col ≥ 2` から従う）。`F : CheckFermiSetup M` の主張へ戻すときは `M = r + 1` に分ける。 -/
theorem Qproj_eq_finProdLeft {r : ℕ} (F : CheckFermiSetup (r + 1)) (T : Finset (CheckIdx (r + 1))) :
    F.Qproj T = NecSuf.finProdLeft r (fun j => NecSuf.projFactor F.nOp T (checkIdxOfFin j)) :=
  calc F.Qproj T
      = (Finset.univ : Finset (CheckIdx (r + 1))).noncommProd (NecSuf.projFactor F.nOp T)
          (fun i _ j _ _ => NecSuf.commute_projFactor F.commute_nOp_nOp T T i j) := rfl
                                                        -- `Qproj`・`NecSuf.projOn` の定義
    _ = ((Finset.univ : Finset (Fin (r + 1))).image checkIdxOfFin).noncommProd
          (NecSuf.projFactor F.nOp T)
          (fun i _ j _ _ => NecSuf.commute_projFactor F.commute_nOp_nOp T T i j) :=
        Finset.noncommProd_congr (Finset.image_univ_of_surjective checkIdxOfFin_surjective).symm
          (fun _ _ => rfl) _                            -- `𝓜̌ = {j + 1 | j ∈ Fin M_col}`（全射）
    _ = NecSuf.finProdLeft r (fun j => NecSuf.projFactor F.nOp T (checkIdxOfFin j)) :=
        (NecSuf.finProdLeft_eq_noncommProd_image (NecSuf.projFactor F.nOp T)
          (fun i j => NecSuf.commute_projFactor F.commute_nOp_nOp T T i j) r
          checkIdxOfFin checkIdxOfFin_injective).symm    -- 必要十分版（単射な添字の写像）

/-- **原文 (1) 後半**: `Q̌_ε^2 = Q̌_ε`。 -/
theorem Qproj_mul_self (T : Finset (CheckIdx M)) : F.Qproj T * F.Qproj T = F.Qproj T :=
  NecSuf.projOn_mul_self F.nOp_mul_self _ _

/-! ## 原文 Step 1 の `ε ≠ ε'` の鎖

人手の `ε_ν ≠ ε'_ν` は `¬(ν ∈ T ↔ ν ∈ T')`、`R_ν^{(ε_ν)}` は `NecSuf.projFactor F.nOp T ν`、`R_ν^{(ε'_ν)}` は
`NecSuf.projFactor F.nOp T' ν` である。各行の右のコメントは、人手の鎖の同じ行の根拠である。 -/

/-- **原文 Step 1** の場合分けの根拠: `ε_ν ≠ ε'_ν` なら `R_ν^{(ε_ν)}R_ν^{(ε'_ν)} = 0`。
`(ε_ν, ε'_ν) = (1, 0)` なら Step 0 の `R_μ^{(1)}R_μ^{(0)} = 0`、`(0, 1)` なら `R_μ^{(0)}R_μ^{(1)} = 0`（`μ → ν`）。
人手の鎖の中では `(T, T') → (T', T)` としても引く（`(ε'_ν, ε_ν)` の場合分け）。 -/
theorem projFactor_mul_projFactor_eq_zero_step1 {ν : CheckIdx M} {T T' : Finset (CheckIdx M)}
    (hν : ¬(ν ∈ T ↔ ν ∈ T')) :
    NecSuf.projFactor F.nOp T ν * NecSuf.projFactor F.nOp T' ν = 0 := by
  by_cases hT : ν ∈ T
  · have hT' : ν ∉ T' := fun h => hν ⟨fun _ => h, fun _ => hT⟩
    rw [NecSuf.projFactor_of_mem hT, NecSuf.projFactor_of_notMem hT']
    exact F.nOp_mul_one_sub_nOp ν                       -- `(ε_ν, ε'_ν) = (1, 0)`: Step 0 の `R_μ^{(1)}R_μ^{(0)} = 0`
  · have hT' : ν ∈ T' := by
      by_contra h
      exact hν ⟨fun h' => absurd h' hT, fun h' => absurd h' h⟩
    rw [NecSuf.projFactor_of_notMem hT, NecSuf.projFactor_of_mem hT']
    exact F.one_sub_nOp_mul_nOp ν                       -- `(ε_ν, ε'_ν) = (0, 1)`: Step 0 の `R_μ^{(0)}R_μ^{(1)} = 0`

/-- **原文 Step 1** の「`R_ν^{(ε_ν)}` は `Q̌_{ε'}` のどの因子 `R_μ^{(ε'_μ)}` とも可換」。
`μ ≠ ν` なら Step 0 の可換性（`e' → ε_ν`、`e → ε'_μ`）、`μ = ν` なら 2 行の鎖
`R_ν^{(ε_ν)}R_ν^{(ε'_ν)} = 0 = R_ν^{(ε'_ν)}R_ν^{(ε_ν)}`。 -/
theorem projFactor_comm_factor_step1 {ν : CheckIdx M} {T T' : Finset (CheckIdx M)}
    (hν : ¬(ν ∈ T ↔ ν ∈ T')) (μ : CheckIdx M) :
    NecSuf.projFactor F.nOp T ν * NecSuf.projFactor F.nOp T' μ
      = NecSuf.projFactor F.nOp T' μ * NecSuf.projFactor F.nOp T ν := by
  by_cases hμ : μ = ν
  · subst hμ
    calc NecSuf.projFactor F.nOp T μ * NecSuf.projFactor F.nOp T' μ
        = 0 := F.projFactor_mul_projFactor_eq_zero_step1 hν
                                                        -- `(ε_ν, ε'_ν)` の場合分けで Step 0 の積が零
      _ = NecSuf.projFactor F.nOp T' μ * NecSuf.projFactor F.nOp T μ :=
          (F.projFactor_mul_projFactor_eq_zero_step1 (fun h => hν h.symm)).symm
                                                        -- `(ε'_ν, ε_ν)` の場合分けで Step 0 の積が零（`(1,0)` なら `R_μ^{(0)}R_μ^{(1)} = 0`、
                                                        -- `(0,1)` なら `R_μ^{(1)}R_μ^{(0)} = 0`）を右辺から左辺へ
  · exact F.projFactor_mul_comm_step0 hμ T' T           -- Step 0 の可換性（`e' → ε_ν`、`e → ε'_μ`）

/-- **原文 Step 1** の `ε ≠ ε'` の鎖（10 行）: `ε_ν ≠ ε'_ν` なら `Q̌_εQ̌_{ε'} = 0`。
人手の `M_col` が Lean の `r + 2`（人手の `M_col ≥ 2`。`moving_one_factor_of_finite_product_to_the_end` は因子が 2 つ以上の積について述べる）、
人手の `ν ∈ 𝓜̌` が `checkIdxOfFin ν`（`ν : Fin (r + 2)`）、人手の `R_j^{(ε_j)}` が `NecSuf.projFactor F.nOp T (checkIdxOfFin j)` である。
`mat_mult_associative` の行は、Lean の具体版が無いので mathlib の `Matrix.mul_assoc` を 1 回ずつ使う。 -/
theorem Qproj_mul_Qproj_of_ne_step1 {r : ℕ} (F : CheckFermiSetup (r + 2)) {T T' : Finset (CheckIdx (r + 2))}
    (ν : Fin (r + 2)) (hν : ¬(checkIdxOfFin ν ∈ T ↔ checkIdxOfFin ν ∈ T')) :
    F.Qproj T * F.Qproj T' = 0 :=
  have hstep0 : ∀ (S : Finset (CheckIdx (r + 2))) (j : Fin (r + 2)), ν < j →
      NecSuf.projFactor F.nOp S (checkIdxOfFin ν) * NecSuf.projFactor F.nOp S (checkIdxOfFin j)
        = NecSuf.projFactor F.nOp S (checkIdxOfFin j) * NecSuf.projFactor F.nOp S (checkIdxOfFin ν) :=
    fun S j hj => F.projFactor_mul_comm_step0 (checkIdxOfFin_injective.ne hj.ne') S S
  calc F.Qproj T * F.Qproj T'
      = NecSuf.finProdLeft (r + 1) (fun j => NecSuf.projFactor F.nOp T (checkIdxOfFin j)) * F.Qproj T' := by
        rw [Qproj_eq_finProdLeft F T]                   -- `Q̌_ε` の定義（冒頭）
    _ = (NecSuf.finProdLeftOmitting r ν (fun j => NecSuf.projFactor F.nOp T (checkIdxOfFin j))
          * NecSuf.projFactor F.nOp T (checkIdxOfFin ν)) * F.Qproj T' := by
        rw [finProdLeft_eq_omitting_mul_tensorPow r ν (fun j => NecSuf.projFactor F.nOp T (checkIdxOfFin j))
          (hstep0 T)]
                                                        -- `moving_one_factor_of_finite_product_to_the_end`（`A_j → R_j^{(ε_j)}`）。
                                                        -- 前提は Step 0 の可換性（`μ → j`、`e' → ε_ν`、`e → ε_j`）
    _ = NecSuf.finProdLeftOmitting r ν (fun j => NecSuf.projFactor F.nOp T (checkIdxOfFin j))
          * (NecSuf.projFactor F.nOp T (checkIdxOfFin ν) * F.Qproj T') := by
        rw [Matrix.mul_assoc]
                                                        -- `mat_mult_associative`
    _ = NecSuf.finProdLeftOmitting r ν (fun j => NecSuf.projFactor F.nOp T (checkIdxOfFin j))
          * (NecSuf.projFactor F.nOp T (checkIdxOfFin ν)
              * NecSuf.finProdLeft (r + 1) (fun j => NecSuf.projFactor F.nOp T' (checkIdxOfFin j))) := by
        rw [Qproj_eq_finProdLeft F T']                  -- `Q̌_{ε'}` の定義（冒頭）
    _ = NecSuf.finProdLeftOmitting r ν (fun j => NecSuf.projFactor F.nOp T (checkIdxOfFin j))
          * (NecSuf.finProdLeft (r + 1) (fun j => NecSuf.projFactor F.nOp T' (checkIdxOfFin j))
              * NecSuf.projFactor F.nOp T (checkIdxOfFin ν)) := by
        rw [commute_finProdLeft_tensorPow (r + 1) (NecSuf.projFactor F.nOp T (checkIdxOfFin ν))
          (fun j => NecSuf.projFactor F.nOp T' (checkIdxOfFin j))
          (fun j => F.projFactor_comm_factor_step1 hν (checkIdxOfFin j))]
                                                        -- `matrix_commuting_with_each_factor_commutes_with_finite_product`
                                                        -- （`X → R_ν^{(ε_ν)}`、`A_j → R_j^{(ε'_j)}`）。前提は直前の可換性
    _ = NecSuf.finProdLeftOmitting r ν (fun j => NecSuf.projFactor F.nOp T (checkIdxOfFin j))
          * ((NecSuf.finProdLeftOmitting r ν (fun j => NecSuf.projFactor F.nOp T' (checkIdxOfFin j))
              * NecSuf.projFactor F.nOp T' (checkIdxOfFin ν)) * NecSuf.projFactor F.nOp T (checkIdxOfFin ν)) := by
        rw [finProdLeft_eq_omitting_mul_tensorPow r ν (fun j => NecSuf.projFactor F.nOp T' (checkIdxOfFin j))
          (hstep0 T')]
                                                        -- `moving_one_factor_of_finite_product_to_the_end`（`A_j → R_j^{(ε'_j)}`）。
                                                        -- 前提は Step 0 の可換性（`μ → j`、`e' → ε'_ν`、`e → ε'_j`）
    _ = NecSuf.finProdLeftOmitting r ν (fun j => NecSuf.projFactor F.nOp T (checkIdxOfFin j))
          * (NecSuf.finProdLeftOmitting r ν (fun j => NecSuf.projFactor F.nOp T' (checkIdxOfFin j))
              * (NecSuf.projFactor F.nOp T' (checkIdxOfFin ν) * NecSuf.projFactor F.nOp T (checkIdxOfFin ν))) := by
        rw [Matrix.mul_assoc]                           -- `mat_mult_associative`
    _ = NecSuf.finProdLeftOmitting r ν (fun j => NecSuf.projFactor F.nOp T (checkIdxOfFin j))
          * (NecSuf.finProdLeftOmitting r ν (fun j => NecSuf.projFactor F.nOp T' (checkIdxOfFin j)) * 0) := by
        rw [F.projFactor_mul_projFactor_eq_zero_step1 (fun h => hν h.symm)]
                                                        -- `(ε'_ν, ε_ν)` の場合分けで Step 0 の積が零（`μ → ν`）
    _ = NecSuf.finProdLeftOmitting r ν (fun j => NecSuf.projFactor F.nOp T (checkIdxOfFin j)) * 0 := by
        rw [matrix_mul_zero_matrix_tensorPow]           -- `zero_matrix_is_right_zero_of_mat_mult`
    _ = 0 := matrix_mul_zero_matrix_tensorPow _         -- `zero_matrix_is_right_zero_of_mat_mult`

/-- **原文 (1) 前半** の必要十分版の特殊化（人手の範囲外の `M_col ≤ 1` でも成り立つ）。 -/
theorem Qproj_mul_Qproj_of_ne_of_necSuf {T T' : Finset (CheckIdx M)} (h : T ≠ T') :
    F.Qproj T * F.Qproj T' = 0 := by
  obtain ⟨ν, hν⟩ : ∃ ν : CheckIdx M, ¬(ν ∈ T ↔ ν ∈ T') := by
    by_contra hc
    push_neg at hc
    exact h (Finset.ext fun ν => hc ν)
  exact NecSuf.projOn_mul_projOn_of_ne F.nOp_mul_self (Finset.mem_univ ν) hν

/-- **原文 (1) 前半**: `ε ≠ ε'` なら `Q̌_ε Q̌_{ε'} = 0`。
人手の冒頭「`ε ≠ ε'` なら、ある `ν ∈ 𝓜̌` で `ε_ν ≠ ε'_ν`」の後、人手の範囲 `M_col ≥ 2`（`M = r + 2`）では
Step 1 の鎖 `Qproj_mul_Qproj_of_ne_step1` で示す。`M = 0, 1` は人手の範囲外で、必要十分版の特殊化
`Qproj_mul_Qproj_of_ne_of_necSuf` で閉じる。 -/
theorem Qproj_mul_Qproj_of_ne {T T' : Finset (CheckIdx M)} (h : T ≠ T') :
    F.Qproj T * F.Qproj T' = 0 := by
  match M, F, T, T', h with
  | 0, F, _, _, h => exact F.Qproj_mul_Qproj_of_ne_of_necSuf h
  | 1, F, _, _, h => exact F.Qproj_mul_Qproj_of_ne_of_necSuf h
  | r + 2, F, T, T', h =>
    obtain ⟨μ, hμ⟩ : ∃ μ : CheckIdx (r + 2), ¬(μ ∈ T ↔ μ ∈ T') := by
      by_contra hc
      push_neg at hc
      exact h (Finset.ext fun μ => hc μ)               -- `ε ≠ ε'` なら、ある `ν` で `ε_ν ≠ ε'_ν`
    obtain ⟨ν, rfl⟩ := checkIdxOfFin_surjective μ      -- 人手の `ν = j + 1`
    exact Qproj_mul_Qproj_of_ne_step1 F ν hμ

/-- **原文 (2)**: `∑_ε Q̌_ε = I`。 -/
theorem sum_Qproj : ∑ T : Finset (CheckIdx M), F.Qproj T = 1 := by
  have := NecSuf.sum_projOn (n := F.nOp) (hn := F.commute_nOp_nOp) Finset.univ
  rwa [Finset.powerset_univ] at this

/-- **原文 (3)**: `ň_ν Q̌_ε = ε_ν Q̌_ε`。 -/
theorem nOp_mul_Qproj (ν : CheckIdx M) (T : Finset (CheckIdx M)) :
    F.nOp ν * F.Qproj T = (if ν ∈ T then (1 : ℂ) else 0) • F.Qproj T := by
  have h := NecSuf.num_mul_projOn (n := F.nOp) (hn := F.commute_nOp_nOp)
    F.nOp_mul_self (T := T) (Finset.mem_univ ν)
  rw [Qproj, h]
  by_cases hT : ν ∈ T <;> simp [hT]

/-- `ň_ν` は `Q̌_ε` と可換（人手 Step 3 の `Q̌_εň_ν = ň_νQ̌_ε`。人手は Step 0 の可換性と `matrix_commuting_with_each_factor_commutes_with_finite_product` で示す）。 -/
theorem commute_nOp_Qproj (ν : CheckIdx M) (T : Finset (CheckIdx M)) :
    Commute (F.nOp ν) (F.Qproj T) :=
  NecSuf.commute_projOn (n := F.nOp) (hn := F.commute_nOp_nOp)
    (fun i _ => F.commute_nOp_nOp ν i)

/-! ## トレースと次元（原文 (4)） -/

/-- **原文 (4)**: `tr(Q̌_ε) = 1`。

章 009 の同じ計算が `2^{M-m}` を与えるところで、`m = M` により `2^0 = 1` になる。 -/
theorem trace_Qproj (T : Finset (CheckIdx M)) : (F.Qproj T).trace = 1 := by
  have h : ((2 ^ M : ℕ) : ℂ) * (F.Qproj T).trace = ((2 ^ M : ℕ) : ℂ) := by
    have h0 := NecSuf.two_pow_smul_tau_projOn F.cre F.ann F.commute_nOp_nOp
      (Matrix.trace : TensorPow M → ℂ) (fun x y => Matrix.trace_add x y)
      (fun x y => Matrix.trace_mul_comm x y) F.acomm_cre_ann_self
      (fun i j hij => F.commute_cre_nOp hij) (fun i j hij => F.commute_ann_nOp hij)
      Finset.univ T
    rw [trace_one_tensorPow, nsmul_eq_mul, Finset.card_univ, CheckIdx.card] at h0
    exact h0
  have hne : ((2 ^ M : ℕ) : ℂ) ≠ 0 := by simp
  refine mul_left_cancel₀ hne ?_
  rw [mul_one]
  exact h

/-- **原文 (4) 後半**: `dim_ℂ (im Q̌_ε) = 1`。 -/
theorem finrank_range_Qproj (T : Finset (CheckIdx M)) :
    ((Module.finrank ℂ (LinearMap.range (Matrix.toLin' (F.Qproj T))) : ℕ) : ℂ) = 1 := by
  rw [← trace_of_idempotent _ (F.Qproj_mul_self T), F.trace_Qproj T]

/-! ## 原文 (5): `ℂ^{2^M}` の直和分解 -/

/-- **原文 (5) 前半**: 任意の `x` は `x = ∑_ε Q̌_ε x` と書ける（和が全体を張る）。 -/
theorem sum_Qproj_mulVec (x : Conf M → ℂ) :
    ∑ T : Finset (CheckIdx M), (F.Qproj T).mulVec x = x := by
  rw [← Matrix.sum_mulVec, F.sum_Qproj, Matrix.one_mulVec]

/-- **原文 (5) 後半**: `y_ε ∈ im Q̌_ε` かつ `∑_ε y_ε = 0` なら各 `y_ε = 0`（直和性）。 -/
theorem eq_zero_of_sum_eq_zero (y : Finset (CheckIdx M) → Conf M → ℂ)
    (hy : ∀ T, ∃ x, y T = (F.Qproj T).mulVec x)
    (hsum : ∑ T : Finset (CheckIdx M), y T = 0) (T₀ : Finset (CheckIdx M)) : y T₀ = 0 := by
  classical
  have hfix : ∀ T, (F.Qproj T₀).mulVec (y T) = if T = T₀ then y T else 0 := by
    intro T
    obtain ⟨x, hx⟩ := hy T
    by_cases hT : T = T₀
    · subst hT
      rw [if_pos rfl, hx, Matrix.mulVec_mulVec, F.Qproj_mul_self]
    · rw [if_neg hT, hx, Matrix.mulVec_mulVec,
        F.Qproj_mul_Qproj_of_ne (Ne.symm hT), Matrix.zero_mulVec]
  have hkey : (F.Qproj T₀).mulVec (∑ T : Finset (CheckIdx M), y T) = y T₀ := by
    rw [Matrix.mulVec_sum, Finset.sum_congr rfl (fun T _ => hfix T)]
    simp
  rw [hsum, Matrix.mulVec_zero] at hkey
  exact hkey.symm

end CheckFermiSetup

end Ising2D
