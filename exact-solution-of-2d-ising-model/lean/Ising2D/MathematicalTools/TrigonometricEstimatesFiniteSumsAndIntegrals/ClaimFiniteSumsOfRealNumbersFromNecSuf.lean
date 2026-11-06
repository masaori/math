/-
# 実数の差の有限和と、非負の実数の有限和の下からの評価を、必要十分版の特殊化として得る

具体版 `ClaimFiniteSumsOfRealNumbers.lean` の主張を、必要十分版 `Ising2D/NecSuf/FiniteSumDifferenceAndNonnegativeTerm.lean` を
係数 `R := ℝ` に特殊化して得る。人手のラベルは `finite_sum_of_real_differences`,
`finite_sum_of_negated_real_numbers`, `finite_sum_of_real_scalar_multiples`, `finite_sum_of_nonnegative_reals_is_at_least_each_term`,
`finite_sum_of_real_numbers_triangle_inequality`, `finite_sum_of_real_numbers_is_monotone`（この 2 つは必要十分版 `Ising2D/NecSuf/FiniteSumSubadditiveAndMonotone.lean`）。人手証明と 1 対 1 に対応する形は具体版のほうである。
-/
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimFiniteSumsOfRealNumbers
import Ising2D.NecSuf.FiniteSumDifferenceAndNonnegativeTerm
import Ising2D.NecSuf.FiniteSumSubadditiveAndMonotone
import Ising2D.NecSuf.AbsoluteValueBoundsTriangleAndProduct
import Mathlib.Data.Real.Basic

namespace Ising2D

/-- `finite_sum_of_real_differences` を `NecSuf.finite_sum_sub_fin'`（係数 `ℝ`）の特殊化として得る。 -/
theorem finite_sum_of_real_differences_of_necSuf (m : ℕ) (a b : Fin m → ℝ) :
    ∑ j, (a j - b j) = (∑ j, a j) - ∑ j, b j :=
  NecSuf.finite_sum_sub_fin' (R := ℝ) m a b

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

end Ising2D
