/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.PlaneCellBoundaryInjective
import Ising2DLambda.NecSuf.KacWard.PlaneCellBoundaryInjective

namespace Ising2DLambda.KacWard

open scoped symmDiff

/-- The abstract proof specializes to the planar cell boundary. -/
theorem planeCellBoundary_injective_from_necSuf : Function.Injective planeCellBoundary := by
  apply Ising2DLambda.NecSuf.KacWard.boundary_injective_of_symmetric_difference
  · exact planeCellBoundary_symmDiff
  · intro cells hboundary
    by_contra hne
    have hnon : cells.Nonempty := Finset.nonempty_iff_ne_empty.mpr hne
    exact (planeCellBoundary_nonempty cells hnon).ne_empty hboundary

end Ising2DLambda.KacWard
