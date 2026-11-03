import Mathlib.Data.Finset.Prod
import Mathlib.Data.Fintype.Basic
import Ising2DLambda.KacWard.ClosedWalkPasses
import Ising2DLambda.KacWard.StepTurning
import Ising2DLambda.KacWard.DirectionGateCrossingTurning
import Ising2DLambda.NecSuf.KacWard.VertexAxisStraightVisitCount

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- `def_vertex_axis_straight_visit_count` for an actual closed nonbacktracking walk. -/
noncomputable def vertexAxisStraightVisitCount {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (v : Vertex L) (a : ZMod 2) : ℕ := by
  classical
  exact (Finset.univ.filter fun k : Fin (m + 1) =>
    closedWalkPassVertex γ hγ k = v ∧
      stepTurning (closedWalkPass γ hγ k).1 (closedWalkPass γ hγ k).2 = 0 ∧
      directionAxis (directionNumber (γ k)) = a).card

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
