/-
章「熱力学極限」の「相異なる点の重複度は、一次因子を割り出した商へ引き継がれる」
（`claim_qbar_other_root_multiplicity_le_quotient`）の具体版。人手証明と 1 対 1 に対応させる。

  人手証明                                                        このファイル
  M := mult_w(f)、M = 0 の場合は N の順序で済む                     `Nat.eq_zero_or_pos`
  M = M'+1 のとき読み取り 1 で (t-ŵ)^{M'+1} が f を割る             `qbarRootMultiplicity_divides`
  f=(t-ŵ')g と (t-ŵ')^{0+1}=t-ŵ' を代入                            `hdvd`
  互いに素な整除の遺伝を k:=0, m:=M' で当てる                       `qbarCoprimeDividesCofactor`
  読み取り 2 で M'+1 <= mult_w(g)                                  `qbarRootMultiplicity_ge_of_divides`

住処: Qbar（実数体・複素数体は現れない）。
-/
import Ising2DLambda.ThermodynamicLimit.QbarRootMultiplicityLeQuotientSucc
import Ising2DLambda.ThermodynamicLimit.QbarCoprimeDividesCofactor

namespace Ising2DLambda.ThermodynamicLimit

open Ising2DLambda.AlgebraicEigenvalue

theorem qbarOtherRootMultiplicityLeQuotient (w w' : Qbar) (hne : w ≠ w')
    (f g : QbarPoly) (hf : f ≠ 0) (hg : g ≠ 0)
    (hfg : f = (Polynomial.X - qbarConst w') * g) :
    qbarRootMultiplicity w f hf ≤ qbarRootMultiplicity w g hg := by
  rcases Nat.eq_zero_or_pos (qbarRootMultiplicity w f hf) with hzero | hpos
  · omega
  · obtain ⟨M', hM'⟩ : ∃ M' : ℕ, qbarRootMultiplicity w f hf = M' + 1 :=
      ⟨qbarRootMultiplicity w f hf - 1, by omega⟩
    have hdvd : qbarLinearFactorPowDivides w (M' + 1)
        ((Polynomial.X - qbarConst w') ^ (0 + 1) * g) := by
      rw [pow_one, ← hfg, ← hM']
      exact qbarRootMultiplicity_divides w f hf
    have hdvdg : qbarLinearFactorPowDivides w (M' + 1) g :=
      qbarCoprimeDividesCofactor w' w hne.symm 0 M' g hdvd
    have hle : M' + 1 ≤ qbarRootMultiplicity w g hg :=
      qbarRootMultiplicity_ge_of_divides w g hg (M' + 1) hdvdg
    omega

end Ising2DLambda.ThermodynamicLimit
