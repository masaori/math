/-
「Bezout 恒等式は、もう一方の元の冪についても構成できる（帰納法）」の具体版が、
必要十分版の特殊化として得られることの導出。
住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.QbarBezoutPowerPropagation
import Ising2DLambda.NecSuf.ThermodynamicLimit.QbarBezoutPowerPropagation

namespace Ising2DLambda.ThermodynamicLimit

open Ising2DLambda.AlgebraicEigenvalue

/-- 具体版は必要十分版の特殊化（`R := QbarPoly`）である。 -/
theorem qbarBezoutPowerPropagation_from_necSuf (a b p q : QbarPoly)
    (hpq : p * a + q * b = 1) :
    ∀ n : ℕ, ∃ P Q : QbarPoly, P * a + Q * b ^ (n + 1) = 1 :=
  Ising2DLambda.NecSuf.ThermodynamicLimit.bezout_power_propagation_necSuf a b p q hpq

end Ising2DLambda.ThermodynamicLimit
