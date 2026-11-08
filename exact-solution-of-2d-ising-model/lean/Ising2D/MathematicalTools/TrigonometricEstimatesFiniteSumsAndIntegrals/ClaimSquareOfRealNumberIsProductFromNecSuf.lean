/-
# 実数の二乗は積に等しい（具体版を必要十分版から導く）

具体版 `ClaimSquareOfRealNumberIsProduct.lean` の主張を、必要十分版
`Ising2D/NecSuf/SquareIsProduct.lean` の `R := ℝ` の特殊化として得る。
人手のラベルは `square_of_real_number_is_product`。
-/
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimSquareOfRealNumberIsProduct
import Ising2D.NecSuf.SquareIsProduct

namespace Ising2D

/-- `square_of_real_number_is_product` を `NecSuf.sq_eq_mul_self'`（`R := ℝ`）の特殊化として得る。 -/
theorem square_of_real_number_is_product_of_necSuf (r : ℝ) : r ^ 2 = r * r :=
  NecSuf.sq_eq_mul_self' r

end Ising2D
