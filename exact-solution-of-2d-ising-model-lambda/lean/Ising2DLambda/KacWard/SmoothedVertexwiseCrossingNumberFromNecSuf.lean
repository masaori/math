/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.SmoothedVertexwiseCrossingNumber
import Ising2DLambda.NecSuf.KacWard.SmoothedVertexwiseCrossingNumber
import Ising2DLambda.KacWard.ClosedWalkPassesFromNecSuf

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

theorem smoothedVertexwiseCrossingNumber_from_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (k l : Fin (m + 1))
    (w : Vertex L) :
    smoothedVertexwiseCrossingNumber γ hγ k l w =
      Ising2DLambda.NecSuf.KacWard.smoothedVertexwiseCrossingNumber
        γ orientedTarget (fun e f => stepTurning e f = 0)
        (fun e => directionAxis (directionNumber e)) k l w := by
  classical
  simp only [smoothedVertexwiseCrossingNumber,
    Ising2DLambda.NecSuf.KacWard.smoothedVertexwiseCrossingNumber,
    smoothedExitEdge, Ising2DLambda.NecSuf.KacWard.smoothedSuccessorEdge,
    closedWalkSuccessor_from_necSuf]

end Ising2DLambda.KacWard
