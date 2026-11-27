/-
# スカラー倍は行列の差に分配する（具体版を必要十分版から導く）

具体版 `ClaimScalarMultipleDistributesOverMatrixDifference.lean` の主張を、必要十分版 `Ising2D/NecSuf/SmulMatrixSub.lean` の
係数 `R := ℂ`（差の式 `hsub` は `sub_eq_add_neg`）、添字 `Fin m`・`Fin p` の特殊化として得る。人手のラベルは `scalar_multiple_distributes_over_matrix_difference`。

`TensorPow M`（添字 `Conf M`）の具体版 `smul_sub_tensorPow`（`ClaimTensorPowScalarMultipleDistributesOverMatrixDifference.lean`）も、
同じ必要十分版の添字 `Conf M` の特殊化 `smul_sub_tensorPow_of_necSuf` として得る。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultipleDistributesOverMatrixDifference
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimTensorPowScalarMultipleDistributesOverMatrixDifference
import Ising2D.NecSuf.SmulMatrixSub
import Ising2D.Basic

namespace Ising2D

/-- `matrix_smul_sub` を `NecSuf.smul_sub_matrix'`（係数 `ℂ`、`hsub := sub_eq_add_neg`）の特殊化として得る。 -/
theorem matrix_smul_sub_of_necSuf {m p : ℕ} (c : ℂ) (A B : Matrix (Fin m) (Fin p) ℂ) :
    c • (A - B) = c • A - c • B :=
  NecSuf.smul_sub_matrix' sub_eq_add_neg c A B

/-- `smul_sub_tensorPow` を `NecSuf.smul_sub_matrix'`（係数 `ℂ`、`hsub := sub_eq_add_neg`、添字 `Conf M`）の特殊化として得る。 -/
theorem smul_sub_tensorPow_of_necSuf {M : ℕ} (c : ℂ) (A B : TensorPow M) : c • (A - B) = c • A - c • B :=
  NecSuf.smul_sub_matrix' sub_eq_add_neg c A B

end Ising2D
