/-
「第二の極限量候補ではどの閾値の先にも交差冪等式の破れがある」の具体版を、
必要十分版 `Ising3DCut.NecSuf.exists_pair_not_related_of_infinite_range` から導く。

具体側に残るのは、有限箱量の正値性・点数の非零性・交差冪等式から正の乗根の一致が
従うこと・第二候補の値域が無限であることだけである。
-/
import Ising3DCut.NecSuf.SecondLimitCandidateHasTailCrossPowerFailure
import Ising3DCut.LimitQuantity.CrossPowerEqualityImpliesRootEquality
import Ising3DCut.LimitQuantity.EventuallyConstantIffPowerIdentity
import Ising3DCut.LimitQuantity.SecondLimitQuantityCandidateHasInfiniteRange

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- `claim_second_limit_candidate_has_tail_cross_power_failure` を必要十分版から導いた版。 -/
theorem second_limit_candidate_has_tail_cross_power_failure_fromNecSuf
    (q : ℚ) {α : ℝ} (hq : 0 < q) (hq_ne_one : q ≠ 1)
    (hlimit : Tendsto (rootSeq (isingValueSeq q) siteCountSeq) atTop (𝓝 α))
    (heventuallyConstantOnlyAtOne :
      (∃ L0 c, ∀ L, L0 ≤ L → rootSeq (isingValueSeq q) siteCountSeq L = c) → q = 1) :
    ∀ K : ℕ, ∃ L M : ℕ,
      max K 1 ≤ L ∧ max K 1 ≤ M ∧
        isingValueSeq q L ^ siteCountSeq M ≠
          isingValueSeq q M ^ siteCountSeq L := by
  refine NecSuf.exists_pair_not_related_of_infinite_range
    (rootSeq (isingValueSeq q) siteCountSeq)
    (fun L M => isingValueSeq q L ^ siteCountSeq M = isingValueSeq q M ^ siteCountSeq L)
    1 ?_ (second_limit_quantity_candidate_has_infinite_range q hq_ne_one hlimit
      heventuallyConstantOnlyAtOne)
  intro L M hL hM hrel
  exact cross_power_equality_implies_posRoot_equality
    (isingValueSeq q L) (isingValueSeq q M)
    (isingValueSeq_pos hq hL) (isingValueSeq_pos hq hM)
    (siteCountSeq L) (siteCountSeq M)
    (siteCountSeq_ne_zero hL) (siteCountSeq_ne_zero hM) hrel

end Ising3DCut.LimitQuantity
