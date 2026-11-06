/-
# 実数の有限積の包含は包含の有限積に等しい（具体版を必要十分版から導く）

具体版 `ClaimRealInclusionPreservesFiniteProduct.lean` の主張を、必要十分版
`Ising2D/NecSuf/MultiplicativeMapOfFiniteProduct.lean` の `R := ℝ`、`S := ℂ`、`f := (· : ℝ → ℂ)`、
`hmul := real_inclusion_mul`（人手 `real_inclusion_preserves_product`）の特殊化として得る。
人手のラベルは `real_inclusion_preserves_finite_product`。

ℝ の `Finset.prod` と `NecSuf.finProdLeft` の一致は `real_finset_prod_eq_finProdLeft`（`ClaimRealExpOfFiniteSumFromNecSuf.lean`）で、
ℂ の一致はこのファイルの `complex_finset_prod_eq_finProdLeft`（同じ形の 2 節）で受ける。
-/
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesFiniteProduct
import Ising2D.NecSuf.MultiplicativeMapOfFiniteProduct
import Ising2D.MathematicalTools.MatrixExponentialAndCommutators.ClaimRealExpOfFiniteSumFromNecSuf

namespace Ising2D

/-- ℂ の `Finset.prod` は `NecSuf.finProdLeft`（`R := ℂ`）である（2 つの節が一致する）。 -/
theorem complex_finset_prod_eq_finProdLeft :
    ∀ (m : ℕ) (z : Fin (m + 1) → ℂ), ∏ j, z j = NecSuf.finProdLeft m z
  | 0, z => by rw [Fin.prod_univ_one, NecSuf.finProdLeft_zero]
  | m + 1, z => by
    rw [Fin.prod_univ_castSucc, NecSuf.finProdLeft_succ, complex_finset_prod_eq_finProdLeft m]

/-- `real_inclusion_preserves_finite_product` を `NecSuf.finProdLeft_map_of_mul`（`f := (· : ℝ → ℂ)`、
`hmul := real_inclusion_mul`）の特殊化として得る。 -/
theorem real_inclusion_preserves_finite_product_of_necSuf (m : ℕ) (r : Fin (m + 1) → ℝ) :
    ∏ j, ((r j : ℝ) : ℂ) = ((∏ j, r j : ℝ) : ℂ) := by
  rw [complex_finset_prod_eq_finProdLeft, real_finset_prod_eq_finProdLeft]
  exact NecSuf.finProdLeft_map_of_mul (fun a : ℝ => (a : ℂ)) real_inclusion_mul m r

end Ising2D
