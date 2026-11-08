import Ising2DLambda.KacWard.PlaneCellBoundary
import Ising2DLambda.NecSuf.KacWard.PlaneCellBoundary

namespace Ising2DLambda.KacWard

/-- The concrete boundary statement follows from the order-only exposed-side proof. -/
theorem planeCellBoundary_nonempty_from_necSuf (cells : Finset GridCell)
    (hcells : cells.Nonempty) : (planeCellBoundary cells).Nonempty := by
  obtain ⟨r, c, hcell, habove⟩ :=
    Ising2DLambda.NecSuf.KacWard.finite_cells_have_exposed_upper_side cells hcells
  exact ⟨(false, (r + 1, c)), planeCellBoundary_upper_edge cells r c hcell habove⟩

end Ising2DLambda.KacWard
