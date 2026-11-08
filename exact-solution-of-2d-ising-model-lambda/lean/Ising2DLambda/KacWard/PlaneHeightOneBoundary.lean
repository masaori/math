import Ising2DLambda.KacWard.PlaneDualRayHeightOneCellsFinite
import Ising2DLambda.KacWard.PlaneHeightOneHorizontalEdge
import Ising2DLambda.KacWard.PlaneHeightOneVerticalEdge
import Ising2DLambda.KacWard.PlaneCellBoundary
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- The finite set of height-one cells has exactly the prescribed edge boundary. -/
theorem planeHeightOne_boundary (edges : Finset GridEdge)
    (heven : ∀ r c : ℤ,
      ((if (false, (r, c)) ∈ edges then (1 : ZMod 2) else 0) +
        (if (false, (r, c - 1)) ∈ edges then 1 else 0) +
        (if (true, (r, c)) ∈ edges then 1 else 0) +
        (if (true, (r - 1, c)) ∈ edges then 1 else 0)) = 0) :
    ∃ cells : Finset GridCell,
      (∀ r c : ℤ, (r, c) ∈ cells ↔ planeDualRayHeight edges r c = 1) ∧
        planeCellBoundary cells = edges := by
  obtain ⟨cells, hcell⟩ := planeDualRayHeight_one_cells_finite edges heven
  refine ⟨cells, hcell, ?_⟩
  ext ⟨b, ⟨r, c⟩⟩
  cases b
  · exact planeHeightOne_horizontal_boundary edges heven cells hcell r c
  · have hb : (true, (r, c)) ∈ planeCellBoundary cells ↔
        (((r, c) ∈ cells ∧ (r, c - 1) ∉ cells) ∨
          ((r, c) ∉ cells ∧ (r, c - 1) ∈ cells)) := by
      simp only [planeCellBoundary, Finset.mem_filter, verticalEdge_mem_cellEdges_iff,
        ↓reduceIte]
      tauto
    rw [hb, hcell r c, hcell r (c - 1)]
    have h := planeHeightOne_vertical_edge edges r c
    tauto

end Ising2DLambda.KacWard
