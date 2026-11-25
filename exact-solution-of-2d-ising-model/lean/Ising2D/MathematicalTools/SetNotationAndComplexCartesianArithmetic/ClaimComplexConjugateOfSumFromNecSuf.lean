/-
# 具体版 `complex_conjugate_of_finite_sum_succ` を必要十分版の特殊化として得る

人手のラベル: `complex_conjugate_of_sum`。具体版は同じフォルダの `ClaimComplexConjugateOfSumProductDifference.lean`、
必要十分版は `Ising2D/NecSuf/AdditiveMapPreservesFiniteSum.lean` の `NecSuf.map_finSumLeft_of_map_add'`。
`f := \overline{(·)}`（`ℂ` の `star`）、`hadd` に具体版の準備 `complex_conjugate_of_add` を渡す。
必要十分版の主張は `Σ f(x_j) = f(Σ x_j)` の向きなので、最後に左右を入れ替える。
項の無い族を含む具体版 `complex_conjugate_star_finite_sum`（`ClaimComplexConjugateOfSumProductDifferenceStarForm.lean`）は、
`NecSuf.map_finSumLeftFromEmpty_of_map_add_of_map_zero'` の `f := star`、`hzero := complex_conjugate_star_zero` として得る
（`Finset.sum` との読み替え `complex_finset_sum_eq_finSumLeftFromEmpty` は `ClaimRealInclusionPreservesFiniteSumFromNecSuf.lean`）。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimComplexConjugateOfSumProductDifference
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesFiniteSumFromNecSuf
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimComplexConjugateOfSumProductDifferenceStarForm

namespace Ising2D

/-- `complex_conjugate_of_finite_sum_succ` を `NecSuf.map_finSumLeft_of_map_add'` の `f := star` として得る。 -/
theorem complex_conjugate_of_finite_sum_succ_of_necSuf (m : ℕ) (z : Fin (m + 1) → ℂ) :
    star (∑ j, z j) = ∑ j, star (z j) := by
  rw [complex_finset_sum_eq_finSumLeft, complex_finset_sum_eq_finSumLeft]
  exact (NecSuf.map_finSumLeft_of_map_add' star complex_conjugate_of_add m z).symm

/-- `complex_conjugate_star_finite_sum` を `NecSuf.map_finSumLeftFromEmpty_of_map_add_of_map_zero'` の `f := star` として得る。 -/
theorem complex_conjugate_star_finite_sum_of_necSuf (n : ℕ) (z : Fin n → ℂ) :
    star (∑ j, z j) = ∑ j, star (z j) := by
  rw [complex_finset_sum_eq_finSumLeftFromEmpty, complex_finset_sum_eq_finSumLeftFromEmpty]
  exact (NecSuf.map_finSumLeftFromEmpty_of_map_add_of_map_zero' star complex_conjugate_star_zero
    complex_conjugate_of_add n z).symm

end Ising2D
