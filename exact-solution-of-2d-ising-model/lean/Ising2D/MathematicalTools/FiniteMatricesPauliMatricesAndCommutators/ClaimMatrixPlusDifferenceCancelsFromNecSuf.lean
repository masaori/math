/-
# 行列 A と差 B − A の和は B（具体版を必要十分版から導く）

具体版 `ClaimMatrixPlusDifferenceCancels.lean` の主張を、必要十分版 `Ising2D/NecSuf/MatrixAddSubCancel.lean` の
係数 `ℂ`、添字 `Fin m`・`Fin p` の特殊化として得る。人手のラベルは `matrix_plus_difference_cancels`。

`TensorPow M`（添字 `Conf M`）の具体版 `ClaimTensorPowMatrixPlusDifferenceCancels.lean` の `add_sub_cancel_tensorPow` も、
同じ必要十分版の添字 `Conf M` の特殊化として得る（`add_sub_cancel_tensorPow_of_necSuf`）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatrixPlusDifferenceCancels
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimTensorPowMatrixPlusDifferenceCancels
import Ising2D.NecSuf.MatrixAddSubCancel
import Ising2D.Basic

namespace Ising2D

/-- `matrix_add_sub_cancel` を `NecSuf.add_sub_cancel_matrix'`（係数 `ℂ`）の特殊化として得る。 -/
theorem matrix_add_sub_cancel_of_necSuf {m p : ℕ} (A B : Matrix (Fin m) (Fin p) ℂ) :
    A + (B - A) = B :=
  NecSuf.add_sub_cancel_matrix' A B

/-- `add_sub_cancel_tensorPow` を `NecSuf.add_sub_cancel_matrix'` の添字 `Conf M` の特殊化として得る。 -/
theorem add_sub_cancel_tensorPow_of_necSuf {M : ℕ} (A B : TensorPow M) : A + (B - A) = B :=
  NecSuf.add_sub_cancel_matrix' A B

end Ising2D
