/-
# 行列の符号反転は −1 倍に等しい（具体版を必要十分版から導く）

具体版 `ClaimNegationIsScalarMultipleByMinusOne.lean` の主張を、必要十分版 `Ising2D/NecSuf/NegEqNegOneSmulMatrix.lean` の
係数 `R := ℂ`、添字 `Fin m`・`Fin n` の特殊化として得る。人手のラベルは `negation_is_scalar_multiple_by_minus_one`。

`TensorPow M`（添字 `Conf M`）の具体版 `ClaimTensorPowNegationIsScalarMultipleByMinusOne.lean` の主張
`neg_eq_neg_one_smul_tensorPow` も、同じ必要十分版の添字 `Conf M` の特殊化として得る（`neg_eq_neg_one_smul_tensorPow_of_necSuf`）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimNegationIsScalarMultipleByMinusOne
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimTensorPowNegationIsScalarMultipleByMinusOne
import Ising2D.NecSuf.NegEqNegOneSmulMatrix
import Ising2D.Basic

namespace Ising2D

/-- `neg_eq_neg_one_smul_matrix` を `NecSuf.neg_eq_neg_one_smul_matrix'`（係数 `ℂ`）の特殊化として得る。 -/
theorem neg_eq_neg_one_smul_matrix_of_necSuf {m n : ℕ} (A : Matrix (Fin m) (Fin n) ℂ) :
    -A = (-1 : ℂ) • A :=
  NecSuf.neg_eq_neg_one_smul_matrix' A

/-- 具体版 `neg_eq_neg_one_smul_tensorPow`（`negation_is_scalar_multiple_by_minus_one` の `TensorPow M` での具体版）を
`NecSuf.neg_eq_neg_one_smul_matrix'` の添字 `Conf M` の特殊化として得る。 -/
theorem neg_eq_neg_one_smul_tensorPow_of_necSuf {M : ℕ} (A : TensorPow M) : -A = (-1 : ℂ) • A :=
  NecSuf.neg_eq_neg_one_smul_matrix' A

end Ising2D
