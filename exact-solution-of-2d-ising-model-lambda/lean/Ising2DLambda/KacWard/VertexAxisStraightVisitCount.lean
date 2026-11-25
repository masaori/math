import Mathlib.Data.Finset.Prod
import Mathlib.Data.Fintype.Basic
import Ising2DLambda.KacWard.ClosedWalkPasses
import Ising2DLambda.KacWard.StepTurning
import Ising2DLambda.KacWard.DirectionGateCrossingTurning

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

end Ising2DLambda.KacWard
