/-
# 行列の符号反転は −1 倍に等しい（具体版を必要十分版から導く）

具体版 `ClaimNegationIsScalarMultipleByMinusOne.lean` の主張を、必要十分版 `Ising2D/NecSuf/NegEqNegOneSmulMatrix.lean` の
係数 `R := ℂ`、添字 `Fin m`・`Fin n` の特殊化として得る。人手のラベルは `negation_is_scalar_multiple_by_minus_one`。

`TensorPow M`（添字 `Conf M`）の系も同じ必要十分版の特殊化として置く。具体版は添字が `Fin m` の行列について述べてあり、
`Conf M` の行列には当てはまらないためである。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimNegationIsScalarMultipleByMinusOne
import Ising2D.NecSuf.NegEqNegOneSmulMatrix
import Ising2D.Basic

namespace Ising2D

/-- `neg_eq_neg_one_smul_matrix` を `NecSuf.neg_eq_neg_one_smul_matrix'`（係数 `ℂ`）の特殊化として得る。 -/
theorem neg_eq_neg_one_smul_matrix_of_necSuf {m n : ℕ} (A : Matrix (Fin m) (Fin n) ℂ) :
    -A = (-1 : ℂ) • A :=
  NecSuf.neg_eq_neg_one_smul_matrix' A

/-- `negation_is_scalar_multiple_by_minus_one` の `TensorPow M` での系（`NecSuf.neg_eq_neg_one_smul_matrix'` の添字 `Conf M` の特殊化）。 -/
theorem neg_eq_neg_one_smul_tensorPow {M : ℕ} (A : TensorPow M) : -A = (-1 : ℂ) • A :=
  NecSuf.neg_eq_neg_one_smul_matrix' A

end Ising2D
