/-
# 可換な行列のスカラー倍とも可換（具体版を必要十分版から導く）

具体版 `ClaimCommutingWithScalarMultiple.lean` の主張を、必要十分版
`Ising2D/NecSuf/CommuteWithAnticommutingProductAndScalarMultiple.lean` の `NecSuf.commute_smul_of_commute'` の
`𝕜 := ℂ`、`A := Mat(n,ℂ)` の特殊化として得る。人手のラベルは `commuting_with_scalar_multiple`。

`TensorPow M`（添字 `Conf M`）の具体版 `mul_smul_comm_of_commute_tensorPow`（`ClaimTensorPowCommutingWithScalarMultiple.lean`）も、
同じ必要十分版の `A := TensorPow M` の特殊化 `mul_smul_comm_of_commute_tensorPow_of_necSuf` として得る。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimCommutingWithScalarMultiple
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimTensorPowCommutingWithScalarMultiple
import Ising2D.NecSuf.CommuteWithAnticommutingProductAndScalarMultiple
import Ising2D.Basic

namespace Ising2D

/-- `commuting_with_scalar_multiple` を `NecSuf.commute_smul_of_commute'`（`𝕜 := ℂ`、`A := Mat(n,ℂ)`）の特殊化として得る。 -/
theorem matrix_mul_smul_comm_of_commute_of_necSuf {n : ℕ} (c : ℂ) (G X : Matrix (Fin n) (Fin n) ℂ)
    (h : G * X = X * G) : G * (c • X) = (c • X) * G :=
  NecSuf.commute_smul_of_commute' c h

/-- `mul_smul_comm_of_commute_tensorPow` を `NecSuf.commute_smul_of_commute'`（`𝕜 := ℂ`、`A := TensorPow M`）の特殊化として得る。 -/
theorem mul_smul_comm_of_commute_tensorPow_of_necSuf {M : ℕ} (c : ℂ) (G X : TensorPow M)
    (h : G * X = X * G) : G * (c • X) = (c • X) * G :=
  NecSuf.commute_smul_of_commute' c h

end Ising2D
