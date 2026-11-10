/-
# 複素数の二乗は積に等しい（具体版を必要十分版から導く）

具体版 `ClaimSquareOfComplexNumberIsProduct.lean` の主張を、必要十分版
`Ising2D/NecSuf/SquareIsProduct.lean` の `R := ℂ` の特殊化として得る。
人手のラベルは `square_of_complex_number_is_product`。
-/
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimSquareOfComplexNumberIsProduct
import Ising2D.NecSuf.SquareIsProduct
import Mathlib.Data.Complex.Basic

namespace Ising2D

/-- `square_of_complex_number_is_product` を `NecSuf.sq_eq_mul_self'`（`R := ℂ`）の特殊化として得る。 -/
theorem square_of_complex_number_is_product_of_necSuf (z : ℂ) : z ^ 2 = z * z :=
  NecSuf.sq_eq_mul_self' z

end Ising2D
