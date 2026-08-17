/-
具体版が必要十分版の特殊化として得られることの導出（`R := Qbar`）。
必要十分版は重複度を経由せず整除の指数だけで述べているので、
最大元の読み取り 1・2 でその形と重複度を結ぶ。
住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.QbarRootMultiplicityLeQuotientSucc
import Ising2DLambda.NecSuf.ThermodynamicLimit.QbarRootMultiplicityLeQuotientSucc

namespace Ising2DLambda.ThermodynamicLimit

open Ising2DLambda.AlgebraicEigenvalue

theorem qbarRootMultiplicityLeQuotientSucc_from_necSuf (w : Qbar) (f g : QbarPoly) (hf : f ≠ 0)
    (hg : g ≠ 0) (hfg : f = (Polynomial.X - qbarConst w) * g) :
    qbarRootMultiplicity w f hf ≤ qbarRootMultiplicity w g hg + 1 := by
  rcases Nat.eq_zero_or_pos (qbarRootMultiplicity w f hf) with hzero | hpos
  · omega
  · obtain ⟨M', hM'⟩ : ∃ M' : ℕ, qbarRootMultiplicity w f hf = M' + 1 :=
      ⟨qbarRootMultiplicity w f hf - 1, by omega⟩
    have hdvd : (Polynomial.X - qbarConst w) ^ (M' + 1)
        ∣ (Polynomial.X - qbarConst w) * g := by
      rw [← hfg, ← hM']
      exact (qbarLinearFactorPowDivides_iff_dvd w _ f).mp (qbarRootMultiplicity_divides w f hf)
    have hle : M' ≤ qbarRootMultiplicity w g hg :=
      qbarRootMultiplicity_ge_of_divides w g hg M'
        ((qbarLinearFactorPowDivides_iff_dvd w M' g).mpr
          (Ising2DLambda.NecSuf.ThermodynamicLimit.root_multiplicity_le_quotient_succ_necSuf
            w g M' hdvd))
    omega

end Ising2DLambda.ThermodynamicLimit
