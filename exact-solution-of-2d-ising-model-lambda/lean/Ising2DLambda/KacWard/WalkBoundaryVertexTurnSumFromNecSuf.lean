import Ising2DLambda.KacWard.WalkBoundaryVertexTurnSum
import Ising2DLambda.NecSuf.KacWard.WalkBoundaryVertexTurnSum

namespace Ising2DLambda.KacWard

/-- The left-hand abstract statement specializes to the actual walk
(`E = OrientedEdge L`, `V = GridVertex`, `turn = stepTurning`,
`pos` = the departure bijection, `localTurn` = the four-cell table turn). -/
theorem vertexSimpleWalk_cyclicTotalTurning_eq_boundary_turn_sum_left_from_necSuf
    {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (hdistinct : Function.Injective
      (fun i : Fin (m + 1) => planeLift γ i.castSucc))
    (hleft : ∀ j : Fin (m + 1),
      Classical.choose
        (vertexSimpleWalk_step_interior_side γ hγ hh hv hdistinct j.val j.isLt) = true) :
    let cells := (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset
    cyclicTotalTurning γ hγ =
      ∑ v ∈ cellBoundaryVertices cells,
        directionPairTurning (cellBoundaryIncoming cells v.1 v.2)
          (cellBoundaryOutgoing cells v.1 v.2) := by
  intro cells
  rw [cyclicTotalTurning_from_necSuf]
  exact Ising2DLambda.NecSuf.KacWard.cyclic_turning_eq_boundary_turn_sum_left
    stepTurning γ (cellBoundaryVertices cells)
    (vertexSimpleWalk_departure_equiv_boundaryVertices γ hγ hh hv hdistinct)
    (fun v => directionPairTurning (cellBoundaryIncoming cells v.1 v.2)
      (cellBoundaryOutgoing cells v.1 v.2))
    (fun j => vertexSimpleWalk_stepTurning_eq_boundary_turn_left
      γ hγ hh hv hdistinct hleft j)

/-- The right-hand abstract statement specializes to the actual walk. -/
theorem vertexSimpleWalk_cyclicTotalTurning_eq_neg_boundary_turn_sum_right_from_necSuf
    {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (hdistinct : Function.Injective
      (fun i : Fin (m + 1) => planeLift γ i.castSucc))
    (hright : ∀ j : Fin (m + 1),
      Classical.choose
        (vertexSimpleWalk_step_interior_side γ hγ hh hv hdistinct j.val j.isLt) = false) :
    let cells := (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset
    cyclicTotalTurning γ hγ =
      -∑ v ∈ cellBoundaryVertices cells,
        directionPairTurning (cellBoundaryIncoming cells v.1 v.2)
          (cellBoundaryOutgoing cells v.1 v.2) := by
  intro cells
  rw [cyclicTotalTurning_from_necSuf]
  exact Ising2DLambda.NecSuf.KacWard.cyclic_turning_eq_neg_boundary_turn_sum_right
    stepTurning γ (cellBoundaryVertices cells)
    (vertexSimpleWalk_departure_equiv_boundaryVertices γ hγ hh hv hdistinct)
    (fun v => directionPairTurning (cellBoundaryIncoming cells v.1 v.2)
      (cellBoundaryOutgoing cells v.1 v.2))
    (fun j => vertexSimpleWalk_stepTurning_eq_neg_boundary_turn_right
      γ hγ hh hv hdistinct hright j)

end Ising2DLambda.KacWard
