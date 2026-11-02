/-
# 行列の 0 倍は零行列・行列の和の可換則（具体版を必要十分版から導く）

具体版 `ClaimZeroScalarMultipleAndMatrixSumCommutative.lean` の主張を、必要十分版 `Ising2D/NecSuf/ZeroSmulAndAddCommMatrix.lean` の
係数・スカラー `ℂ`、添字 `Fin m`・`Fin n` の特殊化として得る。`hz := zero_mul`（人手の `complex_zero_times_is_zero`）、
`hcomm := add_comm`（`complex_numbers_form_a_field` の加法の交換律）を渡す。
人手のラベルは `zero_scalar_multiple_is_zero_matrix`・`matrix_sum_is_commutative`。

`TensorPow M`（添字 `Conf M`）の系も同じ必要十分版の特殊化として置く。具体版は添字が `Fin m` の行列について述べてあり、
`Conf M` の行列には当てはまらないためである。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimZeroScalarMultipleAndMatrixSumCommutative
import Ising2D.NecSuf.ZeroSmulAndAddCommMatrix
import Ising2D.Basic

namespace Ising2D

/-- `matrix_zero_smul` を `NecSuf.zero_smul_matrix'`（係数 `ℂ`）の特殊化として得る。 -/
theorem matrix_zero_smul_of_necSuf {m n : ℕ} (A : Matrix (Fin m) (Fin n) ℂ) : (0 : ℂ) • A = 0 :=
  NecSuf.zero_smul_matrix' (fun x : ℂ => zero_mul x) A

/-- `matrix_add_comm` を `NecSuf.add_comm_matrix'`（係数 `ℂ`）の特殊化として得る。 -/
theorem matrix_add_comm_of_necSuf {m n : ℕ} (A B : Matrix (Fin m) (Fin n) ℂ) : A + B = B + A :=
  NecSuf.add_comm_matrix' (fun x y : ℂ => add_comm x y) A B

/-- `zero_scalar_multiple_is_zero_matrix` の `TensorPow M` での系。 -/
theorem zero_smul_tensorPow {M : ℕ} (A : TensorPow M) : (0 : ℂ) • A = 0 :=
  NecSuf.zero_smul_matrix' (fun x : ℂ => zero_mul x) A

/-- `matrix_sum_is_commutative` の `TensorPow M` での系。 -/
theorem add_comm_tensorPow {M : ℕ} (A B : TensorPow M) : A + B = B + A :=
  NecSuf.add_comm_matrix' (fun x y : ℂ => add_comm x y) A B

end Ising2D
