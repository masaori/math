import Ising2DLambda.KacWard.CellCornerConnected
import Ising2DLambda.KacWard.CellVertexIncidenceCount
import Ising2DLambda.KacWard.PlaneCellBoundary
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- The endpoints of the edge boundary of a finite set of cells. -/
def cellBoundaryVertices (cells : Finset GridCell) : Finset GridVertex :=
  (planeCellBoundary cells).biUnion gridEdgeEndpoints

private theorem gridEdgeEndpoints_mem_iff (e : GridEdge) (r c : ℤ) :
    (r, c) ∈ gridEdgeEndpoints e ↔
      e = (false, (r, c)) ∨ e = (false, (r, c - 1)) ∨
      e = (true, (r, c)) ∨ e = (true, (r - 1, c)) := by
  rcases e with ⟨b, ⟨i, j⟩⟩
  cases b <;> simp [gridEdgeEndpoints, Prod.mk.injEq] <;> omega

private theorem horizontal_boundary_iff (cells : Finset GridCell) (r c : ℤ) :
    (false, (r, c)) ∈ planeCellBoundary cells ↔
      ¬ ((r, c) ∈ cells ↔ (r - 1, c) ∈ cells) := by
  simp only [planeCellBoundary, Finset.mem_filter, horizontalEdge_mem_cellEdges_iff,
    Bool.false_eq_true, ↓reduceIte]
  tauto

private theorem vertical_boundary_iff (cells : Finset GridCell) (r c : ℤ) :
    (true, (r, c)) ∈ planeCellBoundary cells ↔
      ¬ ((r, c) ∈ cells ↔ (r, c - 1) ∈ cells) := by
  simp only [planeCellBoundary, Finset.mem_filter, verticalEdge_mem_cellEdges_iff,
    ↓reduceIte]
  tauto

/-- An actual boundary vertex meets one, two, or three selected cells. -/
theorem cellBoundaryVertices_iff_incidence_one_to_three
    (cells : Finset GridCell) (r c : ℤ) :
    (r, c) ∈ cellBoundaryVertices cells ↔
      vertexCellIncidenceCount cells (r, c) = 1 ∨
      vertexCellIncidenceCount cells (r, c) = 2 ∨
      vertexCellIncidenceCount cells (r, c) = 3 := by
  have hboundary : (r, c) ∈ cellBoundaryVertices cells ↔
      (false, (r, c)) ∈ planeCellBoundary cells ∨
      (false, (r, c - 1)) ∈ planeCellBoundary cells ∨
      (true, (r, c)) ∈ planeCellBoundary cells ∨
      (true, (r - 1, c)) ∈ planeCellBoundary cells := by
    constructor
    · intro h
      obtain ⟨e, he, hv⟩ := Finset.mem_biUnion.mp h
      rcases (gridEdgeEndpoints_mem_iff e r c).mp hv with h | h | h | h
      · exact Or.inl (h ▸ he)
      · exact Or.inr (Or.inl (h ▸ he))
      · exact Or.inr (Or.inr (Or.inl (h ▸ he)))
      · exact Or.inr (Or.inr (Or.inr (h ▸ he)))
    · intro h
      rcases h with h | h | h | h
      · exact Finset.mem_biUnion.mpr ⟨_, h, (gridEdgeEndpoints_mem_iff _ r c).2 (Or.inl rfl)⟩
      · exact Finset.mem_biUnion.mpr ⟨_, h, (gridEdgeEndpoints_mem_iff _ r c).2 (Or.inr (Or.inl rfl))⟩
      · exact Finset.mem_biUnion.mpr ⟨_, h, (gridEdgeEndpoints_mem_iff _ r c).2 (Or.inr (Or.inr (Or.inl rfl)))⟩
      · exact Finset.mem_biUnion.mpr ⟨_, h, (gridEdgeEndpoints_mem_iff _ r c).2 (Or.inr (Or.inr (Or.inr rfl)))⟩
  rw [hboundary, horizontal_boundary_iff, horizontal_boundary_iff,
    vertical_boundary_iff, vertical_boundary_iff]
  exact (vertexCellIncidenceCount_boundary_criterion cells r c).symm

end Ising2DLambda.KacWard
