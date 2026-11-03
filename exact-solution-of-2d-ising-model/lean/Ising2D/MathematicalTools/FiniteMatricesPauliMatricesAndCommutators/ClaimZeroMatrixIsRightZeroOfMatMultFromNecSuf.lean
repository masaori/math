/-
# 零行列を右から掛けると零行列（具体版を必要十分版から導く）

具体版 `ClaimZeroMatrixIsRightZeroOfMatMult.lean` の主張を、必要十分版 `Ising2D/NecSuf/MatrixMulZero.lean` の
係数 `R := ℂ`、添字 `Fin m`・`Fin n`・`Fin p` の特殊化として得る。`hz := mul_zero`（人手の `complex_times_zero_is_zero`）を渡す。
人手のラベルは `zero_matrix_is_right_zero_of_mat_mult`。

`TensorPow M`（添字 `Conf M`）の系も同じ必要十分版の特殊化として置く。具体版は添字が `Fin m` の行列について述べてあり、
`Conf M` の行列には当てはまらないためである。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimZeroMatrixIsRightZeroOfMatMult
import Ising2D.NecSuf.MatrixMulZero
import Ising2D.Basic

namespace Ising2D

/-- `matrix_mul_zero_matrix` を `NecSuf.mul_zero_matrix'`（係数 `ℂ`）の特殊化として得る。 -/
theorem matrix_mul_zero_matrix_of_necSuf {m n p : ℕ} (A : Matrix (Fin m) (Fin n) ℂ) :
    A * (0 : Matrix (Fin n) (Fin p) ℂ) = 0 :=
  NecSuf.mul_zero_matrix' (fun x => mul_zero x) A

/-- `zero_matrix_is_right_zero_of_mat_mult` の `TensorPow M` での系（`NecSuf.mul_zero_matrix'` の添字 `Conf M` の特殊化）。 -/
theorem matrix_mul_zero_matrix_tensorPow {M : ℕ} (A : TensorPow M) : A * (0 : TensorPow M) = 0 :=
  NecSuf.mul_zero_matrix' (fun x => mul_zero x) A

/-- `zero_matrix_is_right_zero_of_mat_mult`（`p → 1`）の、`TensorPow M` と `2^M` 行 1 列の行列での系
（`NecSuf.mul_zero_matrix'` の特殊化）。 -/
theorem matrix_mul_zero_colVec {M : ℕ} (A : TensorPow M) : A * (0 : Matrix (Conf M) (Fin 1) ℂ) = 0 :=
  NecSuf.mul_zero_matrix' (fun x => mul_zero x) A

end Ising2D
