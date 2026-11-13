import Ising2DLambda.KacWard.WalkBoundaryVertexTurnMatch
import Ising2DLambda.NecSuf.KacWard.WalkBoundaryVertexTurnMatch

namespace Ising2DLambda.KacWard

/-- The left-hand abstract statement specializes to the actual walk
(`I = Fin (m + 1)`, `next = finRotate (m + 1)`, `G = ZMod 4`). -/
theorem vertexSimpleWalk_stepTurning_eq_boundary_turn_left_from_necSuf
    {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (hdistinct : Function.Injective
      (fun i : Fin (m + 1) => planeLift γ i.castSucc))
    (hleft : ∀ j : Fin (m + 1),
      Classical.choose
        (vertexSimpleWalk_step_interior_side γ hγ hh hv hdistinct j.val j.isLt) = true)
    (j : Fin (m + 1)) :
    let cells := (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset
    let v := planeLift γ (finRotate (m + 1) j).castSucc
    stepTurning (γ j) (γ (finRotate (m + 1) j)) =
      directionPairTurning (cellBoundaryIncoming cells v.1 v.2)
        (cellBoundaryOutgoing cells v.1 v.2) := by
  intro cells v
  let vertexAt : Fin (m + 1) → GridVertex :=
    fun i => planeLift γ (finRotate (m + 1) i).castSucc
  exact Ising2DLambda.NecSuf.KacWard.boundary_turn_match_left
    (finRotate (m + 1)) (fun i => directionNumber (γ i))
    (fun i => stepTurning (γ i) (γ (finRotate (m + 1) i))) directionPairTurning
    (fun i => cellBoundaryIncoming cells (vertexAt i).1 (vertexAt i).2)
    (fun i => cellBoundaryOutgoing cells (vertexAt i).1 (vertexAt i).2)
    (fun i => stepTurning_eq_directionPairTurning _ _
      (closedNonbacktrackingWalk_finRotate_successor γ hγ i))
    (fun i => by
      have h := vertexSimpleWalk_incoming_direction_eq_boundary_left
        γ hγ hh hv hdistinct hleft i
      rw [vertexSimpleWalk_planeLift_succ_eq_finRotate_castSucc γ hγ hh hv i] at h
      exact h)
    (fun i => vertexSimpleWalk_outgoing_direction_eq_boundary_left
      γ hγ hh hv hdistinct hleft (finRotate (m + 1) i))
    j

/-- The right-hand abstract statement specializes to the actual walk with
`c = 2` and the reversal law `directionPairTurning_reversed`. -/
theorem vertexSimpleWalk_stepTurning_eq_neg_boundary_turn_right_from_necSuf
    {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (hdistinct : Function.Injective
      (fun i : Fin (m + 1) => planeLift γ i.castSucc))
    (hright : ∀ j : Fin (m + 1),
      Classical.choose
        (vertexSimpleWalk_step_interior_side γ hγ hh hv hdistinct j.val j.isLt) = false)
    (j : Fin (m + 1)) :
    let cells := (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset
    let v := planeLift γ (finRotate (m + 1) j).castSucc
    stepTurning (γ j) (γ (finRotate (m + 1) j)) =
      -directionPairTurning (cellBoundaryIncoming cells v.1 v.2)
        (cellBoundaryOutgoing cells v.1 v.2) := by
  intro cells v
  let vertexAt : Fin (m + 1) → GridVertex :=
    fun i => planeLift γ (finRotate (m + 1) i).castSucc
  exact Ising2DLambda.NecSuf.KacWard.boundary_turn_match_right
    (2 : ZMod 4) (finRotate (m + 1)) (fun i => directionNumber (γ i))
    (fun i => stepTurning (γ i) (γ (finRotate (m + 1) i))) directionPairTurning
    (fun i => cellBoundaryIncoming cells (vertexAt i).1 (vertexAt i).2)
    (fun i => cellBoundaryOutgoing cells (vertexAt i).1 (vertexAt i).2)
    directionPairTurning_reversed
    (fun i => stepTurning_eq_directionPairTurning _ _
      (closedNonbacktrackingWalk_finRotate_successor γ hγ i))
    (fun i => vertexSimpleWalk_incoming_direction_eq_boundary_right
      γ hγ hh hv hdistinct hright (finRotate (m + 1) i))
    (fun i => by
      have h := vertexSimpleWalk_outgoing_direction_eq_boundary_right
        γ hγ hh hv hdistinct hright i
      rw [vertexSimpleWalk_planeLift_succ_eq_finRotate_castSucc γ hγ hh hv i] at h
      exact h)
    j

end Ising2DLambda.KacWard
