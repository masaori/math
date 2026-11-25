/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.SmoothingSplitCrossingPartition
import Ising2DLambda.KacWard.SmoothedSplitClosedWalksFromNecSuf
import Ising2DLambda.NecSuf.KacWard.SmoothingSplitCrossingPartition
import Ising2DLambda.KacWard.ClosedWalkCrossingNumberFromNecSuf
import Ising2DLambda.KacWard.SmoothedCrossingNumberFromNecSuf
import Ising2DLambda.KacWard.SplitMutualCrossingNumberFromNecSuf

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

variable {L m : ℕ} [NeZero L]

/-- 具体版が必要十分版の特殊化として得られることの記録（接続は非後退の後続、直進は一歩の回転が零、
軸は方向番号の軸。平滑化後の出辺の接続は `smoothedExitEdge_mem_nonbacktrackingSuccessors`）。 -/
theorem smoothing_split_crossing_partition_from_necSuf (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)} (hcross : indexPairCrossing γ hγ k l)
    (hkl : k < l) :
    closedWalkCrossingNumber (smoothedSplitWalkA γ hγ k l) (smoothedSplitWalkA_closed γ hγ hcross hkl)
      + closedWalkCrossingNumber (smoothedSplitWalkB γ hγ k l)
          (smoothedSplitWalkB_closed γ hγ hcross hkl)
      + splitMutualCrossingNumber γ hγ k l =
      smoothedCrossingNumber γ hγ k l := by
  rw [closedWalkCrossingNumber_from_necSuf, closedWalkCrossingNumber_from_necSuf,
    smoothedSplitWalkA_from_necSuf, smoothedSplitWalkB_from_necSuf,
    splitMutualCrossingNumber_from_necSuf, smoothedCrossingNumber_from_necSuf]
  exact Ising2DLambda.NecSuf.KacWard.smoothing_split_crossing_partition_necSuf
    (fun e f => f ∈ nonbacktrackingSuccessors e) γ orientedTarget (fun e f => stepTurning e f = 0)
    (fun e => directionAxis (directionNumber e))
    (fun r => smoothedExitEdge_mem_nonbacktrackingSuccessors γ hγ hcross r) hkl

end Ising2DLambda.KacWard
