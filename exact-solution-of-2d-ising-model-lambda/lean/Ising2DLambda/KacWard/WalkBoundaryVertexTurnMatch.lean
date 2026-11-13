import Ising2DLambda.KacWard.WalkBoundaryDirectionMatch
import Ising2DLambda.KacWard.StepTurningDirectionPair
import Ising2DLambda.KacWard.BoundaryVertexLocalTurn
import Mathlib.Tactic

/-!
`claim_plane_simple_polygon_cyclic_turning` の段「各出発位置の回転数と境界頂点の局所回転数」。

歩 `j` の終点、すなわち次の歩 `finRotate (m + 1) j` の出発位置 `v` で、
実際の歩道の一歩の回転数 `stepTurning (γ j) (γ (finRotate (m + 1) j))` は、
内側セルを左に置くなら四セル表の局所回転数に等しく、右に置くならその符号反転に等しい。
本文の「表の各行に一歩の回転数の定義を適用すると … 逆向きに巡ると各曲がりの符号が反転する」に当たる。
-/

namespace Ising2DLambda.KacWard

/-- The cyclic successor of a non-last step is the next step. -/
theorem finRotate_castSucc_eq_succ (m : ℕ) (k : Fin m) :
    finRotate (m + 1) k.castSucc = k.succ := by
  apply Fin.ext
  rw [coe_finRotate_of_ne_last (Fin.castSucc_lt_last k).ne]
  simp

/-- The cyclic successor of a step is a nonbacktracking successor in a closed walk. -/
theorem closedNonbacktrackingWalk_finRotate_successor {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (j : Fin (m + 1)) :
    γ (finRotate (m + 1) j) ∈ nonbacktrackingSuccessors (γ j) := by
  by_cases hj : j = Fin.last m
  · subst hj
    rw [finRotate_last]
    exact hγ.2
  · obtain ⟨k, rfl⟩ := Fin.exists_castSucc_eq.mpr hj
    rw [finRotate_castSucc_eq_succ]
    exact hγ.1 k

/-- The endpoint of step `j` is the departure point of its cyclic successor. -/
theorem vertexSimpleWalk_planeLift_succ_eq_finRotate_castSucc
    {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (j : Fin (m + 1)) :
    planeLift γ j.succ = planeLift γ (finRotate (m + 1) j).castSucc := by
  by_cases hj : j = Fin.last m
  · subst hj
    rw [finRotate_last, Fin.succ_last, Fin.castSucc_zero]
    simpa [hh, hv, Prod.add_def] using planeLift_endpoint_winding γ hγ
  · obtain ⟨k, rfl⟩ := Fin.exists_castSucc_eq.mpr hj
    rw [finRotate_castSucc_eq_succ]
    rfl

/-- Interior on the left: the turn at the endpoint of step `j` is the local
turn of the four-cell table at that boundary vertex. -/
theorem vertexSimpleWalk_stepTurning_eq_boundary_turn_left
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
  -- 入方向: 歩 `j` の終点での表の入方向（左の入方向の対応）
  have hin : directionNumber (γ j) = cellBoundaryIncoming cells v.1 v.2 := by
    have h := vertexSimpleWalk_incoming_direction_eq_boundary_left
      γ hγ hh hv hdistinct hleft j
    rw [vertexSimpleWalk_planeLift_succ_eq_finRotate_castSucc γ hγ hh hv j] at h
    exact h
  -- 出方向: 次の歩の出発位置での表の出方向（左の出方向の対応）
  have hout : directionNumber (γ (finRotate (m + 1) j)) =
      cellBoundaryOutgoing cells v.1 v.2 :=
    vertexSimpleWalk_outgoing_direction_eq_boundary_left
      γ hγ hh hv hdistinct hleft (finRotate (m + 1) j)
  calc
    stepTurning (γ j) (γ (finRotate (m + 1) j)) =
        directionPairTurning (directionNumber (γ j))
          (directionNumber (γ (finRotate (m + 1) j))) :=
      stepTurning_eq_directionPairTurning _ _
        (closedNonbacktrackingWalk_finRotate_successor γ hγ j)
    _ = directionPairTurning (cellBoundaryIncoming cells v.1 v.2)
          (directionNumber (γ (finRotate (m + 1) j))) := by rw [hin]
    _ = directionPairTurning (cellBoundaryIncoming cells v.1 v.2)
          (cellBoundaryOutgoing cells v.1 v.2) := by rw [hout]

/-- Interior on the right: the turn at the endpoint of step `j` is minus the
local turn of the four-cell table at that boundary vertex. -/
theorem vertexSimpleWalk_stepTurning_eq_neg_boundary_turn_right
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
  -- 表の入方向: 次の歩の出発位置で、次の歩の方向に二を足したもの（右の入方向の対応）
  have hin : directionNumber (γ (finRotate (m + 1) j)) + 2 =
      cellBoundaryIncoming cells v.1 v.2 :=
    vertexSimpleWalk_incoming_direction_eq_boundary_right
      γ hγ hh hv hdistinct hright (finRotate (m + 1) j)
  -- 表の出方向: 歩 `j` の終点で、歩 `j` の方向に二を足したもの（右の出方向の対応）
  have hout : directionNumber (γ j) + 2 = cellBoundaryOutgoing cells v.1 v.2 := by
    have h := vertexSimpleWalk_outgoing_direction_eq_boundary_right
      γ hγ hh hv hdistinct hright j
    rw [vertexSimpleWalk_planeLift_succ_eq_finRotate_castSucc γ hγ hh hv j] at h
    exact h
  calc
    stepTurning (γ j) (γ (finRotate (m + 1) j)) =
        directionPairTurning (directionNumber (γ j))
          (directionNumber (γ (finRotate (m + 1) j))) :=
      stepTurning_eq_directionPairTurning _ _
        (closedNonbacktrackingWalk_finRotate_successor γ hγ j)
    _ = -directionPairTurning (directionNumber (γ (finRotate (m + 1) j)) + 2)
          (directionNumber (γ j) + 2) := by
      rw [directionPairTurning_reversed, neg_neg]
    _ = -directionPairTurning (cellBoundaryIncoming cells v.1 v.2)
          (directionNumber (γ j) + 2) := by rw [hin]
    _ = -directionPairTurning (cellBoundaryIncoming cells v.1 v.2)
          (cellBoundaryOutgoing cells v.1 v.2) := by rw [hout]

end Ising2DLambda.KacWard
