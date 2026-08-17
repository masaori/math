/-
「相異なる代数的数に対応する一次因子は互いに素である（明示的な Bezout 恒等式）」の具体版が、
必要十分版の特殊化として得られることの導出。
住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.QbarDistinctLinearFactorsBezout
import Ising2DLambda.NecSuf.ThermodynamicLimit.QbarDistinctLinearFactorsBezout

namespace Ising2DLambda.ThermodynamicLimit

open Ising2DLambda.AlgebraicEigenvalue

/-- 具体版は必要十分版の特殊化である。 -/
theorem qbarDistinctLinearFactorsBezout_from_necSuf (w w' : Qbar) (hne : w ≠ w') :
    qbarConst ((w' - w)⁻¹) * (Polynomial.X - qbarConst w)
      - qbarConst ((w' - w)⁻¹) * (Polynomial.X - qbarConst w') = 1 := by
  have hne' : w' - w ≠ 0 := sub_ne_zero.mpr (Ne.symm hne)
  have hinv : qbarConst ((w' - w)⁻¹) *
      ((Polynomial.X - qbarConst w) - (Polynomial.X - qbarConst w')) = 1 := by
    have hpoly : (Polynomial.X - qbarConst w) - (Polynomial.X - qbarConst w')
        = qbarConst (w' - w) := by
      simp only [qbarConst, Polynomial.C_sub]
      ring
    rw [hpoly]
    show qbarConst ((w' - w)⁻¹) * qbarConst (w' - w) = 1
    simp only [qbarConst, ← Polynomial.C_mul]
    rw [inv_mul_cancel₀ hne']
    simp only [Polynomial.C_1]
  exact Ising2DLambda.NecSuf.ThermodynamicLimit.distinct_linear_factors_bezout_necSuf
      (qbarConst ((w' - w)⁻¹)) (Polynomial.X - qbarConst w) (Polynomial.X - qbarConst w') hinv

end Ising2DLambda.ThermodynamicLimit
