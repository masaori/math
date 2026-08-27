/-
必要十分版 `NecSuf.eventuallyPeriodic_residueClassConstant` から、具体版と
同じ主張を導く。具体側で新たに必要な仮定は無い。
-/
import Ising3DCut.LimitQuantity.EventuallyPeriodicResidueClassConstant
import Ising3DCut.NecSuf.EventuallyPeriodicResidueClassConstant

namespace Ising3DCut.LimitQuantity

/-- `eventually_periodic_residue_class_constant` を必要十分版から導いた版。 -/
theorem eventually_periodic_residue_class_constant_fromNecSuf
    (q : ℚ) {L0 p : ℕ}
    (hperiodic : ∀ L, L0 ≤ L →
      rootSeq (isingValueSeq q) siteCountSeq L =
        rootSeq (isingValueSeq q) siteCountSeq (L + p))
    (r : ℕ) :
    ∀ k : ℕ,
      rootSeq (isingValueSeq q) siteCountSeq (L0 + r + k * p) =
        rootSeq (isingValueSeq q) siteCountSeq (L0 + r) := by
  exact Ising3DCut.NecSuf.eventuallyPeriodic_residueClassConstant
    (rootSeq (isingValueSeq q) siteCountSeq) hperiodic r

end Ising3DCut.LimitQuantity
