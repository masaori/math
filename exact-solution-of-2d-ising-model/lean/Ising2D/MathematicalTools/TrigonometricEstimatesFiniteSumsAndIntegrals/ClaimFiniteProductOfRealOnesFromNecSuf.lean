/-
# 実数の 1 の有限積は 1（具体版を必要十分版から導く）

具体版 `ClaimFiniteProductOfRealOnes.lean` の主張を、必要十分版 `Ising2D/NecSuf/FiniteProductLeft.lean` の
`finProdLeft_const_one'` の `R := ℝ`、`h := mul_one 1`（人手の「ℝ の乗法の単位元 `p·1 = p`（`p → 1`）」）の特殊化として得る。
人手のラベルは `finite_product_of_real_ones`。

ℝ の `Finset.prod` と `NecSuf.finProdLeft` の一致は `real_finset_prod_eq_finProdLeft`（`ClaimRealExpOfFiniteSumFromNecSuf.lean`）で受ける。
-/
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimFiniteProductOfRealOnes
import Ising2D.MathematicalTools.MatrixExponentialAndCommutators.ClaimRealExpOfFiniteSumFromNecSuf
import Ising2D.NecSuf.FiniteProductLeft

namespace Ising2D

/-- `finite_product_of_real_ones` を `NecSuf.finProdLeft_const_one'`（`R := ℝ`、`h := mul_one 1`）の特殊化として得る。 -/
theorem finite_product_of_real_ones_of_necSuf (m : ℕ) : ∏ _j : Fin (m + 1), (1 : ℝ) = 1 := by
  rw [real_finset_prod_eq_finProdLeft m (fun _ => (1 : ℝ))]
  exact NecSuf.finProdLeft_const_one' (mul_one 1) m

end Ising2D
