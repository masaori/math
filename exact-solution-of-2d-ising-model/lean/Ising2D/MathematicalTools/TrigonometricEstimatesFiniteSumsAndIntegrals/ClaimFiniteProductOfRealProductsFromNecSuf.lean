/-
# 実数の積の有限積は有限積の積（具体版を必要十分版から導く）

具体版 `ClaimFiniteProductOfRealProducts.lean` の主張を、必要十分版
`Ising2D/NecSuf/FiniteProductOfProducts.lean` の `R := ℝ`、`hmed := mul_mul_mul_comm`（人手の「ℝ で `(ab)(cd) = (ac)(bd)`」）の
特殊化として得る。人手のラベルは `finite_product_of_real_products`。

ℝ の `Finset.prod` と `NecSuf.finProdLeft` の一致は `real_finset_prod_eq_finProdLeft`（`ClaimRealExpOfFiniteSumFromNecSuf.lean`）で受ける。
-/
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimFiniteProductOfRealProducts
import Ising2D.MathematicalTools.MatrixExponentialAndCommutators.ClaimRealExpOfFiniteSumFromNecSuf
import Ising2D.NecSuf.FiniteProductOfProducts

namespace Ising2D

/-- `finite_product_of_real_products` を `NecSuf.finProdLeft_mul'`（`R := ℝ`、`hmed := mul_mul_mul_comm`）の特殊化として得る。 -/
theorem finite_product_of_real_products_of_necSuf (m : ℕ) (x y : Fin (m + 1) → ℝ) :
    ∏ j, (x j * y j) = (∏ j, x j) * (∏ j, y j) := by
  rw [real_finset_prod_eq_finProdLeft m (fun j => x j * y j), real_finset_prod_eq_finProdLeft m x,
    real_finset_prod_eq_finProdLeft m y]
  exact NecSuf.finProdLeft_mul' mul_mul_mul_comm m x y

end Ising2D
