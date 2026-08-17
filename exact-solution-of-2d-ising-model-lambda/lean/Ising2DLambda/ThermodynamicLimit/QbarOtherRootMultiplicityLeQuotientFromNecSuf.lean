/-
具体版が必要十分版 `coprime_divides_cofactor_necSuf` の特殊化として得られることの導出。
必要なのは、相異なる一次因子の冪を結ぶ Bezout 恒等式と可換環の演算だけである。
住処: ここに R / C は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.QbarOtherRootMultiplicityLeQuotient
import Ising2DLambda.NecSuf.ThermodynamicLimit.QbarCoprimeDividesCofactor

namespace Ising2DLambda.ThermodynamicLimit

open Ising2DLambda.AlgebraicEigenvalue

theorem qbarOtherRootMultiplicityLeQuotient_from_necSuf (w w' : Qbar) (hne : w ≠ w')
    (f g : QbarPoly) (hf : f ≠ 0) (hg : g ≠ 0)
    (hfg : f = (Polynomial.X - qbarConst w') * g) :
    qbarRootMultiplicity w f hf ≤ qbarRootMultiplicity w g hg := by
  rcases Nat.eq_zero_or_pos (qbarRootMultiplicity w f hf) with hzero | hpos
  · omega
  · obtain ⟨M', hM'⟩ : ∃ M' : ℕ, qbarRootMultiplicity w f hf = M' + 1 :=
      ⟨qbarRootMultiplicity w f hf - 1, by omega⟩
    have hdvd : (Polynomial.X - qbarConst w) ^ (M' + 1) ∣
        (Polynomial.X - qbarConst w') ^ (0 + 1) * g := by
      rw [pow_one, ← hfg, ← hM']
      exact (qbarLinearFactorPowDivides_iff_dvd w _ f).mp
        (qbarRootMultiplicity_divides w f hf)
    have hbez : ∃ P Q : QbarPoly,
        P * (Polynomial.X - qbarConst w') ^ (0 + 1)
          + Q * (Polynomial.X - qbarConst w) ^ (M' + 1) = 1 :=
      qbarLinearFactorPowersBezout w' w hne.symm 0 M'
    have hdvdg : (Polynomial.X - qbarConst w) ^ (M' + 1) ∣ g :=
      Ising2DLambda.NecSuf.ThermodynamicLimit.coprime_divides_cofactor_necSuf
        ((Polynomial.X - qbarConst w') ^ (0 + 1))
        ((Polynomial.X - qbarConst w) ^ (M' + 1)) g hbez hdvd
    have hle : M' + 1 ≤ qbarRootMultiplicity w g hg :=
      qbarRootMultiplicity_ge_of_divides w g hg (M' + 1)
        ((qbarLinearFactorPowDivides_iff_dvd w _ g).mpr hdvdg)
    omega

end Ising2DLambda.ThermodynamicLimit
