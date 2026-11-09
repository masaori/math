import Ising2DLambda.KacWard.PlaneCellBoundary
import Ising2DLambda.NecSuf.KacWard.PlaneCellBoundaryInjective

namespace Ising2DLambda.KacWard

open scoped symmDiff

/-- A finite planar cell set is determined by its boundary edges. -/
theorem planeCellBoundary_injective : Function.Injective planeCellBoundary := by
  intro cells₁ cells₂ hboundary
  have hzero : planeCellBoundary (cells₁ ∆ cells₂) = ∅ := by
    rw [planeCellBoundary_symmDiff, hboundary]
    simp
  have hcells : cells₁ ∆ cells₂ = ∅ := by
    by_contra hne
    have hnon : (cells₁ ∆ cells₂).Nonempty := Finset.nonempty_iff_ne_empty.mpr hne
    exact (planeCellBoundary_nonempty _ hnon).ne_empty hzero
  exact Finset.symmDiff_eq_empty.mp hcells

/-- The abstract proof specializes to the planar cell boundary. -/
theorem planeCellBoundary_injective_from_necSuf : Function.Injective planeCellBoundary := by
  apply Ising2DLambda.NecSuf.KacWard.boundary_injective_of_symmetric_difference
  · exact planeCellBoundary_symmDiff
  · intro cells hboundary
    by_contra hne
    have hnon : cells.Nonempty := Finset.nonempty_iff_ne_empty.mpr hne
    exact (planeCellBoundary_nonempty cells hnon).ne_empty hboundary

end Ising2DLambda.KacWard
