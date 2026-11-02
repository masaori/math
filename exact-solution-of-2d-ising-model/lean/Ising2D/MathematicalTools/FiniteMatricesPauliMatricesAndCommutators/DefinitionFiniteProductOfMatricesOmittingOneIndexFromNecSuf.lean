/-
# 一つの添字を除いた行列の有限積と、有限積の一つの因子を末尾へ寄せること（具体版を必要十分版から導く）

具体版 `DefinitionFiniteProductOfMatricesOmittingOneIndex.lean` の定義と主張を、必要十分版
`Ising2D/NecSuf/FiniteProductOmittingOneIndex.lean` の `R := Mat(n,ℂ)` の特殊化として得る。
人手のラベルは `def_finite_product_of_matrices_omitting_one_index`・`moving_one_factor_of_finite_product_to_the_end`。

`TensorPow M`（添字 `Conf M`）の系も同じ必要十分版の特殊化として置く。具体版は添字が `Fin n` の行列について述べてあり、
`Conf M` の行列には当てはまらないためである。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.DefinitionFiniteProductOfMatricesOmittingOneIndex
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.DefinitionFiniteProductOfMatricesFromNecSuf
import Ising2D.NecSuf.FiniteProductOmittingOneIndex

namespace Ising2D

/-- 具体版の `finiteMatrixProductOmitting` は、必要十分版 `NecSuf.finProdLeftOmitting` の `R := Mat(n,ℂ)` の場合である。 -/
theorem finiteMatrixProductOmitting_eq_finProdLeftOmitting {n : ℕ} (r : ℕ) (ν : Fin (r + 2))
    (A : Fin (r + 2) → Matrix (Fin n) (Fin n) ℂ) :
    finiteMatrixProductOmitting r ν A = NecSuf.finProdLeftOmitting r ν A := by
  rw [finiteMatrixProductOmitting_def, finiteMatrixProduct_eq_finProdLeft]
  rfl

/-- `moving_one_factor_of_finite_product_to_the_end` を `NecSuf.finProdLeft_eq_omitting_mul`（`R := Mat(n,ℂ)`）の特殊化として得る。 -/
theorem moving_one_factor_of_finite_product_to_the_end_of_necSuf {n : ℕ} (r : ℕ) (ν : Fin (r + 2))
    (A : Fin (r + 2) → Matrix (Fin n) (Fin n) ℂ) (h : ∀ j, ν < j → A ν * A j = A j * A ν) :
    finiteMatrixProduct (r + 1) A = finiteMatrixProductOmitting r ν A * A ν := by
  rw [finiteMatrixProduct_eq_finProdLeft, finiteMatrixProductOmitting_eq_finProdLeftOmitting]
  exact NecSuf.finProdLeft_eq_omitting_mul r ν A h

/-- `moving_one_factor_of_finite_product_to_the_end` の `TensorPow M` での系。 -/
theorem finProdLeft_eq_omitting_mul_tensorPow {M : ℕ} (r : ℕ) (ν : Fin (r + 2)) (A : Fin (r + 2) → TensorPow M)
    (h : ∀ j, ν < j → A ν * A j = A j * A ν) :
    NecSuf.finProdLeft (r + 1) A = NecSuf.finProdLeftOmitting r ν A * A ν :=
  NecSuf.finProdLeft_eq_omitting_mul r ν A h

end Ising2D
