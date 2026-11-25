import Ising2DLambda.KacWard.RightRayVerticalCrossingCount
import Ising2DLambda.KacWard.DirectedWindingNumbers

namespace Ising2DLambda.KacWard

/-- The interior cells of an actual zero-winding closed walk. -/
def oddRayInteriorCellsOfWalk {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (_hh : horizontalDirectedWindingNumber γ = 0)
    (_hv : verticalDirectedWindingNumber γ = 0) : Set (ℤ × ℤ) :=
  {p | Odd (rightRayVerticalCrossingCount γ hγ p.1 p.2)}

end Ising2DLambda.KacWard
