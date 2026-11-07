/-
# 行列の冪の指数法則を必要十分版から導く

具体版 `Ising2D.matrix_power_exponent_law`（人手 `matrix_power_exponent_law`）と同じ主張が、必要十分版
`Ising2D.NecSuf.power_exponent_law'`（`Ising2D/NecSuf/PowerExponentLaw.lean`）を、モノイド `G` を `TensorPow M`
（`Mat(2^M, ℂ)` の積）に取った特殊化として得られることの記録である。具体版の証明には使わない。
-/
import Ising2D.NecSuf.PowerExponentLaw
import Ising2D.MathematicalTools.MatrixExponentialAndCommutators.ClaimMatrixPowerExponentLaw

namespace Ising2D

variable {M : ℕ}

/-- `matrix_power_exponent_law` を `NecSuf.power_exponent_law'`（`G → TensorPow M`, `a → A`）から得たもの。 -/
theorem matrix_power_exponent_law_of_necSuf (A : TensorPow M) (p q : ℕ) :
    A ^ (p + q) = A ^ p * A ^ q :=
  NecSuf.power_exponent_law' A p q

end Ising2D
