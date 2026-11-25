import Ising2DLambda.KacWard.PlaneCellBoundary

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

end Ising2DLambda.KacWard
