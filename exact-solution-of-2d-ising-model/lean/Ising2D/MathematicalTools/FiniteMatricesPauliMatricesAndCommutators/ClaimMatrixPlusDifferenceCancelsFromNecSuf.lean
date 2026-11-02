/-
# 行列 A と差 B − A の和は B（具体版を必要十分版から導く）

具体版 `ClaimMatrixPlusDifferenceCancels.lean` の主張を、必要十分版 `Ising2D/NecSuf/MatrixAddSubCancel.lean` の
係数 `ℂ`、添字 `Fin m`・`Fin p` の特殊化として得る。人手のラベルは `matrix_plus_difference_cancels`。

`TensorPow M`（添字 `Conf M`）の系も同じ必要十分版の特殊化として置く。具体版は添字が `Fin m` の行列について述べてあり、
`Conf M` の行列には当てはまらないためである。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatrixPlusDifferenceCancels
import Ising2D.NecSuf.MatrixAddSubCancel
import Ising2D.Basic

namespace Ising2D

/-- `matrix_add_sub_cancel` を `NecSuf.add_sub_cancel_matrix'`（係数 `ℂ`）の特殊化として得る。 -/
theorem matrix_add_sub_cancel_of_necSuf {m p : ℕ} (A B : Matrix (Fin m) (Fin p) ℂ) :
    A + (B - A) = B :=
  NecSuf.add_sub_cancel_matrix' A B

/-- `matrix_plus_difference_cancels` の `TensorPow M` での系。 -/
theorem add_sub_cancel_tensorPow {M : ℕ} (A B : TensorPow M) : A + (B - A) = B :=
  NecSuf.add_sub_cancel_matrix' A B

end Ising2D
