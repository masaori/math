/-
# 和が零行列なら一方は他方の符号反転（具体版を必要十分版から導く）

具体版 `ClaimMatrixEqualsNegationIfSumIsZero.lean` の主張を、必要十分版 `Ising2D/NecSuf/MatrixEqNegOfAddEqZero.lean` の
係数 `R := ℂ`（加法群）、添字 `Fin m`・`Fin p` の特殊化として得る。人手のラベルは `matrix_equals_negation_if_sum_is_zero`。

`TensorPow M`（添字 `Conf M`）の系も同じ必要十分版の特殊化として置く。具体版は添字が `Fin m` の行列について述べてあり、
`Conf M` の行列には当てはまらないためである。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatrixEqualsNegationIfSumIsZero
import Ising2D.NecSuf.MatrixEqNegOfAddEqZero
import Ising2D.Basic

namespace Ising2D

/-- `matrix_eq_neg_of_add_eq_zero` を `NecSuf.eq_neg_of_add_eq_zero_matrix'`（係数 `ℂ`）の特殊化として得る。 -/
theorem matrix_eq_neg_of_add_eq_zero_of_necSuf {m p : ℕ} (X Y : Matrix (Fin m) (Fin p) ℂ)
    (h : X + Y = 0) : X = -Y :=
  NecSuf.eq_neg_of_add_eq_zero_matrix' X Y h

/-- `matrix_equals_negation_if_sum_is_zero` の `TensorPow M` での系（`NecSuf.eq_neg_of_add_eq_zero_matrix'` の添字 `Conf M` の特殊化）。 -/
theorem eq_neg_of_add_eq_zero_tensorPow {M : ℕ} (X Y : TensorPow M) (h : X + Y = 0) : X = -Y :=
  NecSuf.eq_neg_of_add_eq_zero_matrix' X Y h

end Ising2D
