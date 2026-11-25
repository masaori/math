/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.SmoothingSplitMutualCrossing
import Ising2DLambda.NecSuf.KacWard.SmoothingSplitMutualCrossing
import Ising2DLambda.KacWard.SplitMutualCrossingNumberFromNecSuf

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

variable {L m : ℕ} [NeZero L]

/-- 具体版が必要十分版の特殊化として得られることの記録（接続は非後退の後続、直進は一歩の回転が零、
軸は方向番号の軸）。 -/
theorem splitMutualCrossingNumber_eq_closedWalkMutualCrossingNumber_from_necSuf
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)}
    (hcross : indexPairCrossing γ hγ k l) (hkl : k < l) :
    splitMutualCrossingNumber γ hγ k l =
      closedWalkMutualCrossingNumber (smoothedSplitWalkA γ hγ k l)
        (smoothedSplitWalkA_closed γ hγ hcross hkl) (smoothedSplitWalkB γ hγ k l)
        (smoothedSplitWalkB_closed γ hγ hcross hkl) := by
  rw [splitMutualCrossingNumber_from_necSuf]
  have h := Ising2DLambda.NecSuf.KacWard.splitMutualCrossingNumber_eq_closedWalkMutual_necSuf
    (fun e f => f ∈ nonbacktrackingSuccessors e) γ orientedTarget (fun e f => stepTurning e f = 0)
    (fun e => directionAxis (directionNumber e))
    (fun r => smoothedExitEdge_mem_nonbacktrackingSuccessors γ hγ hcross r) hkl
  rw [← h]
  rfl

end Ising2DLambda.KacWard
