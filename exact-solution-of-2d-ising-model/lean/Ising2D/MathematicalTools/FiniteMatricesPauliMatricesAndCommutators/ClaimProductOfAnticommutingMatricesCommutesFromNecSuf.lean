/-
# 反可換な二つの行列の積は可換（具体版を必要十分版から導く）

具体版 `ClaimProductOfAnticommutingMatricesCommutes.lean` の主張を、必要十分版
`Ising2D/NecSuf/CommuteWithAnticommutingProductAndScalarMultiple.lean` の `NecSuf.commute_mul_of_anticomm'` の
`A := Mat(n,ℂ)` の特殊化として得る。人手のラベルは `product_of_anticommuting_matrices_commutes`。

`TensorPow M`（添字 `Conf M`）の系も同じ必要十分版の特殊化として置く。具体版は添字が `Fin n` の行列について述べてあり、
`Conf M` の行列には当てはまらないためである。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimProductOfAnticommutingMatricesCommutes
import Ising2D.NecSuf.CommuteWithAnticommutingProductAndScalarMultiple
import Ising2D.Basic

namespace Ising2D

/-- `product_of_anticommuting_matrices_commutes` を `NecSuf.commute_mul_of_anticomm'`（`A := Mat(n,ℂ)`）の特殊化として得る。 -/
theorem matrix_mul_comm_of_anticomm_pair_of_necSuf {n : ℕ} (G X Y : Matrix (Fin n) (Fin n) ℂ)
    (hX : G * X = -(X * G)) (hY : G * Y = -(Y * G)) : G * (X * Y) = (X * Y) * G :=
  NecSuf.commute_mul_of_anticomm' hX hY

/-- `product_of_anticommuting_matrices_commutes` の `TensorPow M` での系。 -/
theorem mul_comm_of_anticomm_pair_tensorPow {M : ℕ} (G X Y : TensorPow M)
    (hX : G * X = -(X * G)) (hY : G * Y = -(Y * G)) : G * (X * Y) = (X * Y) * G :=
  NecSuf.commute_mul_of_anticomm' hX hY

end Ising2D
