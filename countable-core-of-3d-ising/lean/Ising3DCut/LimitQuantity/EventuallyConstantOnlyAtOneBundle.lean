/-
「有限箱の量が末尾で一定となる正の有理点は 1 に限られる」の Lean 具体版へ
向けた接続の第二段。冪等式の末尾成立から正の有理数の点数乗表示を取り出し、
その底の既約分母が 1 であることを受け取って自然数の底へ移し、既に示した
三点の候補からの分岐へ渡して 1 に定める。

扱うのは有限箱の有理評価・自然数冪・有理数の既約分母だけであり、極限は使わない。
候補が三点に尽きること自体は本文の有限箱の整除と合同式による絞り込みであり、
ここでは仮定として受け取る（Lean へはまだ移していない）。
-/
import Ising3DCut.LimitQuantity.EventuallyConstantOnlyAtOne
import Ising3DCut.LimitQuantity.CrossPowerIdentityIffRationalPowerFormFromNecSuf

namespace Ising3DCut.LimitQuantity

/-- 冪等式が閾値以後で成り立ち、そこから決まる底の既約分母が 1 であり、
候補が三点に尽きているなら、有理点は 1 である。 -/
theorem eq_one_of_cross_power_identity_of_den_one
    {q : ℚ} (hq : 0 < q) {L₀ : ℕ} (hL₀ : 0 < L₀)
    (hcross : ∀ L, L₀ ≤ L →
      rationalValueSeq q L ^ ((L + 1) ^ 3) = rationalValueSeq q (L + 1) ^ (L ^ 3))
    (hden : ∀ c : ℚ, 0 < c →
      (∀ L, L₀ ≤ L → rationalValueSeq q L = c ^ (L ^ 3)) → c.den = 1)
    (hcandidates : q = 1 / 2 ∨ q = 1 ∨ q = 2) :
    q = 1 := by
  obtain ⟨c, hcpos, hform⟩ :=
    (eventually_cross_power_identity_iff_rational_power_form_viaNecSuf q hq L₀ hL₀).mp hcross
  have hpower : EventualPowerFormAt q :=
    eventualPowerFormAt_of_rationalPowerForm_den_one hcpos (hden c hcpos hform) hL₀ hform
  exact eq_one_of_eventual_power_form hpower hcandidates

end Ising3DCut.LimitQuantity
