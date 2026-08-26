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
import Ising3DCut.LimitQuantity.DenominatorTwoPointAndFinalCandidateSet

namespace Ising3DCut.LimitQuantity

/-- 正の有理点の既約分子と既約分母がともに `2` を割るなら、候補は三点に尽きる。 -/
theorem positive_rational_three_candidates_of_num_den_dvd_two
    {q : ℚ} (hq : 0 < q)
    (hnum : q.num.natAbs ∣ 2) (hden : q.den ∣ 2) :
    q = 1 / 2 ∨ q = 1 ∨ q = 2 := by
  have hnumPos : 0 < q.num.natAbs := Int.natAbs_pos.mpr (Rat.num_ne_zero.mpr hq.ne')
  have hdenPos : 0 < q.den := q.den_pos
  rcases positive_integer_dvd_two_candidates hnumPos hnum with hn | hn
  · rcases positive_integer_dvd_two_candidates hdenPos hden with hd | hd
    · right; left
      rw [← Rat.num_div_den q]
      rw [show q.num = 1 by
        have hqnum : (0 : ℤ) < q.num := Rat.num_pos.mpr hq
        omega]
      norm_num [hd]
    · left
      rw [← Rat.num_div_den q]
      rw [show q.num = 1 by
        have hqnum : (0 : ℤ) < q.num := Rat.num_pos.mpr hq
        omega]
      norm_num [hd]
  · rcases positive_integer_dvd_two_candidates hdenPos hden with hd | hd
    · right; right
      rw [← Rat.num_div_den q]
      rw [show q.num = 2 by
        have hqnum : (0 : ℤ) < q.num := Rat.num_pos.mpr hq
        omega]
      norm_num [hd]
    · exfalso
      have hnot : ¬Nat.Coprime q.num.natAbs q.den := by
        rw [hn, hd]
        norm_num
      exact hnot q.reduced

/-- 冪等式が閾値以後で成り立ち、そこから決まる底の既約分母が 1 であり、
候補が三点に尽きているなら、有理点は 1 である。 -/
theorem eq_one_of_cross_power_identity_of_den_one
    {q : ℚ} (hq : 0 < q) {L₀ : ℕ} (hL₀ : 0 < L₀)
    (hcross : ∀ L, L₀ ≤ L →
      rationalValueSeq q L ^ ((L + 1) ^ 3) = rationalValueSeq q (L + 1) ^ (L ^ 3))
    (hden : ∀ c : ℚ, 0 < c →
      (∀ L, L₀ ≤ L → rationalValueSeq q L = c ^ (L ^ 3)) → c.den = 1)
    (hqnum : q.num.natAbs ∣ 2) (hqden : q.den ∣ 2) :
    q = 1 := by
  obtain ⟨c, hcpos, hform⟩ :=
    (eventually_cross_power_identity_iff_rational_power_form_viaNecSuf q hq L₀ hL₀).mp hcross
  have hpower : EventualPowerFormAt q :=
    eventualPowerFormAt_of_rationalPowerForm_den_one hcpos (hden c hcpos hform) hL₀ hform
  exact eq_one_of_eventual_power_form hpower
    (positive_rational_three_candidates_of_num_den_dvd_two hq hqnum hqden)

end Ising3DCut.LimitQuantity
