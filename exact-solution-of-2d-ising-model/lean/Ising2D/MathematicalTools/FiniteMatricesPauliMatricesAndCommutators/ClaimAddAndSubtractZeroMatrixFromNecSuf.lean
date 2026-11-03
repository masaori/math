/-
# 零行列を足す・引く・零行列の有限和（具体版を必要十分版から導く）

具体版 `ClaimAddAndSubtractZeroMatrix.lean` の主張を、必要十分版 `Ising2D/NecSuf/MatrixAddSubZero.lean` の
係数 `R := ℂ`、添字 `Fin m`・`Fin n` の特殊化として得る。人手のラベルは `matrix_plus_zero_matrix`・`zero_matrix_plus_matrix`・
`matrix_minus_zero_matrix`・`finite_sum_of_zero_matrices`。

`matrix_plus_zero_matrix`・`zero_matrix_plus_matrix`・`matrix_minus_zero_matrix` には `TensorPow M`（添字 `Conf M`）の系も同じ必要十分版の特殊化として置く。具体版は添字が
`Fin m` の行列について述べてあり、`Conf M` の行列には当てはまらないためである。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimAddAndSubtractZeroMatrix
import Ising2D.NecSuf.MatrixAddSubZero
import Ising2D.Basic

namespace Ising2D

/-- `matrix_add_zero_matrix` を `NecSuf.add_zero_matrix`（係数 `ℂ`）の特殊化として得る。 -/
theorem matrix_add_zero_matrix_of_necSuf {m n : ℕ} (X : Matrix (Fin m) (Fin n) ℂ) : X + 0 = X :=
  NecSuf.add_zero_matrix X

/-- `zero_matrix_add_matrix` を `NecSuf.zero_add_matrix`（係数 `ℂ`）の特殊化として得る。 -/
theorem zero_matrix_add_matrix_of_necSuf {m n : ℕ} (X : Matrix (Fin m) (Fin n) ℂ) : 0 + X = X :=
  NecSuf.zero_add_matrix X

/-- `matrix_sub_zero_matrix` を `NecSuf.sub_zero_matrix`（係数 `ℂ`）の特殊化として得る。 -/
theorem matrix_sub_zero_matrix_of_necSuf {m n : ℕ} (X : Matrix (Fin m) (Fin n) ℂ) : X - 0 = X :=
  NecSuf.sub_zero_matrix X

/-- `matrix_plus_zero_matrix` の `TensorPow M` での系（`NecSuf.add_zero_matrix` の添字 `Conf M` の特殊化）。 -/
theorem matrix_add_zero_matrix_tensorPow {M : ℕ} (X : TensorPow M) : X + 0 = X :=
  NecSuf.add_zero_matrix X

/-- `zero_matrix_plus_matrix` の `TensorPow M` での系（`NecSuf.zero_add_matrix` の添字 `Conf M` の特殊化）。 -/
theorem zero_matrix_add_matrix_tensorPow {M : ℕ} (X : TensorPow M) : 0 + X = X :=
  NecSuf.zero_add_matrix X

/-- `matrix_minus_zero_matrix` の `TensorPow M` での系（`NecSuf.sub_zero_matrix` の添字 `Conf M` の特殊化）。 -/
theorem matrix_sub_zero_matrix_tensorPow {M : ℕ} (X : TensorPow M) : X - 0 = X :=
  NecSuf.sub_zero_matrix X

/-- `finite_sum_of_zero_matrices` を `NecSuf.sum_zero_matrices`（係数 `ℂ`）の特殊化として得る。 -/
theorem finite_sum_of_zero_matrices_of_necSuf {m n : ℕ} (r : ℕ) :
    ∑ _j : Fin (r + 1), (0 : Matrix (Fin m) (Fin n) ℂ) = 0 :=
  NecSuf.sum_zero_matrices r

end Ising2D
