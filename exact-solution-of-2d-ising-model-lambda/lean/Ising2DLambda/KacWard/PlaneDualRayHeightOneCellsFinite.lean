import Ising2DLambda.KacWard.PlaneDualRayHeightRowSupport
import Ising2DLambda.KacWard.PlaneDualRayHeightColumnSupport
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- The height-one cells are a subset of a finite product of supported rows and columns. -/
theorem planeDualRayHeight_one_cells_finite (edges : Finset GridEdge)
    (heven : ∀ r c : ℤ,
      ((if (false, (r, c)) ∈ edges then (1 : ZMod 2) else 0) +
        (if (false, (r, c - 1)) ∈ edges then 1 else 0) +
        (if (true, (r, c)) ∈ edges then 1 else 0) +
        (if (true, (r - 1, c)) ∈ edges then 1 else 0)) = 0) :
    ∃ cells : Finset GridCell, ∀ r c : ℤ,
      (r, c) ∈ cells ↔ planeDualRayHeight edges r c = 1 := by
  obtain ⟨cols, hcols⟩ := planeDualRayHeight_column_support edges heven
  let rows := edges.image (fun e => e.2.1)
  refine ⟨(rows.product cols).filter (fun p => planeDualRayHeight edges p.1 p.2 = 1), ?_⟩
  intro r c
  constructor
  · intro h
    exact (Finset.mem_filter.mp h).2
  · intro h
    apply Finset.mem_filter.mpr
    constructor
    · exact Finset.mem_product.mpr
        ⟨planeDualRayHeight_row_support edges r c h, hcols r c h⟩
    · exact h

end Ising2DLambda.KacWard
