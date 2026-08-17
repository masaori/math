/-
章「熱力学極限」の「相異なる代数的数に対応する一次因子は互いに素である
（明示的な Bezout 恒等式）」（`claim_qbar_distinct_linear_factors_bezout`）の具体版。
人手証明と 1 対 1 に対応させる。

  人手証明                                                          このファイル
  u := ((w'-w)⁻¹)^ の well-defined 性（w≠w' ⇒ w'-w≠0）              `hne'`
  u(t-ŵ)-u(t-ŵ') = u((t-ŵ)-(t-ŵ'))                                   `calc` 第 1 段
  = u(ŵ'-ŵ) = u(w'-w)^                                               `hpoly`
  = ((w'-w)⁻¹)^・(w'-w)^ = ((w'-w)⁻¹(w'-w))^ = 1^ = 1                 `calc` 残り

住処: Q̄（実数体・複素数体は現れない）。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyPowerDifferenceFactorization

namespace Ising2DLambda.ThermodynamicLimit

open Ising2DLambda.AlgebraicEigenvalue

theorem qbarDistinctLinearFactorsBezout (w w' : Qbar) (hne : w ≠ w') :
    qbarConst ((w' - w)⁻¹) * (Polynomial.X - qbarConst w)
      - qbarConst ((w' - w)⁻¹) * (Polynomial.X - qbarConst w') = 1 := by
  have hne' : w' - w ≠ 0 := sub_ne_zero.mpr (Ne.symm hne)
  have hpoly : (Polynomial.X - qbarConst w) - (Polynomial.X - qbarConst w')
      = qbarConst (w' - w) := by
    simp only [qbarConst, Polynomial.C_sub]
    ring
  calc qbarConst ((w' - w)⁻¹) * (Polynomial.X - qbarConst w)
        - qbarConst ((w' - w)⁻¹) * (Polynomial.X - qbarConst w')
      = qbarConst ((w' - w)⁻¹) * ((Polynomial.X - qbarConst w) - (Polynomial.X - qbarConst w')) := by
        ring
    _ = qbarConst ((w' - w)⁻¹) * qbarConst (w' - w) := by rw [hpoly]
    _ = qbarConst ((w' - w)⁻¹ * (w' - w)) := by
        simp only [qbarConst, Polynomial.C_mul]
    _ = qbarConst 1 := by rw [inv_mul_cancel₀ hne']
    _ = 1 := by simp only [qbarConst, Polynomial.C_1]

end Ising2DLambda.ThermodynamicLimit
