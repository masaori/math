/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.VertexAxisStraightVisitCount
import Ising2DLambda.NecSuf.KacWard.VertexAxisStraightVisitCount
import Ising2DLambda.KacWard.ClosedWalkPassesFromNecSuf

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

theorem vertexAxisStraightVisitCount_from_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (v : Vertex L) (a : ZMod 2) :
    vertexAxisStraightVisitCount γ hγ v a =
      Ising2DLambda.NecSuf.KacWard.vertexAxisStraightVisitCount γ orientedTarget
        (fun e f => stepTurning e f = 0)
        (fun e => directionAxis (directionNumber e)) v a := by
  simp only [vertexAxisStraightVisitCount,
    Ising2DLambda.NecSuf.KacWard.vertexAxisStraightVisitCount]
  simp only [closedWalkPassVertex, closedWalkPass, closedWalkSuccessor_from_necSuf]

end Ising2DLambda.KacWard
