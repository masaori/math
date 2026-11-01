/-
# 単位行列・スカラー倍・差の数ベクトルへの作用（具体版を必要十分版から導く）

具体版 `ClaimIdentityScalarMultipleAndDifferenceOnVectors.lean` の主張を、必要十分版
`Ising2D/NecSuf/MatrixVectorIdentityScalarDifference.lean` の係数 `R := ℂ`、添字 `Fin m`・`Fin n` の特殊化として得る。
人手のラベルは `matrix_difference_zero_iff_equal`・`identity_matrix_is_left_unit_of_mat_mult`・
`scalar_multiple_factors_out_of_left_factor`・`matrix_difference_mul_vector`（前の 2 つの主張は右の因子が数ベクトルの場合）。

`matrix_difference_zero_iff_equal` の `TensorPow M`（添字 `Conf M`）での系も同じ必要十分版の特殊化として置く。
具体版は添字が `Fin m` の行列について述べてあり、`Conf M` の行列には当てはまらないためである。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityScalarMultipleAndDifferenceOnVectors
import Ising2D.NecSuf.MatrixVectorIdentityScalarDifference
import Ising2D.Basic

namespace Ising2D

open Matrix

/-- `matrix_sub_eq_zero_iff` を `NecSuf.sub_eq_zero_iff_matrix`（係数 `ℂ`）の特殊化として得る。 -/
theorem matrix_sub_eq_zero_iff_of_necSuf {m p : ℕ} (A B : Matrix (Fin m) (Fin p) ℂ) : A - B = 0 ↔ A = B :=
  NecSuf.sub_eq_zero_iff_matrix A B

/-- `vec_sub_eq_zero_iff` を `NecSuf.sub_eq_zero_iff_vec`（係数 `ℂ`）の特殊化として得る。 -/
theorem vec_sub_eq_zero_iff_of_necSuf {m : ℕ} (u w : Fin m → ℂ) : u - w = 0 ↔ u = w :=
  NecSuf.sub_eq_zero_iff_vec u w

/-- `identity_matrix_mulVec` を `NecSuf.one_mulVec_eq`（係数 `ℂ`）の特殊化として得る。 -/
theorem identity_matrix_mulVec_of_necSuf {n : ℕ} (v : Fin n → ℂ) :
    (1 : Matrix (Fin n) (Fin n) ℂ) *ᵥ v = v :=
  NecSuf.one_mulVec_eq v

/-- `smul_mulVec_eq` を `NecSuf.smul_mulVec_eq'`（係数 `ℂ`）の特殊化として得る。 -/
theorem smul_mulVec_eq_of_necSuf {m n : ℕ} (lam : ℂ) (B : Matrix (Fin m) (Fin n) ℂ) (v : Fin n → ℂ) :
    (lam • B) *ᵥ v = lam • (B *ᵥ v) :=
  NecSuf.smul_mulVec_eq' lam B v

/-- `sub_mulVec_eq` を `NecSuf.sub_mulVec_eq'`（係数 `ℂ`）の特殊化として得る。 -/
theorem sub_mulVec_eq_of_necSuf {m n : ℕ} (A B : Matrix (Fin m) (Fin n) ℂ) (v : Fin n → ℂ) :
    A *ᵥ v - B *ᵥ v = (A - B) *ᵥ v :=
  NecSuf.sub_mulVec_eq' A B v

/-- `matrix_difference_zero_iff_equal` の `TensorPow M` での系（`NecSuf.sub_eq_zero_iff_matrix` の添字 `Conf M` の特殊化）。 -/
theorem matrix_sub_eq_zero_iff_tensorPow {M : ℕ} (A B : TensorPow M) : A - B = 0 ↔ A = B :=
  NecSuf.sub_eq_zero_iff_matrix A B

end Ising2D
