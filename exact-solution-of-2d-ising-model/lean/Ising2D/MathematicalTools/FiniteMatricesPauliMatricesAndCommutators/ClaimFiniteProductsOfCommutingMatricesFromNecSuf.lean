/-
# 各因子と可換な行列は有限積とも可換、二つの有限積の積は因子ごとの積の有限積（具体版を必要十分版から導く）

具体版 `ClaimFiniteProductsOfCommutingMatrices.lean` の主張を、必要十分版 `Ising2D/NecSuf/FiniteProductCommute.lean` の
`R := Mat(n,ℂ)` の特殊化として得る。人手のラベルは `matrix_commuting_with_each_factor_commutes_with_finite_product`・
`product_of_two_finite_products_of_matrices`。

`TensorPow M`（添字 `Conf M`）の系も同じ必要十分版の特殊化として置く。具体版は添字が `Fin n` の行列について述べてあり、
`Conf M` の行列には当てはまらないためである。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimFiniteProductsOfCommutingMatrices
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.DefinitionFiniteProductOfMatricesFromNecSuf
import Ising2D.NecSuf.FiniteProductCommute

namespace Ising2D

/-- `matrix_commuting_with_each_factor_commutes_with_finite_product` を `NecSuf.commute_finProdLeft`（`R := Mat(n,ℂ)`）の特殊化として得る。 -/
theorem matrix_commuting_with_each_factor_commutes_with_finite_product_of_necSuf {n : ℕ} (r : ℕ)
    (X : Matrix (Fin n) (Fin n) ℂ) (A : Fin (r + 1) → Matrix (Fin n) (Fin n) ℂ) (h : ∀ j, X * A j = A j * X) :
    X * finiteMatrixProduct r A = finiteMatrixProduct r A * X := by
  rw [finiteMatrixProduct_eq_finProdLeft]
  exact NecSuf.commute_finProdLeft r X A h

/-- `product_of_two_finite_products_of_matrices` を `NecSuf.finProdLeft_mul_finProdLeft`（`R := Mat(n,ℂ)`）の特殊化として得る。 -/
theorem product_of_two_finite_products_of_matrices_of_necSuf {n : ℕ} (r : ℕ)
    (A B : Fin (r + 1) → Matrix (Fin n) (Fin n) ℂ) (h : ∀ i j : Fin (r + 1), j < i → A i * B j = B j * A i) :
    finiteMatrixProduct r A * finiteMatrixProduct r B = finiteMatrixProduct r (fun j => A j * B j) := by
  rw [finiteMatrixProduct_eq_finProdLeft, finiteMatrixProduct_eq_finProdLeft, finiteMatrixProduct_eq_finProdLeft]
  exact NecSuf.finProdLeft_mul_finProdLeft r A B h

/-- `matrix_commuting_with_each_factor_commutes_with_finite_product` の `TensorPow M` での系。 -/
theorem commute_finProdLeft_tensorPow {M : ℕ} (r : ℕ) (X : TensorPow M) (A : Fin (r + 1) → TensorPow M)
    (h : ∀ j, X * A j = A j * X) : X * NecSuf.finProdLeft r A = NecSuf.finProdLeft r A * X :=
  NecSuf.commute_finProdLeft r X A h

/-- `product_of_two_finite_products_of_matrices` の `TensorPow M` での系。 -/
theorem finProdLeft_mul_finProdLeft_tensorPow {M : ℕ} (r : ℕ) (A B : Fin (r + 1) → TensorPow M)
    (h : ∀ i j : Fin (r + 1), j < i → A i * B j = B j * A i) :
    NecSuf.finProdLeft r A * NecSuf.finProdLeft r B = NecSuf.finProdLeft r (fun j => A j * B j) :=
  NecSuf.finProdLeft_mul_finProdLeft r A B h

end Ising2D
