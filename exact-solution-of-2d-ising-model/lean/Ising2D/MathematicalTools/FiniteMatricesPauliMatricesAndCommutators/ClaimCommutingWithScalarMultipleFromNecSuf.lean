/-
# 可換な行列のスカラー倍とも可換（具体版を必要十分版から導く）

具体版 `ClaimCommutingWithScalarMultiple.lean` の主張を、必要十分版
`Ising2D/NecSuf/CommuteWithAnticommutingProductAndScalarMultiple.lean` の `NecSuf.commute_smul_of_commute'` の
`𝕜 := ℂ`、`A := Mat(n,ℂ)` の特殊化として得る。人手のラベルは `commuting_with_scalar_multiple`。

`TensorPow M`（添字 `Conf M`）の系も同じ必要十分版の特殊化として置く。具体版は添字が `Fin n` の行列について述べてあり、
`Conf M` の行列には当てはまらないためである。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimCommutingWithScalarMultiple
import Ising2D.NecSuf.CommuteWithAnticommutingProductAndScalarMultiple
import Ising2D.Basic

namespace Ising2D

/-- `commuting_with_scalar_multiple` を `NecSuf.commute_smul_of_commute'`（`𝕜 := ℂ`、`A := Mat(n,ℂ)`）の特殊化として得る。 -/
theorem matrix_mul_smul_comm_of_commute_of_necSuf {n : ℕ} (c : ℂ) (G X : Matrix (Fin n) (Fin n) ℂ)
    (h : G * X = X * G) : G * (c • X) = (c • X) * G :=
  NecSuf.commute_smul_of_commute' c h

/-- `commuting_with_scalar_multiple` の `TensorPow M` での系。 -/
theorem mul_smul_comm_of_commute_tensorPow {M : ℕ} (c : ℂ) (G X : TensorPow M)
    (h : G * X = X * G) : G * (c • X) = (c • X) * G :=
  NecSuf.commute_smul_of_commute' c h

end Ising2D
