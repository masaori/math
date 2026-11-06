/-
# 実数の差の有限和と、非負の実数の有限和の下からの評価を、必要十分版の特殊化として得る

具体版 `ClaimFiniteSumsOfRealNumbers.lean` の主張を、必要十分版 `Ising2D/NecSuf/FiniteSumDifferenceAndNonnegativeTerm.lean` を
係数 `R := ℝ` に特殊化して得る。人手のラベルは `finite_sum_of_real_differences`, `finite_sum_of_real_sums`（必要十分版は `Ising2D/NecSuf/MatMulDistribSum.lean` の `finite_sum_add_fin'`）,
`finite_sum_of_negated_real_numbers`, `finite_sum_of_real_scalar_multiples`, `finite_sum_of_nonnegative_reals_is_at_least_each_term`,
`finite_sum_of_real_numbers_triangle_inequality`, `finite_sum_of_real_numbers_is_monotone`（この 2 つは必要十分版 `Ising2D/NecSuf/FiniteSumSubadditiveAndMonotone.lean`）、`finite_sum_of_real_numbers_moves_one_term_to_end`（必要十分版 `Ising2D/NecSuf/FiniteSumMovesOneTermToEnd.lean`）。人手証明と 1 対 1 に対応する形は具体版のほうである。
-/
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimFiniteSumsOfRealNumbers
import Ising2D.NecSuf.FiniteSumDifferenceAndNonnegativeTerm
import Ising2D.NecSuf.FiniteSumSubadditiveAndMonotone
import Ising2D.NecSuf.FiniteSumMovesOneTermToEnd
import Ising2D.NecSuf.MatMulDistribSum
import Ising2D.NecSuf.AbsoluteValueBoundsTriangleAndProduct
import Mathlib.Data.Real.Basic

namespace Ising2D

/-- `finite_sum_of_real_differences` を `NecSuf.finite_sum_sub_fin'`（係数 `ℝ`）の特殊化として得る。 -/
theorem finite_sum_of_real_differences_of_necSuf (m : ℕ) (a b : Fin m → ℝ) :
    ∑ j, (a j - b j) = (∑ j, a j) - ∑ j, b j :=
  NecSuf.finite_sum_sub_fin' (R := ℝ) m a b

/-- `finite_sum_of_real_sums` を `NecSuf.finite_sum_add_fin'`（係数 `ℝ`。仮定は加法の可換モノイドだけ）の特殊化として得る。 -/
theorem finite_sum_of_real_sums_of_necSuf (m : ℕ) (a b : Fin m → ℝ) :
    ∑ j, (a j + b j) = (∑ j, a j) + ∑ j, b j :=
  NecSuf.finite_sum_add_fin' (R := ℝ) m a b

/-- `finite_sum_of_real_sums_fintype`（添字が有限型 `κ` の和）を `NecSuf.finite_sum_add'`（係数 `ℝ`）の特殊化として得る。 -/
theorem finite_sum_of_real_sums_fintype_of_necSuf {κ : Type*} [Fintype κ] (a b : κ → ℝ) :
    ∑ j, (a j + b j) = (∑ j, a j) + ∑ j, b j :=
  NecSuf.finite_sum_add' (R := ℝ) a b

/-- `finite_sum_of_negated_real_numbers` を `NecSuf.finite_sum_neg_fin'`（係数 `ℝ`）の特殊化として得る。
二つの仮定は ℝ の `neg_add`（`-(a + b) = -a + -b`）と `neg_zero`（`-0 = 0`）で与える。 -/
theorem finite_sum_of_negated_real_numbers_of_necSuf (m : ℕ) (x : Fin m → ℝ) :
    ∑ j, -(x j) = -(∑ j, x j) :=
  NecSuf.finite_sum_neg_fin' (R := ℝ) neg_add neg_zero m x

/-- `finite_sum_of_real_scalar_multiples` を `NecSuf.finite_sum_mul_left_fin'`（係数 `ℝ`）の特殊化として得る。
空の和の仮定 `c0 = 0` は ℝ の `mul_zero` で与える。 -/
theorem finite_sum_of_real_scalar_multiples_of_necSuf (m : ℕ) (c : ℝ) (x : Fin m → ℝ) :
    ∑ j, c * x j = c * ∑ j, x j :=
  NecSuf.finite_sum_mul_left_fin' (R := ℝ) c (mul_zero c) m x

/-- `finite_sum_of_nonnegative_reals_is_at_least_each_term` を `NecSuf.finite_sum_ge_term_fin'`（係数 `ℝ`）の特殊化として得る。 -/
theorem finite_sum_of_nonnegative_reals_ge_term_of_necSuf (m : ℕ) (a : Fin m → ℝ)
    (ha : ∀ j, 0 ≤ a j) (k : Fin m) : ∑ j, a j ≥ a k :=
  NecSuf.finite_sum_ge_term_fin' (R := ℝ) m a ha k

/-- `finite_sum_of_real_numbers_triangle_inequality` を `NecSuf.finite_sum_subadditive_fin'`（`R = S := ℝ`、`f := |·|`）の特殊化として得る。
劣加法性は必要十分版の `NecSuf.abs_add_le'`（`real_abs_triangle_inequality` の必要十分版）、空の和の仮定 `|0| ≤ 0` は `abs_zero` で与える。 -/
theorem finite_sum_of_real_numbers_triangle_inequality_of_necSuf (m : ℕ) (a : Fin m → ℝ) :
    |∑ j, a j| ≤ ∑ j, |a j| :=
  NecSuf.finite_sum_subadditive_fin' (fun r : ℝ => |r|) NecSuf.abs_add_le' abs_zero.le m a

/-- `finite_sum_of_real_numbers_is_monotone` を `NecSuf.finite_sum_le_fin'`（係数 `ℝ`）の特殊化として得る。 -/
theorem finite_sum_of_real_numbers_is_monotone_of_necSuf (m : ℕ) (a b : Fin m → ℝ)
    (hab : ∀ j, a j ≤ b j) : ∑ j, a j ≤ ∑ j, b j :=
  NecSuf.finite_sum_le_fin' (R := ℝ) m a b hab

/-- `finite_sum_of_real_numbers_moves_one_term_to_end` を `NecSuf.finite_sum_skip_index_succ'`（係数 `ℝ`）の特殊化として得る。 -/
theorem finite_sum_of_real_numbers_moves_one_term_to_end_of_necSuf (n : ℕ) (b : Fin (n + 2) → ℝ) (k : Fin (n + 2)) :
    ∑ j, b j = (∑ j : Fin (n + 1), b (skipIndex k j)) + b k :=
  NecSuf.finite_sum_skip_index_succ' (R := ℝ) n b k

end Ising2D
