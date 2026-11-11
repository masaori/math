/-
# 列に並べた行列に対角行列を右から掛けると、各列が対角成分倍になる（具体版を必要十分版から導く）

具体版 `ClaimColumnMatrixTimesDiagonalMatrix.lean` の主張を、必要十分版 `Ising2D/NecSuf/ColumnMatrixTimesDiagonalMatrix.lean` の
`NecSuf.cols_mul_diagonal_eq_cols_smul` の係数 `ℂ`、添字 `Fin n`・`Fin p` の特殊化として得る（仮定の `x 0 = 0` と積の可換性には `mul_zero`・`mul_comm` を渡す）。
人手のラベルは `column_matrix_times_diagonal_matrix_scales_columns`。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimColumnMatrixTimesDiagonalMatrix
import Ising2D.NecSuf.ColumnMatrixTimesDiagonalMatrix

namespace Ising2D

open Matrix

/-- `column_matrix_times_diagonal_matrix_scales_columns` を `NecSuf.cols_mul_diagonal_eq_cols_smul`
（係数 `ℂ`、添字 `Fin`）の特殊化として得る。 -/
theorem cols_mul_diagonal_matrix_of_necSuf {n p : ℕ} (b : Fin p → Fin n → ℂ) (D : Matrix (Fin p) (Fin p) ℂ)
    (hD : ∀ k l, k ≠ l → D k l = 0) :
    Matrix.of (fun j k => b k j) * D = Matrix.of (fun i k => (D k k • b k) i) :=
  NecSuf.cols_mul_diagonal_eq_cols_smul b D hD mul_zero mul_comm

end Ising2D
