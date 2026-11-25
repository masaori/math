/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.SmoothedCrossingNumber
import Ising2DLambda.NecSuf.KacWard.SmoothedCrossingNumber
import Ising2DLambda.KacWard.ClosedWalkPassesFromNecSuf

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

theorem smoothedCrossingNumber_from_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (k l : Fin (m + 1)) :
    smoothedCrossingNumber γ hγ k l =
      Ising2DLambda.NecSuf.KacWard.smoothedCrossingNumber
        γ orientedTarget (fun e f => stepTurning e f = 0)
        (fun e => directionAxis (directionNumber e)) k l := by
  classical
  simp only [smoothedCrossingNumber,
    Ising2DLambda.NecSuf.KacWard.smoothedCrossingNumber,
    smoothedExitEdge, Ising2DLambda.NecSuf.KacWard.smoothedSuccessorEdge,
    closedWalkSuccessor_from_necSuf]

end Ising2DLambda.KacWard
