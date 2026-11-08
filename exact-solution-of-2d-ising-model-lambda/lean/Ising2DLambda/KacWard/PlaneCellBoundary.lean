import Ising2DLambda.KacWard.CellEdgeIncidence
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- An edge belongs to the boundary when exactly one of its incident cells is selected. -/
def planeCellBoundary (cells : Finset GridCell) : Finset GridEdge :=
  (cellEdges cells).filter fun e =>
    if e.1 then
      ((e.2.1, e.2.2) ∈ cells ∧ (e.2.1, e.2.2 - 1) ∉ cells) ∨
        ((e.2.1, e.2.2) ∉ cells ∧ (e.2.1, e.2.2 - 1) ∈ cells)
    else
      ((e.2.1, e.2.2) ∈ cells ∧ (e.2.1 - 1, e.2.2) ∉ cells) ∨
        ((e.2.1, e.2.2) ∉ cells ∧ (e.2.1 - 1, e.2.2) ∈ cells)

/-- The upper edge of a cell in a maximum occupied row is exposed. -/
theorem planeCellBoundary_upper_edge (cells : Finset GridCell) (r c : ℤ)
    (hcell : (r, c) ∈ cells)
    (habove : (r + 1, c) ∉ cells) :
    (false, (r + 1, c)) ∈ planeCellBoundary cells := by
  have hedge : (false, (r + 1, c)) ∈ cellEdges cells := by
    apply (horizontalEdge_mem_cellEdges_iff cells (r + 1) c).2
    right
    simpa using hcell
  simp [planeCellBoundary, hedge, habove, hcell]

/-- A nonempty finite set of planar cells has a nonempty edge boundary. -/
theorem planeCellBoundary_nonempty (cells : Finset GridCell)
    (hcells : cells.Nonempty) : (planeCellBoundary cells).Nonempty := by
  let rows : Finset ℤ := cells.image Prod.fst
  have hrows : rows.Nonempty := hcells.image _
  let r : ℤ := rows.max' hrows
  have hr : r ∈ rows := Finset.max'_mem rows hrows
  obtain ⟨⟨s, c⟩, hcell, hs⟩ := Finset.mem_image.mp hr
  have hsr : s = r := by simpa [r] using hs
  subst s
  have hmax : ∀ t d, (t, d) ∈ cells → t ≤ r := by
    intro t d htd
    exact Finset.le_max' rows t (Finset.mem_image.mpr ⟨(t, d), htd, rfl⟩)
  have habove : (r + 1, c) ∉ cells := by
    intro h
    have := hmax (r + 1) c h
    omega
  exact ⟨(false, (r + 1, c)), planeCellBoundary_upper_edge cells r c hcell habove⟩

end Ising2DLambda.KacWard
