import Ising2DLambda.KacWard.CellBoundaryVertices
import Ising2DLambda.KacWard.PlaneProjectionCyclicTurning
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

set_option maxHeartbeats 2000000

/-- Direction entering a boundary vertex with the selected cells on the left. -/
def cellBoundaryIncoming (cells : Finset GridCell) (r c : ℤ) : ZMod 4 :=
  if (r, c) ∈ cells ∧ (r - 1, c) ∉ cells then 2
  else if (r, c - 1) ∈ cells ∧ (r, c) ∉ cells then 3
  else if (r - 1, c - 1) ∈ cells ∧ (r, c - 1) ∉ cells then 0
  else 1

/-- Direction leaving the same boundary vertex. -/
def cellBoundaryOutgoing (cells : Finset GridCell) (r c : ℤ) : ZMod 4 :=
  if (r - 1, c) ∈ cells ∧ (r, c) ∉ cells then 0
  else if (r, c) ∈ cells ∧ (r, c - 1) ∉ cells then 1
  else if (r, c - 1) ∈ cells ∧ (r - 1, c - 1) ∉ cells then 2
  else 3

/-- The grid edge on which an incoming direction reaches a vertex. -/
def cellBoundaryIncomingEdge (r c : ℤ) (d : ZMod 4) : GridEdge :=
  if d.val = 0 then (false, (r, c - 1))
  else if d.val = 1 then (true, (r - 1, c))
  else if d.val = 2 then (false, (r, c))
  else (true, (r, c))

/-- The grid edge on which an outgoing direction leaves a vertex. -/
def cellBoundaryOutgoingEdge (r c : ℤ) (d : ZMod 4) : GridEdge :=
  if d.val = 0 then (false, (r, c))
  else if d.val = 1 then (true, (r, c))
  else if d.val = 2 then (false, (r, c - 1))
  else (true, (r - 1, c))

/-- Both directions selected by the four-cell rule follow exposed edges. -/
theorem cellBoundary_local_directions_mem (cells : Finset GridCell) (r c : ℤ)
    (hv : (r, c) ∈ cellBoundaryVertices cells) :
    cellBoundaryIncomingEdge r c (cellBoundaryIncoming cells r c) ∈
        planeCellBoundary cells ∧
      cellBoundaryOutgoingEdge r c (cellBoundaryOutgoing cells r c) ∈
        planeCellBoundary cells := by
  have hcount := (cellBoundaryVertices_iff_incidence_one_to_three cells r c).mp hv
  rw [vertexCellIncidenceCount_quadrants] at hcount
  by_cases ha : (r - 1, c - 1) ∈ cells <;>
    by_cases hb : (r - 1, c) ∈ cells <;>
    by_cases hc : (r, c) ∈ cells <;>
    by_cases hd : (r, c - 1) ∈ cells <;>
    simp_all [cellBoundaryIncomingEdge, cellBoundaryOutgoingEdge,
      cellBoundaryIncoming, cellBoundaryOutgoing, planeCellBoundary,
      horizontalEdge_mem_cellEdges_iff, verticalEdge_mem_cellEdges_iff,
      ZMod.val_one_eq_one_mod, ZMod.val_two_eq_two_mod, ZMod.val_ofNat,
      show (1 : ZMod 4) ≠ 0 by decide,
      show (2 : ZMod 4) ≠ 0 by decide,
      show (2 : ZMod 4) ≠ 1 by decide,
      show (3 : ZMod 4) ≠ 0 by decide,
      show (3 : ZMod 4) ≠ 1 by decide,
      show (3 : ZMod 4) ≠ 2 by decide]

/-- The four-cell direction table orients both exposed edges with selected
cells on their left and unselected cells on their right. -/
theorem cellBoundary_local_directions_selected_left (cells : Finset GridCell) (r c : ℤ)
    (hv : (r, c) ∈ cellBoundaryVertices cells) :
    (if cellBoundaryIncoming cells r c = 0 then
        (r - 1, c - 1) ∈ cells ∧ (r, c - 1) ∉ cells
      else if cellBoundaryIncoming cells r c = 1 then
        (r - 1, c) ∈ cells ∧ (r - 1, c - 1) ∉ cells
      else if cellBoundaryIncoming cells r c = 2 then
        (r, c) ∈ cells ∧ (r - 1, c) ∉ cells
      else (r, c - 1) ∈ cells ∧ (r, c) ∉ cells) ∧
    (if cellBoundaryOutgoing cells r c = 0 then
        (r - 1, c) ∈ cells ∧ (r, c) ∉ cells
      else if cellBoundaryOutgoing cells r c = 1 then
        (r, c) ∈ cells ∧ (r, c - 1) ∉ cells
      else if cellBoundaryOutgoing cells r c = 2 then
        (r, c - 1) ∈ cells ∧ (r - 1, c - 1) ∉ cells
      else (r - 1, c - 1) ∈ cells ∧ (r - 1, c) ∉ cells) := by
  have hcount := (cellBoundaryVertices_iff_incidence_one_to_three cells r c).mp hv
  rw [vertexCellIncidenceCount_quadrants] at hcount
  by_cases ha : (r - 1, c - 1) ∈ cells <;>
    by_cases hb : (r - 1, c) ∈ cells <;>
    by_cases hc : (r, c) ∈ cells <;>
    by_cases hd : (r, c - 1) ∈ cells <;>
    simp_all [cellBoundaryIncoming, cellBoundaryOutgoing] <;> decide

/-- At a non-diagonal boundary vertex, any entering direction with an interior
cell on its left is the direction selected by the local four-cell rule. -/
theorem cellBoundary_incoming_unique (cells : Finset GridCell) (r c : ℤ)
    (direction : Fin 4)
    (hv : (r, c) ∈ cellBoundaryVertices cells)
    (hdiag₁ : ¬ ((r - 1, c - 1) ∈ cells ∧ (r - 1, c) ∉ cells ∧
      (r, c) ∈ cells ∧ (r, c - 1) ∉ cells))
    (hdiag₂ : ¬ ((r - 1, c - 1) ∉ cells ∧ (r - 1, c) ∈ cells ∧
      (r, c) ∉ cells ∧ (r, c - 1) ∈ cells))
    (hleft : if direction.val = 0 then
        (r - 1, c - 1) ∈ cells ∧ (r, c - 1) ∉ cells
      else if direction.val = 1 then
        (r - 1, c) ∈ cells ∧ (r - 1, c - 1) ∉ cells
      else if direction.val = 2 then
        (r, c) ∈ cells ∧ (r - 1, c) ∉ cells
      else (r, c - 1) ∈ cells ∧ (r, c) ∉ cells) :
    (direction.val : ZMod 4) = cellBoundaryIncoming cells r c := by
  have hcount := (cellBoundaryVertices_iff_incidence_one_to_three cells r c).mp hv
  rw [vertexCellIncidenceCount_quadrants] at hcount
  fin_cases direction <;>
    by_cases ha : (r - 1, c - 1) ∈ cells <;>
    by_cases hb : (r - 1, c) ∈ cells <;>
    by_cases hc : (r, c) ∈ cells <;>
    by_cases hd : (r, c - 1) ∈ cells <;>
    simp_all [cellBoundaryIncoming]

/-- The corresponding statement for a direction leaving the vertex. -/
theorem cellBoundary_outgoing_unique (cells : Finset GridCell) (r c : ℤ)
    (direction : Fin 4)
    (hv : (r, c) ∈ cellBoundaryVertices cells)
    (hdiag₁ : ¬ ((r - 1, c - 1) ∈ cells ∧ (r - 1, c) ∉ cells ∧
      (r, c) ∈ cells ∧ (r, c - 1) ∉ cells))
    (hdiag₂ : ¬ ((r - 1, c - 1) ∉ cells ∧ (r - 1, c) ∈ cells ∧
      (r, c) ∉ cells ∧ (r, c - 1) ∈ cells))
    (hleft : if direction.val = 0 then
        (r - 1, c) ∈ cells ∧ (r, c) ∉ cells
      else if direction.val = 1 then
        (r, c) ∈ cells ∧ (r, c - 1) ∉ cells
      else if direction.val = 2 then
        (r, c - 1) ∈ cells ∧ (r - 1, c - 1) ∉ cells
      else (r - 1, c - 1) ∈ cells ∧ (r - 1, c) ∉ cells) :
    (direction.val : ZMod 4) = cellBoundaryOutgoing cells r c := by
  have hcount := (cellBoundaryVertices_iff_incidence_one_to_three cells r c).mp hv
  rw [vertexCellIncidenceCount_quadrants] at hcount
  fin_cases direction <;>
    by_cases ha : (r - 1, c - 1) ∈ cells <;>
    by_cases hb : (r - 1, c) ∈ cells <;>
    by_cases hc : (r, c) ∈ cells <;>
    by_cases hd : (r, c - 1) ∈ cells <;>
    simp_all [cellBoundaryOutgoing]

/-- The entering and leaving boundary edges at a non-diagonal vertex are distinct. -/
theorem cellBoundary_local_edges_ne (cells : Finset GridCell) (r c : ℤ)
    (hv : (r, c) ∈ cellBoundaryVertices cells)
    (hdiag₁ : ¬ ((r - 1, c - 1) ∈ cells ∧ (r - 1, c) ∉ cells ∧
      (r, c) ∈ cells ∧ (r, c - 1) ∉ cells))
    (hdiag₂ : ¬ ((r - 1, c - 1) ∉ cells ∧ (r - 1, c) ∈ cells ∧
      (r, c) ∉ cells ∧ (r, c - 1) ∈ cells)) :
    cellBoundaryIncomingEdge r c (cellBoundaryIncoming cells r c) ≠
      cellBoundaryOutgoingEdge r c (cellBoundaryOutgoing cells r c) := by
  have hcount := (cellBoundaryVertices_iff_incidence_one_to_three cells r c).mp hv
  rw [vertexCellIncidenceCount_quadrants] at hcount
  by_cases ha : (r - 1, c - 1) ∈ cells <;>
    by_cases hb : (r - 1, c) ∈ cells <;>
    by_cases hc : (r, c) ∈ cells <;>
    by_cases hd : (r, c - 1) ∈ cells <;>
    simp_all [cellBoundaryIncomingEdge, cellBoundaryOutgoingEdge,
      cellBoundaryIncoming, cellBoundaryOutgoing,
      ZMod.val_one_eq_one_mod, ZMod.val_two_eq_two_mod, ZMod.val_ofNat,
      show (1 : ZMod 4) ≠ 0 by decide,
      show (2 : ZMod 4) ≠ 0 by decide,
      show (2 : ZMod 4) ≠ 1 by decide,
      show (3 : ZMod 4) ≠ 0 by decide,
      show (3 : ZMod 4) ≠ 1 by decide,
      show (3 : ZMod 4) ≠ 2 by decide] <;> omega

/-- The local turn at a boundary vertex is minus one, zero, or one according
to whether one, two, or three cells meet there. -/
theorem cellBoundary_turn_by_incidence (cells : Finset GridCell) (r c : ℤ)
    (hv : (r, c) ∈ cellBoundaryVertices cells)
    (hdiag₁ : ¬ ((r - 1, c - 1) ∈ cells ∧ (r - 1, c) ∉ cells ∧
      (r, c) ∈ cells ∧ (r, c - 1) ∉ cells))
    (hdiag₂ : ¬ ((r - 1, c - 1) ∉ cells ∧ (r - 1, c) ∈ cells ∧
      (r, c) ∉ cells ∧ (r, c - 1) ∈ cells)) :
    directionPairTurning (cellBoundaryIncoming cells r c)
      (cellBoundaryOutgoing cells r c) =
      if vertexCellIncidenceCount cells (r, c) = 1 then -1
      else if vertexCellIncidenceCount cells (r, c) = 3 then 1 else 0 := by
  have hcount := (cellBoundaryVertices_iff_incidence_one_to_three cells r c).mp hv
  rw [vertexCellIncidenceCount_quadrants] at hcount ⊢
  by_cases ha : (r - 1, c - 1) ∈ cells <;>
    by_cases hb : (r - 1, c) ∈ cells <;>
    by_cases hc : (r, c) ∈ cells <;>
    by_cases hd : (r, c - 1) ∈ cells <;>
    simp_all [cellBoundaryIncoming, cellBoundaryOutgoing, directionPairTurning] <;> decide

end Ising2DLambda.KacWard
