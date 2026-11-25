/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.EdgeDistinctSmoothingCrossingParity
import Ising2DLambda.NecSuf.KacWard.EdgeDistinctSmoothingCrossingParity

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

variable {L m : ℕ} [NeZero L]

/-- 具体版が必要十分版の特殊化として得られることの記録（`R = 𝔽₂`、五つの等式は上の具体版の各段）。 -/
theorem edge_distinct_smoothing_crossing_parity_from_necSuf (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (hinj : Function.Injective fun r => (γ r).1)
    {k l : Fin (m + 1)} (hcross : indexPairCrossing γ hγ k l) (hkl : k < l) :
    (closedWalkCrossingNumber γ hγ : ZMod 2) =
      ((closedWalkCrossingNumber (smoothedSplitWalkA γ hγ k l)
            (smoothedSplitWalkA_closed γ hγ hcross hkl)
          + closedWalkCrossingNumber (smoothedSplitWalkB γ hγ k l)
            (smoothedSplitWalkB_closed γ hγ hcross hkl) + 1 : ℕ) : ZMod 2)
        + evenEdgeChainIntersection L (closedWalkSupport (smoothedSplitWalkA γ hγ k l))
            (closedWalkSupport (smoothedSplitWalkB γ hγ k l)) :=
  Ising2DLambda.NecSuf.KacWard.edge_distinct_smoothing_crossing_parity_necSuf _ _ _ _ _ _ _ _ _
    (crossing_vertexAxisStraightVisitCount_eq_one γ hγ hinj hcross 0)
    (crossing_vertexAxisStraightVisitCount_eq_one γ hγ hinj hcross 1)
    (closedWalk_smoothing_crossing_number_update γ hγ hcross)
    (smoothing_split_crossing_partition γ hγ hcross hkl)
    (splitMutualCrossingNumber_eq_closedWalkMutualCrossingNumber γ hγ hcross hkl)
    (closedWalkMutualCrossingNumber_eq_intersection
      (smoothedSplitWalkA γ hγ k l) (smoothedSplitWalkA_closed γ hγ hcross hkl)
      (smoothedSplitWalkB γ hγ k l) (smoothedSplitWalkB_closed γ hγ hcross hkl)
      (smoothedSplitWalkA_edge_injective γ hγ hinj hkl)
      (smoothedSplitWalkB_edge_injective γ hγ hinj hkl)
      (smoothedSplitWalks_edge_disjoint γ hγ hinj hkl))

end Ising2DLambda.KacWard
