/-
# 行列の和・スカラー倍・差・有限和の転置（具体版を必要十分版から導く）

具体版 `ClaimTransposeOfMatrixSumsAndScalarMultiples.lean` の主張を、必要十分版 `Ising2D/NecSuf/TransposeOfMatrixSums.lean` の
係数 `R := ℂ`、添字 `Fin m`・`Fin n` の特殊化として得る。人手のラベルは `transpose_of_matrix_sum`・`transpose_of_matrix_scalar_multiple`・
`transpose_of_matrix_difference`・`transpose_of_finite_sum_of_matrices`。

`TensorPow M`（添字 `Conf M`）の系も同じ必要十分版の特殊化として置く。具体版は添字が `Fin m` の行列について述べてあり、
`Conf M` の行列には当てはまらないためである（`ClaimScalarMultipleDistributesOverMatrixSumFromNecSuf.lean` と同じ）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimTransposeOfMatrixSumsAndScalarMultiples
import Ising2D.NecSuf.TransposeOfMatrixSums
import Ising2D.Basic

namespace Ising2D

open Matrix

/-- `matrix_transpose_add` を `NecSuf.transpose_add_matrix'`（係数 `ℂ`）の特殊化として得る。 -/
theorem matrix_transpose_add_of_necSuf {m n : ℕ} (A B : Matrix (Fin m) (Fin n) ℂ) : (A + B)ᵀ = Aᵀ + Bᵀ :=
  NecSuf.transpose_add_matrix' A B

/-- `matrix_transpose_smul` を `NecSuf.transpose_smul_matrix'`（係数 `ℂ`）の特殊化として得る。 -/
theorem matrix_transpose_smul_of_necSuf {m n : ℕ} (c : ℂ) (A : Matrix (Fin m) (Fin n) ℂ) : (c • A)ᵀ = c • Aᵀ :=
  NecSuf.transpose_smul_matrix' c A

/-- `matrix_transpose_sub` を `NecSuf.transpose_sub_matrix'`（係数 `ℂ`）の特殊化として得る。 -/
theorem matrix_transpose_sub_of_necSuf {m p : ℕ} (A B : Matrix (Fin m) (Fin p) ℂ) : (A - B)ᵀ = Aᵀ - Bᵀ :=
  NecSuf.transpose_sub_matrix' A B

/-- `finite_sum_transpose_of_matrices` を `NecSuf.finite_sum_transpose_matrix'`（係数 `ℂ`）の特殊化として得る。 -/
theorem finite_sum_transpose_of_matrices_of_necSuf {m n : ℕ} (r : ℕ) (X : Fin (r + 1) → Matrix (Fin m) (Fin n) ℂ) :
    (∑ j, X j)ᵀ = ∑ j, (X j)ᵀ :=
  NecSuf.finite_sum_transpose_matrix' r X

/-- `transpose_of_matrix_scalar_multiple` の `TensorPow M` での系（`NecSuf.transpose_smul_matrix'` の添字 `Conf M` の特殊化）。 -/
theorem transpose_smul_tensorPow {M : ℕ} (c : ℂ) (A : TensorPow M) : (c • A)ᵀ = c • Aᵀ :=
  NecSuf.transpose_smul_matrix' c A

/-- `transpose_of_matrix_difference` の `TensorPow M` での系（`NecSuf.transpose_sub_matrix'` の添字 `Conf M` の特殊化）。 -/
theorem transpose_sub_tensorPow {M : ℕ} (A B : TensorPow M) : (A - B)ᵀ = Aᵀ - Bᵀ :=
  NecSuf.transpose_sub_matrix' A B

/-- `transpose_of_finite_sum_of_matrices` の `TensorPow M` での系（`NecSuf.finite_sum_transpose_matrix'` の添字 `Conf M` の特殊化）。 -/
theorem finite_sum_transpose_tensorPow {M : ℕ} (r : ℕ) (X : Fin (r + 1) → TensorPow M) :
    (∑ j, X j)ᵀ = ∑ j, (X j)ᵀ :=
  NecSuf.finite_sum_transpose_matrix' r X

end Ising2D
