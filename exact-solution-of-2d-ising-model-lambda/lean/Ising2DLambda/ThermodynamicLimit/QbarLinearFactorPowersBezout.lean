/-
章「熱力学極限」の「一次因子の冪どうしが互いに素であること（Bezout 恒等式の伝播の二度適用）」
（`claim_qbar_linear_factor_powers_bezout`）の具体版。

  人手証明                                                          このファイル
  u:=((w'-w)⁻¹)^, a:=t-ŵ, b:=t-ŵ'                                   `qbarDistinctLinearFactorsBezout`
  一度目: n:=m で `claim_qbar_bezout_power_propagation` を適用          `qbarBezoutPowerPropagation … m`
  P1 a+Q1 b^{m+1}=1 を Q1 b^{m+1}+P1 a=1 と書き直す                    `h1'`（`linear_combination`）
  二度目: a':=b^{m+1}, b':=a, p':=Q1, q':=P1 で n:=k を適用             `qbarBezoutPowerPropagation … k`
  P2 b^{m+1}+Q2 a^{k+1}=1 を P:=Q2, Q:=P2 で書き直す                    `linear_combination`

住処: Q̄（実数体・複素数体は現れない）。
-/
import Ising2DLambda.ThermodynamicLimit.QbarDistinctLinearFactorsBezout
import Ising2DLambda.ThermodynamicLimit.QbarBezoutPowerPropagation

namespace Ising2DLambda.ThermodynamicLimit

open Ising2DLambda.AlgebraicEigenvalue

theorem qbarLinearFactorPowersBezout (w w' : Qbar) (hne : w ≠ w') (k m : ℕ) :
    ∃ P Q : QbarPoly,
      P * (Polynomial.X - qbarConst w) ^ (k + 1)
        + Q * (Polynomial.X - qbarConst w') ^ (m + 1) = 1 := by
  set a := Polynomial.X - qbarConst w with ha
  set b := Polynomial.X - qbarConst w' with hb
  have hpq : qbarConst ((w' - w)⁻¹) * a + (-qbarConst ((w' - w)⁻¹)) * b = 1 := by
    have h := qbarDistinctLinearFactorsBezout w w' hne
    rw [← ha, ← hb] at h
    linear_combination h
  obtain ⟨P1, Q1, h1⟩ :=
    qbarBezoutPowerPropagation a b (qbarConst ((w' - w)⁻¹)) (-qbarConst ((w' - w)⁻¹)) hpq m
  have h1' : Q1 * b ^ (m + 1) + P1 * a = 1 := by linear_combination h1
  obtain ⟨P2, Q2, h2⟩ := qbarBezoutPowerPropagation (b ^ (m + 1)) a Q1 P1 h1' k
  refine ⟨Q2, P2, ?_⟩
  linear_combination h2

end Ising2DLambda.ThermodynamicLimit
