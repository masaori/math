/-
具体版が必要十分版の特殊化として得られることの導出
（`R := QbarPoly`、`A := (t-ŵ)^{k+1}`、`B := (t-ŵ')^{m+1}`）。
Bezout 恒等式の供給だけが具体側の仕事である。
住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.QbarCoprimeDividesCofactor
import Ising2DLambda.NecSuf.ThermodynamicLimit.QbarCoprimeDividesCofactor

namespace Ising2DLambda.ThermodynamicLimit

open Ising2DLambda.AlgebraicEigenvalue

theorem qbarCoprimeDividesCofactor_from_necSuf (w w' : Qbar) (hne : w ≠ w') (k m : ℕ)
    (g : QbarPoly)
    (hdvd : qbarLinearFactorPowDivides w' (m + 1)
      ((Polynomial.X - qbarConst w) ^ (k + 1) * g)) :
    qbarLinearFactorPowDivides w' (m + 1) g :=
  (qbarLinearFactorPowDivides_iff_dvd w' (m + 1) g).mpr
    (Ising2DLambda.NecSuf.ThermodynamicLimit.coprime_divides_cofactor_necSuf
      ((Polynomial.X - qbarConst w) ^ (k + 1))
      ((Polynomial.X - qbarConst w') ^ (m + 1)) g
      (qbarLinearFactorPowersBezout w w' hne k m)
      ((qbarLinearFactorPowDivides_iff_dvd w' (m + 1) _).mp hdvd))

end Ising2DLambda.ThermodynamicLimit
