/-
# 単位行列とスカラー倍の、行列同士の積での性質（具体版を必要十分版から導く）

具体版 `ClaimIdentityAndScalarMultipleInMatrixProduct.lean` の主張を、必要十分版
`Ising2D/NecSuf/MatrixProductIdentityAndScalar.lean` の係数 `R := ℂ`、添字 `Fin m`・`Fin n`・`Fin p` の特殊化として得る。
人手のラベルは `identity_matrix_is_left_unit_of_mat_mult`・`identity_matrix_is_right_unit_of_mat_mult`・
`scalar_multiple_factors_out_of_left_factor`・`scalar_multiple_factors_out_of_right_factor`。

`TensorPow M`（添字 `Conf M`）の系も同じ必要十分版の特殊化として置く。具体版は添字が `Fin m` の行列について述べてあり、
`Conf M` の行列には当てはまらないためである。
-/
import Ising2D.NecSuf.MatrixProductIdentityAndScalar
import Ising2D.Basic
import Mathlib.Data.Complex.Basic

namespace Ising2D

/-- `identity_matrix_mul` を `NecSuf.one_mul_matrix`（係数 `ℂ`）の特殊化として得る。 -/
theorem identity_matrix_mul_of_necSuf {m n : ℕ} (A : Matrix (Fin m) (Fin n) ℂ) :
    (1 : Matrix (Fin m) (Fin m) ℂ) * A = A :=
  NecSuf.one_mul_matrix A

/-- `mul_identity_matrix` を `NecSuf.mul_one_matrix`（係数 `ℂ`）の特殊化として得る。 -/
theorem mul_identity_matrix_of_necSuf {m n : ℕ} (A : Matrix (Fin m) (Fin n) ℂ) :
    A * (1 : Matrix (Fin n) (Fin n) ℂ) = A :=
  NecSuf.mul_one_matrix A

/-- `smul_mul_matrix` を `NecSuf.smul_mul_matrix'`（係数 `ℂ`）の特殊化として得る。 -/
theorem smul_mul_matrix_of_necSuf {m n p : ℕ} (a : ℂ) (A : Matrix (Fin m) (Fin n) ℂ)
    (B : Matrix (Fin n) (Fin p) ℂ) : (a • A) * B = a • (A * B) :=
  NecSuf.smul_mul_matrix' a A B

/-- `mul_smul_matrix` を `NecSuf.mul_smul_matrix'`（係数 `ℂ`）の特殊化として得る。 -/
theorem mul_smul_matrix_of_necSuf {m n p : ℕ} (a : ℂ) (A : Matrix (Fin m) (Fin n) ℂ)
    (B : Matrix (Fin n) (Fin p) ℂ) : A * (a • B) = a • (A * B) :=
  NecSuf.mul_smul_matrix' a A B

/-- `identity_matrix_is_left_unit_of_mat_mult` の `TensorPow M` での系（`NecSuf.one_mul_matrix` の添字 `Conf M` の特殊化）。 -/
theorem identity_matrix_mul_tensorPow {M : ℕ} (A : TensorPow M) : (1 : TensorPow M) * A = A :=
  NecSuf.one_mul_matrix A

/-- `identity_matrix_is_right_unit_of_mat_mult` の `TensorPow M` での系（`NecSuf.mul_one_matrix` の添字 `Conf M` の特殊化）。 -/
theorem mul_identity_matrix_tensorPow {M : ℕ} (A : TensorPow M) : A * (1 : TensorPow M) = A :=
  NecSuf.mul_one_matrix A

end Ising2D
