/-
「一次因子の冪どうしが互いに素であること（Bezout 恒等式の伝播の二度適用）」の具体版が、
必要十分版の特殊化として得られることの導出。
住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.QbarDistinctLinearFactorsBezout
import Ising2DLambda.NecSuf.ThermodynamicLimit.QbarLinearFactorPowersBezout

namespace Ising2DLambda.ThermodynamicLimit

open Ising2DLambda.AlgebraicEigenvalue

/-- 具体版は必要十分版の特殊化（`R := QbarPoly`）である。 -/
theorem qbarLinearFactorPowersBezout_from_necSuf (w w' : Qbar) (hne : w ≠ w') (k m : ℕ) :
    ∃ P Q : QbarPoly,
      P * (Polynomial.X - qbarConst w) ^ (k + 1)
        + Q * (Polynomial.X - qbarConst w') ^ (m + 1) = 1 := by
  have hpq : qbarConst ((w' - w)⁻¹) * (Polynomial.X - qbarConst w)
      + (-qbarConst ((w' - w)⁻¹)) * (Polynomial.X - qbarConst w') = 1 := by
    have h := qbarDistinctLinearFactorsBezout w w' hne
    linear_combination h
  exact Ising2DLambda.NecSuf.ThermodynamicLimit.linear_factor_powers_bezout_necSuf
    (Polynomial.X - qbarConst w) (Polynomial.X - qbarConst w')
    (qbarConst ((w' - w)⁻¹)) (-qbarConst ((w' - w)⁻¹)) hpq k m

end Ising2DLambda.ThermodynamicLimit
