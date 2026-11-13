import Ising2DLambda.KacWard.WalkBoundaryVertexTurnMatch
import Ising2DLambda.KacWard.WalkBoundaryVertexBijection
import Ising2DLambda.KacWard.CyclicTotalTurning
import Mathlib.Tactic

/-!
`claim_plane_simple_polygon_cyclic_turning` の段「出発辺の回転数和と境界頂点の局所回転数和」。

循環総回転数 `cyclicTotalTurning γ hγ` は、各歩 `j` から巡回の後続 `finRotate (m + 1) j` への
一歩の回転数の全歩にわたる和である。各項は歩 `j` の終点（後続の歩の出発位置）での四セル表の局所回転数
（内側を右に置くならその符号反転）に等しい（`vertexSimpleWalk_stepTurning_eq_boundary_turn_left` /
`..._neg_boundary_turn_right`）。巡回の後続 `finRotate (m + 1)` と、出発位置と境界頂点の全単射
`vertexSimpleWalk_departure_equiv_boundaryVertices` で再添字付けすると、境界頂点にわたる局所回転数の和になる。
本文の「表の各行に一歩の回転数の定義を適用すると … したがって $t_\circ(\gamma)=v_1-v_3$ または $-(v_1-v_3)$」の
一つ目の等号のうち、和を境界頂点へ移す部分に当たる。
-/

open scoped BigOperators

namespace Ising2DLambda.KacWard

/-- The cyclic total turning is the sum over all steps of the turn into the cyclic successor. -/
theorem cyclicTotalTurning_eq_sum_finRotate {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ) :
    cyclicTotalTurning γ hγ =
      ∑ j : Fin (m + 1), stepTurning (γ j) (γ (finRotate (m + 1) j)) := by
  -- 全歩の和を、最後以外の歩の和と最後の歩に分ける
  rw [Fin.sum_univ_castSucc, finRotate_last]
  -- 最後以外の歩の巡回の後続は次の歩
  simp only [finRotate_castSucc_eq_succ]
  rfl

/-- The departure bijection sends step `j` to its departure point. -/
theorem vertexSimpleWalk_departure_equiv_boundaryVertices_apply
    {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (hdistinct : Function.Injective
      (fun i : Fin (m + 1) => planeLift γ i.castSucc))
    (j : Fin (m + 1)) :
    (vertexSimpleWalk_departure_equiv_boundaryVertices γ hγ hh hv hdistinct j).val =
      planeLift γ j.castSucc := rfl

/-- A sum over the steps of a function of the endpoint of each step equals the sum of that
function over the boundary vertices of the interior cells. -/
theorem vertexSimpleWalk_sum_endpoint_eq_sum_boundaryVertices
    {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (hdistinct : Function.Injective
      (fun i : Fin (m + 1) => planeLift γ i.castSucc))
    (g : GridVertex → ℤ) :
    ∑ j : Fin (m + 1), g (planeLift γ (finRotate (m + 1) j).castSucc) =
      ∑ v ∈ cellBoundaryVertices (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset, g v := by
  let e := vertexSimpleWalk_departure_equiv_boundaryVertices γ hγ hh hv hdistinct
  calc
    ∑ j : Fin (m + 1), g (planeLift γ (finRotate (m + 1) j).castSucc) =
        ∑ j : Fin (m + 1), g (planeLift γ j.castSucc) :=
      -- 巡回の後続 `finRotate (m + 1)` は歩の全単射
      Equiv.sum_comp (finRotate (m + 1)) (fun j => g (planeLift γ j.castSucc))
    _ = ∑ x : {v // v ∈ cellBoundaryVertices
          (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset}, g x.val :=
      -- 出発位置と境界頂点の全単射
      Equiv.sum_comp e (fun x => g x.val)
    _ = ∑ v ∈ cellBoundaryVertices
          (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset, g v :=
      Finset.sum_coe_sort _ g

/-- Interior on the left: the cyclic total turning is the sum of the local turns of the
four-cell table over the boundary vertices. -/
theorem vertexSimpleWalk_cyclicTotalTurning_eq_boundary_turn_sum_left
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
  let g : GridVertex → ℤ := fun v =>
    directionPairTurning (cellBoundaryIncoming cells v.1 v.2)
      (cellBoundaryOutgoing cells v.1 v.2)
  calc
    cyclicTotalTurning γ hγ =
        ∑ j : Fin (m + 1), stepTurning (γ j) (γ (finRotate (m + 1) j)) :=
      cyclicTotalTurning_eq_sum_finRotate γ hγ
    _ = ∑ j : Fin (m + 1), g (planeLift γ (finRotate (m + 1) j).castSucc) :=
      Finset.sum_congr rfl (fun j _ =>
        vertexSimpleWalk_stepTurning_eq_boundary_turn_left γ hγ hh hv hdistinct hleft j)
    _ = ∑ v ∈ cellBoundaryVertices cells, g v :=
      vertexSimpleWalk_sum_endpoint_eq_sum_boundaryVertices γ hγ hh hv hdistinct g

/-- Interior on the right: the cyclic total turning is minus the sum of the local turns of
the four-cell table over the boundary vertices. -/
theorem vertexSimpleWalk_cyclicTotalTurning_eq_neg_boundary_turn_sum_right
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
  let g : GridVertex → ℤ := fun v =>
    -directionPairTurning (cellBoundaryIncoming cells v.1 v.2)
      (cellBoundaryOutgoing cells v.1 v.2)
  calc
    cyclicTotalTurning γ hγ =
        ∑ j : Fin (m + 1), stepTurning (γ j) (γ (finRotate (m + 1) j)) :=
      cyclicTotalTurning_eq_sum_finRotate γ hγ
    _ = ∑ j : Fin (m + 1), g (planeLift γ (finRotate (m + 1) j).castSucc) :=
      Finset.sum_congr rfl (fun j _ =>
        vertexSimpleWalk_stepTurning_eq_neg_boundary_turn_right γ hγ hh hv hdistinct hright j)
    _ = ∑ v ∈ cellBoundaryVertices cells, g v :=
      vertexSimpleWalk_sum_endpoint_eq_sum_boundaryVertices γ hγ hh hv hdistinct g
    _ = -∑ v ∈ cellBoundaryVertices cells,
          directionPairTurning (cellBoundaryIncoming cells v.1 v.2)
            (cellBoundaryOutgoing cells v.1 v.2) :=
      Finset.sum_neg_distrib _

end Ising2DLambda.KacWard
