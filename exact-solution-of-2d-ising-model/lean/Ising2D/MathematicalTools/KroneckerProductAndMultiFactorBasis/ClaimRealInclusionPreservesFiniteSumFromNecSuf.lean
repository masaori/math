/-
# 実数の有限和の包含は包含の有限和に等しい（具体版を必要十分版から導く）

具体版 `ClaimRealInclusionPreservesFiniteSum.lean` の `real_inclusion_of_finite_sum_succ`（人手 `real_inclusion_preserves_finite_sum`）を、
必要十分版 `Ising2D/NecSuf/AdditiveMapPreservesFiniteSum.lean` の `NecSuf.map_finSumLeft_of_map_add'` の
`G := ℝ`、`H := ℂ`、`f := ι_{ℝ→ℂ}`（`Complex.ofReal`）の特殊化として得る。仮定の `f(a + b) = f(a) + f(b)` は
具体版 `real_inclusion_add`（人手 `real_inclusion_preserves_sum`）を右辺から左辺へ使ったものである。

具体版の有限和（`Finset.sum`）と必要十分版の `finSumLeft` は、どちらも `def_finite_sum_of_real_numbers`・
`def_finite_sum_of_complex_numbers` の 2 つの式を節に持つので一致する（ℝ は `real_finset_sum_eq_finSumLeft`、ℂ は
`complex_finset_sum_eq_finSumLeft`）。
-/
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesFiniteSum
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesSum
import Ising2D.MathematicalTools.MatrixExponentialAndCommutators.ClaimRealExpOfFiniteSumFromNecSuf
import Ising2D.NecSuf.AdditiveMapPreservesFiniteSum

namespace Ising2D

/-- ℂ の `Finset.sum` は `NecSuf.finSumLeft`（`G := ℂ`）である（2 つの節が一致する）。 -/
theorem complex_finset_sum_eq_finSumLeft :
    ∀ (m : ℕ) (z : Fin (m + 1) → ℂ), ∑ j, z j = NecSuf.finSumLeft m z
  | 0, z => by rw [Fin.sum_univ_one, NecSuf.finSumLeft_zero]
  | m + 1, z => by
    rw [Fin.sum_univ_castSucc, NecSuf.finSumLeft_succ, complex_finset_sum_eq_finSumLeft m]

/-- `real_inclusion_of_finite_sum_succ` を `NecSuf.map_finSumLeft_of_map_add'` の `f := ι_{ℝ→ℂ}` として得る。 -/
theorem real_inclusion_of_finite_sum_succ_of_necSuf (m : ℕ) (r : Fin (m + 1) → ℝ) :
    ∑ j, ((r j : ℝ) : ℂ) = ((∑ j, r j : ℝ) : ℂ) := by
  rw [complex_finset_sum_eq_finSumLeft, real_finset_sum_eq_finSumLeft]
  exact NecSuf.map_finSumLeft_of_map_add' (fun x : ℝ => (x : ℂ))
    (fun a b => (real_inclusion_add a b).symm) m r

end Ising2D
