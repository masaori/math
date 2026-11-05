import Ising2DLambda.KacWard.PlaneLiftEndpointWinding
import Ising2DLambda.KacWard.PlaneLiftIntegerBaseStep

namespace Ising2DLambda.KacWard

/-- The integer-indexed base of the actual lift has the winding endpoint. -/
theorem planeLiftIntegerBase_endpoint {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ) :
    planeLiftIntegerBase γ (m + 1) = planeLiftIntegerBase γ 0 +
      windingShift L (verticalDirectedWindingNumber γ)
        (horizontalDirectedWindingNumber γ) := by
  have hlast : Fin.ofNat (m + 2) (m + 1) = Fin.last (m + 1) := by
    apply Fin.ext
    simp [Fin.ofNat]
  have hzero : Fin.ofNat (m + 2) 0 = 0 := by
    apply Fin.ext
    simp [Fin.ofNat]
  have h := planeLift_endpoint_winding γ hγ
  simpa [planeLiftIntegerBase, windingShift, hlast, hzero] using h

end Ising2DLambda.KacWard
