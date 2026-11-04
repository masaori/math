/-
# 実数の有限和の exp は exp の有限積（具体版を必要十分版から導く）

具体版 `ClaimRealExpOfFiniteSum.lean` の主張を、必要十分版 `Ising2D/NecSuf/AdditiveToMultiplicativeMapOfFiniteSum.lean` の
定義域 `G := ℝ`、値域 `R := ℝ`、写像 `f := Real.exp`、`hadd := Real.exp_add`（人手の `scalar_exp_product`）の特殊化として得る。
人手のラベルは `real_exp_of_finite_sum`。

具体版の有限和・有限積（`Finset.sum`・`Finset.prod`）と必要十分版の `finSumLeft`・`finProdLeft` は、どちらも
`def_finite_sum_of_real_numbers`・`def_finite_product_of_real_numbers` の 2 つの式を節に持つので一致する
（`real_finset_sum_eq_finSumLeft`・`real_finset_prod_eq_finProdLeft`）。
-/
import Ising2D.MathematicalTools.MatrixExponentialAndCommutators.ClaimRealExpOfFiniteSum
import Ising2D.NecSuf.AdditiveToMultiplicativeMapOfFiniteSum

namespace Ising2D

/-- ℝ の `Finset.sum` は `NecSuf.finSumLeft`（`G := ℝ`）である（2 つの節が一致する）。 -/
theorem real_finset_sum_eq_finSumLeft :
    ∀ (m : ℕ) (x : Fin (m + 1) → ℝ), ∑ j, x j = NecSuf.finSumLeft m x
  | 0, x => by rw [Fin.sum_univ_one, NecSuf.finSumLeft_zero]
  | m + 1, x => by
    rw [Fin.sum_univ_castSucc, NecSuf.finSumLeft_succ, real_finset_sum_eq_finSumLeft m]

/-- ℝ の `Finset.prod` は `NecSuf.finProdLeft`（`R := ℝ`）である（2 つの節が一致する）。 -/
theorem real_finset_prod_eq_finProdLeft :
    ∀ (m : ℕ) (y : Fin (m + 1) → ℝ), ∏ j, y j = NecSuf.finProdLeft m y
  | 0, y => by rw [Fin.prod_univ_one, NecSuf.finProdLeft_zero]
  | m + 1, y => by
    rw [Fin.prod_univ_castSucc, NecSuf.finProdLeft_succ, real_finset_prod_eq_finProdLeft m]

/-- `real_exp_of_finite_sum` を `NecSuf.map_finSumLeft`（`f := Real.exp`）の特殊化として得る。 -/
theorem real_exp_of_finite_sum_of_necSuf (m : ℕ) (x : Fin (m + 1) → ℝ) :
    Real.exp (∑ j, x j) = ∏ j, Real.exp (x j) := by
  rw [real_finset_sum_eq_finSumLeft, real_finset_prod_eq_finProdLeft]
  exact NecSuf.map_finSumLeft Real.exp Real.exp_add m x

end Ising2D
