/-
# 同じ指数の実数の冪の積は積の冪に等しい（具体版を必要十分版から導く）

具体版 `ClaimProductOfRealPowersIsPowerOfProduct.lean` の主張を、必要十分版
`Ising2D/NecSuf/ProductOfPowersIsPowerOfProduct.lean` の `R := ℝ` の特殊化として得る。
人手のラベルは `product_of_real_powers_is_power_of_product`。仮定 `hswap` は ℝ の `mul_mul_mul_comm` で埋める。
-/
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimProductOfRealPowersIsPowerOfProduct
import Ising2D.NecSuf.ProductOfPowersIsPowerOfProduct

namespace Ising2D

/-- `product_of_real_powers_is_power_of_product` を `NecSuf.pow_mul_pow_eq_mul_pow'`（`R := ℝ`）の特殊化として得る。 -/
theorem product_of_real_powers_is_power_of_product_of_necSuf (m : ℕ) (a b : ℝ) :
    a ^ m * b ^ m = (a * b) ^ m :=
  NecSuf.pow_mul_pow_eq_mul_pow' (fun p q r s => mul_mul_mul_comm p q r s) m a b

end Ising2D
