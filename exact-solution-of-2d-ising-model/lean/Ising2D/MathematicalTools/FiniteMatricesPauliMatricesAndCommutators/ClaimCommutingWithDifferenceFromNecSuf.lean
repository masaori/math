/-
# 可換な二つの行列の差とも可換（具体版を必要十分版から導く）

具体版 `ClaimCommutingWithDifference.lean` の主張を、必要十分版 `Ising2D/NecSuf/CommuteWithMatrixDifference.lean` の
係数 `R := ℂ`、添字 `Fin n` の特殊化として得る。人手のラベルは `commuting_with_difference`。

`TensorPow M`（添字 `Conf M`）の具体版 `ClaimTensorPowCommutingWithDifference.lean` の主張
`mul_sub_eq_sub_mul_of_commute_tensorPow` も、同じ必要十分版の添字 `Conf M` の特殊化として得る（`mul_sub_eq_sub_mul_of_commute_tensorPow_of_necSuf`）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimCommutingWithDifference
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimTensorPowCommutingWithDifference
import Ising2D.NecSuf.CommuteWithMatrixDifference
import Ising2D.Basic

namespace Ising2D

/-- `matrix_mul_sub_eq_sub_mul_of_commute` を `NecSuf.mul_sub_eq_sub_mul_of_commute_matrix'`（係数 `ℂ`）の特殊化として得る。 -/
theorem matrix_mul_sub_eq_sub_mul_of_commute_of_necSuf {n : ℕ} (G X W : Matrix (Fin n) (Fin n) ℂ)
    (hX : G * X = X * G) (hW : G * W = W * G) : G * (X - W) = (X - W) * G :=
  NecSuf.mul_sub_eq_sub_mul_of_commute_matrix' (fun x y => sub_eq_add_neg x y) G X W hX hW

/-- 具体版 `mul_sub_eq_sub_mul_of_commute_tensorPow`（`commuting_with_difference` の `TensorPow M` での具体版）を
`NecSuf.mul_sub_eq_sub_mul_of_commute_matrix'` の添字 `Conf M` の特殊化として得る。 -/
theorem mul_sub_eq_sub_mul_of_commute_tensorPow_of_necSuf {M : ℕ} (G X W : TensorPow M)
    (hX : G * X = X * G) (hW : G * W = W * G) : G * (X - W) = (X - W) * G :=
  NecSuf.mul_sub_eq_sub_mul_of_commute_matrix' (fun x y => sub_eq_add_neg x y) G X W hX hW

end Ising2D
