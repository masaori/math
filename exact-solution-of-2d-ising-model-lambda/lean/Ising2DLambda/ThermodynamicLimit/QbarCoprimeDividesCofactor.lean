/-
章「熱力学極限」の「互いに素な一次因子の冪による整除は、もう一方の冪を落とした因子へ遺伝する」
（`claim_qbar_coprime_divides_cofactor`）の具体版。人手証明と 1 対 1 に対応させる。

  人手証明                                                          このファイル
  a:=t-ŵ, b:=t-ŵ' と置き Bezout P a^{k+1}+Q b^{m+1}=1 を取る         `qbarLinearFactorPowersBezout`
  仮定から a^{k+1}g = b^{m+1}h の証人 h を取る                       `hh`（述語の定義の展開）
  g = 1·g = (P a^{k+1}+Q b^{m+1})g = P(a^{k+1}g)+Q(b^{m+1}g)
    = P(b^{m+1}h)+Q(b^{m+1}g) = b^{m+1}(P h+Q g)                     `calc`（五段）
  P h + Q g が整除の証人                                              `refine ⟨P * h + Q * g, _⟩`

住処: Q̄（実数体・複素数体は現れない）。
-/
import Ising2DLambda.ThermodynamicLimit.QbarLinearFactorPowersBezout
import Ising2DLambda.ThermodynamicLimit.QbarLinearFactorPowDivides

namespace Ising2DLambda.ThermodynamicLimit

open Ising2DLambda.AlgebraicEigenvalue

theorem qbarCoprimeDividesCofactor (w w' : Qbar) (hne : w ≠ w') (k m : ℕ) (g : QbarPoly)
    (hdvd : qbarLinearFactorPowDivides w' (m + 1)
      ((Polynomial.X - qbarConst w) ^ (k + 1) * g)) :
    qbarLinearFactorPowDivides w' (m + 1) g := by
  obtain ⟨P, Q, hPQ⟩ := qbarLinearFactorPowersBezout w w' hne k m
  obtain ⟨h, hh⟩ := hdvd
  refine ⟨P * h + Q * g, ?_⟩
  calc g
      = (P * (Polynomial.X - qbarConst w) ^ (k + 1)
          + Q * (Polynomial.X - qbarConst w') ^ (m + 1)) * g := by
        rw [hPQ, one_mul]
    _ = P * ((Polynomial.X - qbarConst w) ^ (k + 1) * g)
          + Q * ((Polynomial.X - qbarConst w') ^ (m + 1) * g) := by ring
    _ = P * ((Polynomial.X - qbarConst w') ^ (m + 1) * h)
          + Q * ((Polynomial.X - qbarConst w') ^ (m + 1) * g) := by rw [hh]
    _ = (Polynomial.X - qbarConst w') ^ (m + 1) * (P * h + Q * g) := by ring

end Ising2DLambda.ThermodynamicLimit
