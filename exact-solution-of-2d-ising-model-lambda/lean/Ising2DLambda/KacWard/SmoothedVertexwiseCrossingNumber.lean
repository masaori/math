import Mathlib.Data.Finset.Prod
import Mathlib.Data.Fintype.Basic
import Ising2DLambda.KacWard.SmoothingStraightVisitCount
import Ising2DLambda.NecSuf.KacWard.SmoothedVertexwiseCrossingNumber

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- `def_smoothed_vertexwise_crossing_number` for an actual closed nonbacktracking walk. -/
noncomputable def smoothedVertexwiseCrossingNumber {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (_hγ : closedNonbacktrackingWalk γ) (k l : Fin (m + 1))
    (w : Vertex L) : ℕ := by
  classical
  exact ((Finset.univ ×ˢ Finset.univ).filter fun p : Fin (m + 1) × Fin (m + 1) =>
    p.1 < p.2 ∧ orientedTarget (γ p.1) = w ∧ orientedTarget (γ p.2) = w ∧
      stepTurning (γ p.1) (smoothedExitEdge γ k l p.1) = 0 ∧
      stepTurning (γ p.2) (smoothedExitEdge γ k l p.2) = 0 ∧
      directionAxis (directionNumber (γ p.1)) ≠
        directionAxis (directionNumber (γ p.2))).card

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
