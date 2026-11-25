/-
# 実数の有限和の包含は包含の有限和に等しい（具体版を必要十分版から導く）

具体版 `ClaimRealInclusionPreservesFiniteSum.lean` の `real_inclusion_of_finite_sum_succ`（人手 `real_inclusion_preserves_finite_sum` の `m ∈ ℤ_{≥1}` の場合）を、
必要十分版 `Ising2D/NecSuf/AdditiveMapPreservesFiniteSum.lean` の `NecSuf.map_finSumLeft_of_map_add'` の
`G := ℝ`、`H := ℂ`、`f := ι_{ℝ→ℂ}`（`Complex.ofReal`）の特殊化として得る。仮定の `f(a + b) = f(a) + f(b)` は
具体版 `real_inclusion_add`（人手 `real_inclusion_preserves_sum`）を右辺から左辺へ使ったものである。

具体版の有限和（`Finset.sum`）と必要十分版の `finSumLeft` は、どちらも `def_finite_sum_of_real_numbers`・
`def_finite_sum_of_complex_numbers` の 2 つの式を節に持つので一致する（ℝ は `real_finset_sum_eq_finSumLeft`、ℂ は
`complex_finset_sum_eq_finSumLeft`）。

主の具体版 `real_inclusion_of_finite_sum`（`m ∈ ℤ_{≥0}`）は、`NecSuf.map_finSumLeftFromEmpty_of_map_add_of_map_zero'` の
同じ `f := ι_{ℝ→ℂ}`、`hzero` に `0_ℂ := (0_ℝ)_ℂ`（具体版 `complex_zero_eq_ofReal_zero`、人手 `inclusion_rr_to_cc`）を右辺から左辺へ使ったものを渡して得る。
項の無い族を含む `Finset.sum` と `NecSuf.finSumLeftFromEmpty` は、3 つの節（空の和を含む）が一致する
（ℝ は `real_finset_sum_eq_finSumLeftFromEmpty`、ℂ は `complex_finset_sum_eq_finSumLeftFromEmpty`）。
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

/-- ℂ の `Fin n` の上の `Finset.sum` は `NecSuf.finSumLeftFromEmpty`（`G := ℂ`）である（3 つの節が一致する）。 -/
theorem complex_finset_sum_eq_finSumLeftFromEmpty :
    ∀ (n : ℕ) (z : Fin n → ℂ), ∑ j, z j = NecSuf.finSumLeftFromEmpty n z
  | 0, z => by rw [Fin.sum_univ_zero, NecSuf.finSumLeftFromEmpty_zero]
  | m + 1, z => by rw [NecSuf.finSumLeftFromEmpty_succ, complex_finset_sum_eq_finSumLeft m]

/-- ℝ の `Fin n` の上の `Finset.sum` は `NecSuf.finSumLeftFromEmpty`（`G := ℝ`）である（3 つの節が一致する）。 -/
theorem real_finset_sum_eq_finSumLeftFromEmpty :
    ∀ (n : ℕ) (r : Fin n → ℝ), ∑ j, r j = NecSuf.finSumLeftFromEmpty n r
  | 0, r => by rw [Fin.sum_univ_zero, NecSuf.finSumLeftFromEmpty_zero]
  | m + 1, r => by rw [NecSuf.finSumLeftFromEmpty_succ, real_finset_sum_eq_finSumLeft m]

/-- `real_inclusion_of_finite_sum` を `NecSuf.map_finSumLeftFromEmpty_of_map_add_of_map_zero'` の `f := ι_{ℝ→ℂ}` として得る。 -/
theorem real_inclusion_of_finite_sum_of_necSuf (m : ℕ) (r : Fin m → ℝ) :
    ∑ j, ((r j : ℝ) : ℂ) = ((∑ j, r j : ℝ) : ℂ) := by
  rw [complex_finset_sum_eq_finSumLeftFromEmpty, real_finset_sum_eq_finSumLeftFromEmpty]
  exact NecSuf.map_finSumLeftFromEmpty_of_map_add_of_map_zero' (fun x : ℝ => (x : ℂ))
    complex_zero_eq_ofReal_zero.symm (fun a b => (real_inclusion_add a b).symm) m r

end Ising2D
