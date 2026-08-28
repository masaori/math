/-
必要十分版 `NecSuf.finiteRangeLimit_onlyTarget` から具体版と同じ主張を導く。
具体側で新たに必要な仮定は無い。
-/
import Ising3DCut.LimitQuantity.FiniteRangeLimitQuantityOnlyAtOne
import Ising3DCut.NecSuf.FiniteRangeLimitOnlyTarget

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- `finite_range_limit_quantity_only_at_one` を必要十分版から導いた版。 -/
theorem finite_range_limit_quantity_only_at_one_fromNecSuf
    (q : ℚ) {α : ℝ}
    (hfin : (Set.range (rootSeq (isingValueSeq q) siteCountSeq)).Finite)
    (hlimit : Tendsto (rootSeq (isingValueSeq q) siteCountSeq) atTop (nhds α))
    (heventuallyConstantOnlyAtOne :
      (∃ L0 c, ∀ L, L0 ≤ L → rootSeq (isingValueSeq q) siteCountSeq L = c) → q = 1) :
    q = 1 :=
  Ising3DCut.NecSuf.finiteRangeLimit_onlyTarget
    (rootSeq (isingValueSeq q) siteCountSeq) q 1 hfin ⟨α, hlimit⟩
    heventuallyConstantOnlyAtOne

end Ising3DCut.LimitQuantity
