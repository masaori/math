/-
# 可換な二つの行列の差とも可換（具体版を必要十分版から導く）

具体版 `ClaimCommutingWithDifference.lean` の主張を、必要十分版 `Ising2D/NecSuf/CommuteWithMatrixDifference.lean` の
係数 `R := ℂ`、添字 `Fin n` の特殊化として得る。人手のラベルは `commuting_with_difference`。

`TensorPow M`（添字 `Conf M`）の系も同じ必要十分版の特殊化として置く。具体版は添字が `Fin n` の行列について述べてあり、
`Conf M` の行列には当てはまらないためである。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimCommutingWithDifference
import Ising2D.NecSuf.CommuteWithMatrixDifference
import Ising2D.Basic

namespace Ising2D

/-- `matrix_mul_sub_eq_sub_mul_of_commute` を `NecSuf.mul_sub_eq_sub_mul_of_commute_matrix'`（係数 `ℂ`）の特殊化として得る。 -/
theorem matrix_mul_sub_eq_sub_mul_of_commute_of_necSuf {n : ℕ} (G X W : Matrix (Fin n) (Fin n) ℂ)
    (hX : G * X = X * G) (hW : G * W = W * G) : G * (X - W) = (X - W) * G :=
  NecSuf.mul_sub_eq_sub_mul_of_commute_matrix' (fun x y => sub_eq_add_neg x y) G X W hX hW

/-- `commuting_with_difference` の `TensorPow M` での系（`NecSuf.mul_sub_eq_sub_mul_of_commute_matrix'` の添字 `Conf M` の特殊化）。 -/
theorem mul_sub_eq_sub_mul_of_commute_tensorPow {M : ℕ} (G X W : TensorPow M)
    (hX : G * X = X * G) (hW : G * W = W * G) : G * (X - W) = (X - W) * G :=
  NecSuf.mul_sub_eq_sub_mul_of_commute_matrix' (fun x y => sub_eq_add_neg x y) G X W hX hW

end Ising2D
