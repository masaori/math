/-
# 零行列のスカラー倍は零行列（具体版を必要十分版から導く）

具体版 `ClaimScalarMultipleOfZeroMatrix.lean` の主張を、必要十分版 `Ising2D/NecSuf/SmulZeroMatrix.lean` の
係数 `R := ℂ`、スカラー `α := ℂ`、添字 `Fin m`・`Fin n` の特殊化として得る。人手のラベルは `scalar_multiple_of_zero_matrix`。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultipleOfZeroMatrix
import Ising2D.NecSuf.SmulZeroMatrix

namespace Ising2D

/-- `matrix_smul_zero_matrix` を `NecSuf.smul_zero_matrix`（係数・スカラーとも `ℂ`）の特殊化として得る。 -/
theorem matrix_smul_zero_matrix_of_necSuf {m n : ℕ} (a : ℂ) :
    a • (0 : Matrix (Fin m) (Fin n) ℂ) = 0 :=
  NecSuf.smul_zero_matrix a

end Ising2D
