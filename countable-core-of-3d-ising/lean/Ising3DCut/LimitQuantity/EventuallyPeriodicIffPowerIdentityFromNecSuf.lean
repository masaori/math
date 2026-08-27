/-
必要十分版 `NecSuf.eventuallyPeriodic_iff_crossPowerIdentity` から、具体版と同じ主張を導く。
具体版が担うのは、有限箱値と正の実数乗根を結ぶ冪等式、箱の点数の非零性、
および正の実数上での正の自然数乗の単射性を用意する段だけである。
-/
import Ising3DCut.LimitQuantity.EventuallyPeriodicIffPowerIdentity
import Ising3DCut.NecSuf.EventuallyPeriodicIffPowerIdentity

namespace Ising3DCut.LimitQuantity

/-- `eventually_periodic_iff_power_identity` を必要十分版から導いた版。 -/
theorem eventually_periodic_iff_power_identity_viaNecSuf (q : ℚ) (hq : 0 < q) :
    (∃ L0 p : ℕ, 0 < L0 ∧ 0 < p ∧
        ∀ L, L0 ≤ L →
          rootSeq (isingValueSeq q) siteCountSeq L =
            rootSeq (isingValueSeq q) siteCountSeq (L + p))
      ↔ (∃ L0 p : ℕ, 0 < L0 ∧ 0 < p ∧
        ∀ L, L0 ≤ L →
          isingValueSeq q L ^ siteCountSeq (L + p) =
            isingValueSeq q (L + p) ^ siteCountSeq L) := by
  apply Ising3DCut.NecSuf.eventuallyPeriodic_iff_crossPowerIdentity
    (rootSeq (isingValueSeq q) siteCountSeq) (isingValueSeq q) siteCountSeq
    (Set.Ioi (0 : ℝ))
  · intro L hL
    exact Set.mem_Ioi.mpr (posRoot_pos _ (isingValueSeq_pos hq hL) _)
  · intro L hL
    exact siteCountSeq_ne_zero hL
  · intro L hL
    exact rootSeq_pow_siteCountSeq hq hL
  · intro n hn x hx y hy hxy
    exact (pow_left_inj₀ hx.le hy.le hn).1 hxy

end Ising3DCut.LimitQuantity
