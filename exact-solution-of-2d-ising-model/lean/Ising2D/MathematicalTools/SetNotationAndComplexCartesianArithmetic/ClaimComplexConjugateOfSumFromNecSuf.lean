/-
# 具体版 `complex_conjugate_of_finite_sum_succ` を必要十分版の特殊化として得る

人手のラベル: `complex_conjugate_of_sum`。具体版は同じフォルダの `ClaimComplexConjugateOfSumProductDifference.lean`、
必要十分版は `Ising2D/NecSuf/AdditiveMapPreservesFiniteSum.lean` の `NecSuf.map_finSumLeft_of_map_add'`。
`f := \overline{(·)}`（`starRingEnd ℂ`）、`hadd` に具体版の準備 `complex_conjugate_of_add` を渡す。
必要十分版の主張は `Σ f(x_j) = f(Σ x_j)` の向きなので、最後に左右を入れ替える。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimComplexConjugateOfSumProductDifference
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesFiniteSumFromNecSuf

namespace Ising2D

/-- `complex_conjugate_of_finite_sum_succ` を `NecSuf.map_finSumLeft_of_map_add'` の `f := starRingEnd ℂ` として得る。 -/
theorem complex_conjugate_of_finite_sum_succ_of_necSuf (m : ℕ) (z : Fin (m + 1) → ℂ) :
    (starRingEnd ℂ) (∑ j, z j) = ∑ j, (starRingEnd ℂ) (z j) := by
  rw [complex_finset_sum_eq_finSumLeft, complex_finset_sum_eq_finSumLeft]
  exact (NecSuf.map_finSumLeft_of_map_add' (starRingEnd ℂ) complex_conjugate_of_add m z).symm

end Ising2D
