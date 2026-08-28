/-
必要十分版 `NecSuf.eventuallyPeriodicLimit_onlyTarget` から具体版と同じ主張を導く。
具体側で新たに必要な仮定は無い。
-/
import Ising3DCut.LimitQuantity.EventuallyPeriodicLimitQuantityOnlyAtOne
import Ising3DCut.NecSuf.EventuallyPeriodicLimitQuantityOnlyAtOne

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- `eventually_periodic_limit_quantity_only_at_one` を必要十分版から導いた版。 -/
theorem eventually_periodic_limit_quantity_only_at_one_fromNecSuf
    (q : ℚ) {L0 p : ℕ} (hp : 0 < p)
    (hperiodic : ∀ L, L0 ≤ L →
      rootSeq (isingValueSeq q) siteCountSeq L =
        rootSeq (isingValueSeq q) siteCountSeq (L + p))
    (heventuallyConstantOnlyAtOne :
      (∃ c : ℝ, ∀ L, L0 ≤ L → rootSeq (isingValueSeq q) siteCountSeq L = c) → q = 1)
    (hlimit : ∃ α : ℝ, Tendsto (rootSeq (isingValueSeq q) siteCountSeq) atTop (nhds α)) :
    q = 1 := by
  apply Ising3DCut.NecSuf.eventuallyPeriodicLimit_onlyTarget
    (rootSeq (isingValueSeq q) siteCountSeq) q 1 hp
  · exact eventually_periodic_residue_class_constant q hperiodic
  · exact fun _ => tendsto_residue_class_index_atTop hp
  · exact heventuallyConstantOnlyAtOne
  · exact hlimit

end Ising3DCut.LimitQuantity
