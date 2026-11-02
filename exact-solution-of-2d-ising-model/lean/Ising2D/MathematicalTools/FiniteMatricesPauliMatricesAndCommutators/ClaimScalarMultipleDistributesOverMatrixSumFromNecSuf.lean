/-
# スカラー倍は行列の和・有限和に分配する（具体版を必要十分版から導く）

具体版 `ClaimScalarMultipleDistributesOverMatrixSum.lean` の主張を、必要十分版 `Ising2D/NecSuf/SmulMatrixSum.lean` の
係数 `R := ℂ`、添字 `Fin m`・`Fin n` の特殊化として得る。人手のラベルは `scalar_multiple_distributes_over_matrix_sum`・`finite_sum_of_scalar_multiples`。

`TensorPow M`（添字 `Conf M`）の系も同じ必要十分版の特殊化として置く。具体版は添字が `Fin m` の行列について述べてあり、
`Conf M` の行列には当てはまらないためである。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultipleDistributesOverMatrixSum
import Ising2D.NecSuf.SmulMatrixSum
import Ising2D.Basic

namespace Ising2D

/-- `matrix_smul_add` を `NecSuf.smul_add_matrix'`（係数 `ℂ`）の特殊化として得る。 -/
theorem matrix_smul_add_of_necSuf {m n : ℕ} (c : ℂ) (A B : Matrix (Fin m) (Fin n) ℂ) :
    c • (A + B) = c • A + c • B :=
  NecSuf.smul_add_matrix' c A B

/-- `finite_sum_smul_of_matrices` を `NecSuf.finite_sum_smul_matrix'`（係数 `ℂ`）の特殊化として得る。 -/
theorem finite_sum_smul_of_matrices_of_necSuf {m n : ℕ} (c : ℂ) (r : ℕ)
    (X : Fin (r + 1) → Matrix (Fin m) (Fin n) ℂ) :
    ∑ j, c • X j = c • ∑ j, X j :=
  NecSuf.finite_sum_smul_matrix' c r X

/-- `scalar_multiple_distributes_over_matrix_sum` の `TensorPow M` での系（`NecSuf.smul_add_matrix'` の添字 `Conf M` の特殊化）。 -/
theorem smul_add_tensorPow {M : ℕ} (c : ℂ) (A B : TensorPow M) : c • (A + B) = c • A + c • B :=
  NecSuf.smul_add_matrix' c A B

/-- `finite_sum_of_scalar_multiples` の `TensorPow M` での系（`NecSuf.finite_sum_smul_matrix'` の添字 `Conf M` の特殊化）。 -/
theorem finite_sum_smul_tensorPow {M : ℕ} (c : ℂ) (r : ℕ) (X : Fin (r + 1) → TensorPow M) :
    ∑ j, c • X j = c • ∑ j, X j :=
  NecSuf.finite_sum_smul_matrix' c r X

end Ising2D
