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

/-- An eastward boundary edge leaving `(r,c)` enters `(r,c+1)` with the
same direction when the target has no diagonal cell contact. -/
theorem cellBoundary_east_outgoing_matches_next_incoming
    (cells : Finset GridCell) (r c : ℤ)
    (hsource : (r, c) ∈ cellBoundaryVertices cells)
    (htarget : (r, c + 1) ∈ cellBoundaryVertices cells)
    (hdiag₁ : ¬ ((r - 1, c) ∈ cells ∧ (r - 1, c + 1) ∉ cells ∧
      (r, c + 1) ∈ cells ∧ (r, c) ∉ cells))
    (hdiag₂ : ¬ ((r - 1, c) ∉ cells ∧ (r - 1, c + 1) ∈ cells ∧
      (r, c + 1) ∉ cells ∧ (r, c) ∈ cells))
    (hout : cellBoundaryOutgoing cells r c = 0) :
    cellBoundaryIncoming cells r (c + 1) = 0 := by
  have hleft := (cellBoundary_local_directions_selected_left cells r c hsource).2
  rw [hout] at hleft
  have hside : (r - 1, c) ∈ cells ∧ (r, c) ∉ cells := by simpa using hleft
  have hdiag₁' : ¬ ((r - 1, c + 1 - 1) ∈ cells ∧
      (r - 1, c + 1) ∉ cells ∧ (r, c + 1) ∈ cells ∧
      (r, c + 1 - 1) ∉ cells) := by simpa only [add_sub_cancel_right] using hdiag₁
  have hdiag₂' : ¬ ((r - 1, c + 1 - 1) ∉ cells ∧
      (r - 1, c + 1) ∈ cells ∧ (r, c + 1) ∉ cells ∧
      (r, c + 1 - 1) ∈ cells) := by simpa only [add_sub_cancel_right] using hdiag₂
  have hside' : (if (0 : Fin 4).val = 0 then
      (r - 1, c + 1 - 1) ∈ cells ∧ (r, c + 1 - 1) ∉ cells
      else if (0 : Fin 4).val = 1 then
        (r - 1, c + 1) ∈ cells ∧ (r - 1, c + 1 - 1) ∉ cells
      else if (0 : Fin 4).val = 2 then
        (r, c + 1) ∈ cells ∧ (r - 1, c + 1) ∉ cells
      else (r, c + 1 - 1) ∈ cells ∧ (r, c + 1) ∉ cells) := by
    simpa using hside
  have hunique := cellBoundary_incoming_unique cells r (c + 1) (0 : Fin 4)
    htarget hdiag₁' hdiag₂' hside'
  simpa using hunique.symm

/-- A westward boundary edge leaving `(r,c)` enters `(r,c-1)` with the
same direction when the target has no diagonal cell contact. -/
theorem cellBoundary_west_outgoing_matches_next_incoming
    (cells : Finset GridCell) (r c : ℤ)
    (hsource : (r, c) ∈ cellBoundaryVertices cells)
    (htarget : (r, c - 1) ∈ cellBoundaryVertices cells)
    (hdiag₁ : ¬ ((r - 1, c - 2) ∈ cells ∧ (r - 1, c - 1) ∉ cells ∧
      (r, c - 1) ∈ cells ∧ (r, c - 2) ∉ cells))
    (hdiag₂ : ¬ ((r - 1, c - 2) ∉ cells ∧ (r - 1, c - 1) ∈ cells ∧
      (r, c - 1) ∉ cells ∧ (r, c - 2) ∈ cells))
    (hout : cellBoundaryOutgoing cells r c = 2) :
    cellBoundaryIncoming cells r (c - 1) = 2 := by
  have hleft := (cellBoundary_local_directions_selected_left cells r c hsource).2
  rw [hout] at hleft
  have hside : (r, c - 1) ∈ cells ∧ (r - 1, c - 1) ∉ cells := by
    simpa [show (2 : ZMod 4) ≠ 0 by decide,
      show (2 : ZMod 4) ≠ 1 by decide] using hleft
  have hdiag₁' : ¬ ((r - 1, c - 1 - 1) ∈ cells ∧
      (r - 1, c - 1) ∉ cells ∧ (r, c - 1) ∈ cells ∧
      (r, c - 1 - 1) ∉ cells) := by convert hdiag₁ using 1 <;> ring
  have hdiag₂' : ¬ ((r - 1, c - 1 - 1) ∉ cells ∧
      (r - 1, c - 1) ∈ cells ∧ (r, c - 1) ∉ cells ∧
      (r, c - 1 - 1) ∈ cells) := by convert hdiag₂ using 1 <;> ring
  have hside' : (if (2 : Fin 4).val = 0 then
      (r - 1, c - 1 - 1) ∈ cells ∧ (r, c - 1 - 1) ∉ cells
      else if (2 : Fin 4).val = 1 then
        (r - 1, c - 1) ∈ cells ∧ (r - 1, c - 1 - 1) ∉ cells
      else if (2 : Fin 4).val = 2 then
        (r, c - 1) ∈ cells ∧ (r - 1, c - 1) ∉ cells
      else (r, c - 1 - 1) ∈ cells ∧ (r, c - 1) ∉ cells) := by
    simpa using hside
  have hunique := cellBoundary_incoming_unique cells r (c - 1) (2 : Fin 4)
    htarget hdiag₁' hdiag₂' hside'
  simpa using hunique.symm

/-- A southward boundary edge leaving `(r,c)` enters `(r+1,c)` with the
same direction when the target has no diagonal cell contact. -/
theorem cellBoundary_south_outgoing_matches_next_incoming
    (cells : Finset GridCell) (r c : ℤ)
    (hsource : (r, c) ∈ cellBoundaryVertices cells)
    (htarget : (r + 1, c) ∈ cellBoundaryVertices cells)
    (hdiag₁ : ¬ ((r, c - 1) ∈ cells ∧ (r, c) ∉ cells ∧
      (r + 1, c) ∈ cells ∧ (r + 1, c - 1) ∉ cells))
    (hdiag₂ : ¬ ((r, c - 1) ∉ cells ∧ (r, c) ∈ cells ∧
      (r + 1, c) ∉ cells ∧ (r + 1, c - 1) ∈ cells))
    (hout : cellBoundaryOutgoing cells r c = 1) :
    cellBoundaryIncoming cells (r + 1) c = 1 := by
  have hleft := (cellBoundary_local_directions_selected_left cells r c hsource).2
  rw [hout] at hleft
  have hside : (r, c) ∈ cells ∧ (r, c - 1) ∉ cells := by
    simpa [show (1 : ZMod 4) ≠ 0 by decide] using hleft
  have hdiag₁' : ¬ ((r + 1 - 1, c - 1) ∈ cells ∧
      (r + 1 - 1, c) ∉ cells ∧ (r + 1, c) ∈ cells ∧
      (r + 1, c - 1) ∉ cells) := by simpa using hdiag₁
  have hdiag₂' : ¬ ((r + 1 - 1, c - 1) ∉ cells ∧
      (r + 1 - 1, c) ∈ cells ∧ (r + 1, c) ∉ cells ∧
      (r + 1, c - 1) ∈ cells) := by simpa using hdiag₂
  have hside' : (if (1 : Fin 4).val = 0 then
      (r + 1 - 1, c - 1) ∈ cells ∧ (r + 1, c - 1) ∉ cells
      else if (1 : Fin 4).val = 1 then
        (r + 1 - 1, c) ∈ cells ∧ (r + 1 - 1, c - 1) ∉ cells
      else if (1 : Fin 4).val = 2 then
        (r + 1, c) ∈ cells ∧ (r + 1 - 1, c) ∉ cells
      else (r + 1, c - 1) ∈ cells ∧ (r + 1, c) ∉ cells) := by
    simpa using hside
  have hunique := cellBoundary_incoming_unique cells (r + 1) c (1 : Fin 4)
    htarget hdiag₁' hdiag₂' hside'
  simpa using hunique.symm

/-- A northward boundary edge leaving `(r,c)` enters `(r-1,c)` with the
same direction when the target has no diagonal cell contact. -/
theorem cellBoundary_north_outgoing_matches_next_incoming
    (cells : Finset GridCell) (r c : ℤ)
    (hsource : (r, c) ∈ cellBoundaryVertices cells)
    (htarget : (r - 1, c) ∈ cellBoundaryVertices cells)
    (hdiag₁ : ¬ ((r - 2, c - 1) ∈ cells ∧ (r - 2, c) ∉ cells ∧
      (r - 1, c) ∈ cells ∧ (r - 1, c - 1) ∉ cells))
    (hdiag₂ : ¬ ((r - 2, c - 1) ∉ cells ∧ (r - 2, c) ∈ cells ∧
      (r - 1, c) ∉ cells ∧ (r - 1, c - 1) ∈ cells))
    (hout : cellBoundaryOutgoing cells r c = 3) :
    cellBoundaryIncoming cells (r - 1) c = 3 := by
  have hleft := (cellBoundary_local_directions_selected_left cells r c hsource).2
  rw [hout] at hleft
  have hside : (r - 1, c - 1) ∈ cells ∧ (r - 1, c) ∉ cells := by
    simpa [show (3 : ZMod 4) ≠ 0 by decide,
      show (3 : ZMod 4) ≠ 1 by decide,
      show (3 : ZMod 4) ≠ 2 by decide] using hleft
  have hdiag₁' : ¬ ((r - 1 - 1, c - 1) ∈ cells ∧
      (r - 1 - 1, c) ∉ cells ∧ (r - 1, c) ∈ cells ∧
      (r - 1, c - 1) ∉ cells) := by convert hdiag₁ using 1 <;> ring
  have hdiag₂' : ¬ ((r - 1 - 1, c - 1) ∉ cells ∧
      (r - 1 - 1, c) ∈ cells ∧ (r - 1, c) ∉ cells ∧
      (r - 1, c - 1) ∈ cells) := by convert hdiag₂ using 1 <;> ring
  have hside' : (if (3 : Fin 4).val = 0 then
      (r - 1 - 1, c - 1) ∈ cells ∧ (r - 1, c - 1) ∉ cells
      else if (3 : Fin 4).val = 1 then
        (r - 1 - 1, c) ∈ cells ∧ (r - 1 - 1, c - 1) ∉ cells
      else if (3 : Fin 4).val = 2 then
        (r - 1, c) ∈ cells ∧ (r - 1 - 1, c) ∉ cells
      else (r - 1, c - 1) ∈ cells ∧ (r - 1, c) ∉ cells) := by
    simpa using hside
  have hunique := cellBoundary_incoming_unique cells (r - 1) c (3 : Fin 4)
    htarget hdiag₁' hdiag₂' hside'
  simpa using hunique.symm

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
