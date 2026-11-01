/-
# 単位行列とスカラー倍の、行列同士の積での性質（具体版を必要十分版から導く）

具体版 `ClaimIdentityAndScalarMultipleInMatrixProduct.lean` の主張を、必要十分版
`Ising2D/NecSuf/MatrixProductIdentityAndScalar.lean` の係数 `R := ℂ`、添字 `Fin m`・`Fin n`・`Fin p` の特殊化として得る。
人手のラベルは `identity_matrix_is_left_unit_of_mat_mult`・`identity_matrix_is_right_unit_of_mat_mult`・
`scalar_multiple_factors_out_of_left_factor`・`scalar_multiple_factors_out_of_right_factor`。
-/
import Ising2D.NecSuf.MatrixProductIdentityAndScalar
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

end Ising2D
