/-
# 実数の差の有限和と、非負の実数の有限和の下からの評価を、必要十分版の特殊化として得る

具体版 `ClaimFiniteSumsOfRealNumbers.lean` の主張を、必要十分版 `Ising2D/NecSuf/FiniteSumDifferenceAndNonnegativeTerm.lean` を
係数 `R := ℝ` に特殊化して得る。人手のラベルは `finite_sum_of_real_differences`,
`finite_sum_of_negated_real_numbers`, `finite_sum_of_nonnegative_reals_is_at_least_each_term`。人手証明と 1 対 1 に対応する形は具体版のほうである。
-/
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimFiniteSumsOfRealNumbers
import Ising2D.NecSuf.FiniteSumDifferenceAndNonnegativeTerm
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

/-- `finite_sum_of_nonnegative_reals_is_at_least_each_term` を `NecSuf.finite_sum_ge_term_fin'`（係数 `ℝ`）の特殊化として得る。 -/
theorem finite_sum_of_nonnegative_reals_ge_term_of_necSuf (m : ℕ) (a : Fin m → ℝ)
    (ha : ∀ j, 0 ≤ a j) (k : Fin m) : ∑ j, a j ≥ a k :=
  NecSuf.finite_sum_ge_term_fin' (R := ℝ) m a ha k

end Ising2D
