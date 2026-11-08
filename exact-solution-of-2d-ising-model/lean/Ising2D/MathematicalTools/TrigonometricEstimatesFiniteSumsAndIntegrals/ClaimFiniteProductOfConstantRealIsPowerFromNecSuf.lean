/-
# 実数の定数の有限積は冪に等しい（具体版を必要十分版から導く）

具体版 `ClaimFiniteProductOfConstantRealIsPower.lean` の主張を、必要十分版
`Ising2D/NecSuf/FiniteProductOfConstantIsPower.lean` の `R := ℝ` の特殊化として得る。
人手のラベルは `finite_product_of_constant_real_is_power`。

ℝ の `Finset.prod` と `NecSuf.finProdLeft` の一致は `real_finset_prod_eq_finProdLeft`（`ClaimRealExpOfFiniteSumFromNecSuf.lean`）で受ける。
-/
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimFiniteProductOfConstantRealIsPower
import Ising2D.MathematicalTools.MatrixExponentialAndCommutators.ClaimRealExpOfFiniteSumFromNecSuf
import Ising2D.NecSuf.FiniteProductOfConstantIsPower

namespace Ising2D

/-- `finite_product_of_constant_real_is_power` を `NecSuf.finProdLeft_const_eq_pow'`（`R := ℝ`）の特殊化として得る。 -/
theorem finite_product_of_constant_real_is_power_of_necSuf (m : ℕ) (r : ℝ) :
    ∏ _j : Fin (m + 1), r = r ^ (m + 1) := by
  rw [real_finset_prod_eq_finProdLeft]
  exact NecSuf.finProdLeft_const_eq_pow' m r

end Ising2D
