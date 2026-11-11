import Ising2DLambda.KacWard.CellBoundaryVertices
import Ising2DLambda.KacWard.PlaneProjectionCyclicTurning
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

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
