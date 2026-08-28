/-
必要十分版 `NecSuf.infiniteRange_of_ne_target` から具体版と同じ主張を導く。
具体側で新たに必要な仮定は無い。
-/
import Ising3DCut.LimitQuantity.SecondLimitQuantityCandidateHasInfiniteRange
import Ising3DCut.NecSuf.SecondLimitCandidateInfiniteRange

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- `second_limit_quantity_candidate_has_infinite_range` を必要十分版から導いた版。 -/
theorem second_limit_quantity_candidate_has_infinite_range_fromNecSuf
    (q : ℚ) {α : ℝ} (hq_ne_one : q ≠ 1)
    (hlimit : Tendsto (rootSeq (isingValueSeq q) siteCountSeq) atTop (nhds α))
    (heventuallyConstantOnlyAtOne :
      (∃ L0 c, ∀ L, L0 ≤ L → rootSeq (isingValueSeq q) siteCountSeq L = c) → q = 1) :
    (Set.range (rootSeq (isingValueSeq q) siteCountSeq)).Infinite :=
  Ising3DCut.NecSuf.infiniteRange_of_ne_target
    (rootSeq (isingValueSeq q) siteCountSeq) q 1 hq_ne_one ⟨α, hlimit⟩
    heventuallyConstantOnlyAtOne

end Ising3DCut.LimitQuantity
