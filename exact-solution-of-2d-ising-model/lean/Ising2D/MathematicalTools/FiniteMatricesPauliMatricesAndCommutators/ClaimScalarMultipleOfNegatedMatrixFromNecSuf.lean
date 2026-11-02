/-
# 符号反転した行列のスカラー倍はスカラー倍の符号反転に等しい（具体版を必要十分版から導く）

具体版 `ClaimScalarMultipleOfNegatedMatrix.lean` の主張を、必要十分版 `Ising2D/NecSuf/SmulNegMatrix.lean` の
係数 `R := ℂ`、添字 `Fin m`・`Fin n` の特殊化として得る。人手のラベルは `scalar_multiple_of_negated_matrix`。

`TensorPow M`（添字 `Conf M`）の系も同じ必要十分版の特殊化として置く。具体版は添字が `Fin m` の行列について述べてあり、
`Conf M` の行列には当てはまらないためである。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultipleOfNegatedMatrix
import Ising2D.NecSuf.SmulNegMatrix
import Ising2D.Basic

namespace Ising2D

/-- `smul_neg_matrix` を `NecSuf.smul_neg_matrix'`（係数 `ℂ`）の特殊化として得る。 -/
theorem smul_neg_matrix_of_necSuf {m n : ℕ} (a : ℂ) (A : Matrix (Fin m) (Fin n) ℂ) :
    a • (-A) = -(a • A) :=
  NecSuf.smul_neg_matrix' a A

/-- `scalar_multiple_of_negated_matrix` の `TensorPow M` での系（`NecSuf.smul_neg_matrix'` の添字 `Conf M` の特殊化）。 -/
theorem smul_neg_matrix_tensorPow {M : ℕ} (a : ℂ) (A : TensorPow M) : a • (-A) = -(a • A) :=
  NecSuf.smul_neg_matrix' a A

end Ising2D
