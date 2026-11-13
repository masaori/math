/-
# 一つの項のほかが 0 の有限和はその項に等しい（具体版を必要十分版から導く）

具体版 `ClaimFiniteSumWithSingleNonzeroTerm.lean` の `finite_sum_with_single_nonzero_term_succ`（人手 `finite_sum_with_single_nonzero_term`）を、
必要十分版 `Ising2D/NecSuf/FiniteSumWithSingleNonzeroTerm.lean` の `NecSuf.finSumLeft_single'` の `G := ℂ` の特殊化として得る。
具体版の有限和（`Finset.sum`）と必要十分版の `finSumLeft` は、どちらも `def_finite_sum_of_complex_numbers` の 2 つの式を節に持つので一致する
（`complex_finset_sum_eq_finSumLeft`）。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimFiniteSumWithSingleNonzeroTerm
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesFiniteSumFromNecSuf
import Ising2D.NecSuf.FiniteSumWithSingleNonzeroTerm

namespace Ising2D

/-- `finite_sum_with_single_nonzero_term_succ` を `NecSuf.finSumLeft_single'`（`G := ℂ`）として得る。 -/
theorem finite_sum_with_single_nonzero_term_succ_of_necSuf (m : ℕ) (z : Fin (m + 1) → ℂ) (n : Fin (m + 1))
    (hz : ∀ j, j ≠ n → z j = 0) : ∑ j, z j = z n := by
  rw [complex_finset_sum_eq_finSumLeft]
  exact NecSuf.finSumLeft_single' m z n hz

end Ising2D
