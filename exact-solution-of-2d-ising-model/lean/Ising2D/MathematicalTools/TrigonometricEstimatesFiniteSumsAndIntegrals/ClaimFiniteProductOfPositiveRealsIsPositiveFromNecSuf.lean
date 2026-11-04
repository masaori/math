/-
# 正の実数の有限積は正（具体版を必要十分版から導く）

具体版 `ClaimFiniteProductOfPositiveRealsIsPositive.lean` の主張を、必要十分版
`Ising2D/NecSuf/FiniteProductOfPositiveElementsIsPositive.lean` の `R := ℝ`、`hmul := mul_pos`（人手の「ℝ で `a > 0, b > 0` なら `ab > 0`」）の
特殊化として得る。人手のラベルは `finite_product_of_positive_reals_is_positive`。

ℝ の `Finset.prod` と `NecSuf.finProdLeft` の一致は `real_finset_prod_eq_finProdLeft`（`ClaimRealExpOfFiniteSumFromNecSuf.lean`）で受ける。
-/
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimFiniteProductOfPositiveRealsIsPositive
import Ising2D.MathematicalTools.MatrixExponentialAndCommutators.ClaimRealExpOfFiniteSumFromNecSuf
import Ising2D.NecSuf.FiniteProductOfPositiveElementsIsPositive

namespace Ising2D

/-- `finite_product_of_positive_reals_is_positive` を `NecSuf.finProdLeft_pos'`（`R := ℝ`、`hmul := mul_pos`）の特殊化として得る。 -/
theorem finite_product_of_positive_reals_is_positive_of_necSuf (m : ℕ) (r : Fin (m + 1) → ℝ)
    (hr : ∀ j, 0 < r j) : ∏ j, r j > 0 := by
  rw [real_finset_prod_eq_finProdLeft]
  exact NecSuf.finProdLeft_pos' (fun a b ha hb => mul_pos ha hb) m r hr

end Ising2D
