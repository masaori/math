import Ising2DLambda.KacWard.PlaneDualRayHeightOneCellsFinite
import Ising2DLambda.NecSuf.KacWard.PlaneDualRayHeightOneCellsFinite

namespace Ising2DLambda.KacWard

/-- The general finite-support argument specializes to the actual grid ray height. -/
theorem planeDualRayHeight_one_cells_finite_from_necSuf (edges : Finset GridEdge)
    (heven : ∀ r c : ℤ,
      ((if (false, (r, c)) ∈ edges then (1 : ZMod 2) else 0) +
        (if (false, (r, c - 1)) ∈ edges then 1 else 0) +
        (if (true, (r, c)) ∈ edges then 1 else 0) +
        (if (true, (r - 1, c)) ∈ edges then 1 else 0)) = 0) :
    ∃ cells : Finset GridCell, ∀ r c : ℤ,
      (r, c) ∈ cells ↔ planeDualRayHeight edges r c = 1 := by
  obtain ⟨cols, hcols⟩ := planeDualRayHeight_column_support edges heven
  exact Ising2DLambda.NecSuf.KacWard.binaryHeight_one_cells_finite
    (planeDualRayHeight edges) (edges.image (fun e => e.2.1)) cols
    (fun r c h => planeDualRayHeight_row_support edges r c h) hcols

end Ising2DLambda.KacWard
