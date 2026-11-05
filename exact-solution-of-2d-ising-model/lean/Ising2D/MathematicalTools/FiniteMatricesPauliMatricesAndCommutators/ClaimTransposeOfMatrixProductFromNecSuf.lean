/-
# 行列の積の転置は転置を逆の順に掛けた積（具体版を必要十分版から導く）

具体版 `ClaimTransposeOfMatrixProduct.lean` の主張を、必要十分版 `Ising2D/NecSuf/TransposeOfMatrixProduct.lean` の
係数 `R := ℂ`、添字 `Fin m`・`Fin n`・`Fin p` の特殊化として得る。人手のラベルは `transpose_of_matrix_product`。

`TensorPow M`（添字 `Conf M`）の系も同じ必要十分版の特殊化として置く。具体版は添字が `Fin m` の行列について述べてあり、
`Conf M` の行列には当てはまらないためである（`ClaimTransposeOfMatrixSumsAndScalarMultiplesFromNecSuf.lean` と同じ）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimTransposeOfMatrixProduct
import Ising2D.NecSuf.TransposeOfMatrixProduct
import Ising2D.Basic

namespace Ising2D

open Matrix

/-- `matrix_transpose_mul` を `NecSuf.transpose_mul_matrix'`（係数 `ℂ`）の特殊化として得る。 -/
theorem matrix_transpose_mul_of_necSuf {m n p : ℕ} (A : Matrix (Fin m) (Fin n) ℂ) (B : Matrix (Fin n) (Fin p) ℂ) :
    (A * B)ᵀ = Bᵀ * Aᵀ :=
  NecSuf.transpose_mul_matrix' A B

/-- `transpose_of_matrix_product` の `TensorPow M` での系（`NecSuf.transpose_mul_matrix'` の添字 `Conf M` の特殊化）。 -/
theorem transpose_mul_tensorPow {M : ℕ} (A B : TensorPow M) : (A * B)ᵀ = Bᵀ * Aᵀ :=
  NecSuf.transpose_mul_matrix' A B

end Ising2D
