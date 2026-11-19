/-
# 実数の有限積から先頭の因子を外へ出せる（具体版を必要十分版から導く）

具体版 `ClaimFiniteProductOfRealNumbersSplitsOffFirstFactor.lean` の主張を、必要十分版
`Ising2D/NecSuf/FiniteProductLeftFirstFactor.lean` の `R := ℝ`、`hassoc := mul_assoc`（人手の「ℝ の乗法の結合律」）の
特殊化として得る。人手のラベルは `finite_product_of_real_numbers_splits_off_first_factor`。

ℝ の `Finset.prod` と `NecSuf.finProdLeft` の一致は `real_finset_prod_eq_finProdLeft`（`ClaimRealExpOfFiniteSumFromNecSuf.lean`）で受ける。
-/
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimFiniteProductOfRealNumbersSplitsOffFirstFactor
import Ising2D.MathematicalTools.MatrixExponentialAndCommutators.ClaimRealExpOfFiniteSumFromNecSuf
import Ising2D.NecSuf.FiniteProductLeftFirstFactor

namespace Ising2D

/-- `finite_product_of_real_numbers_splits_off_first_factor` を `NecSuf.finProdLeft_succ_first`（`R := ℝ`、`hassoc := mul_assoc`）の
特殊化として得る。 -/
theorem finite_product_of_real_numbers_splits_off_first_factor_of_necSuf (m : ℕ) (r : Fin (m + 2) → ℝ) :
    ∏ j, r j = r 0 * ∏ j : Fin (m + 1), r j.succ := by
  rw [real_finset_prod_eq_finProdLeft (m + 1) r, real_finset_prod_eq_finProdLeft m (fun j => r j.succ)]
  exact NecSuf.finProdLeft_succ_first mul_assoc m r

end Ising2D
