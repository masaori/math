import Ising2DLambda.KacWard.RightRayVerticalCrossingCount
import Ising2DLambda.KacWard.DirectedWindingNumbers
import Ising2DLambda.NecSuf.KacWard.OddRayInteriorCells

namespace Ising2DLambda.KacWard

/-- The interior cells of an actual zero-winding closed walk. -/
def oddRayInteriorCellsOfWalk {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (_hh : horizontalDirectedWindingNumber γ = 0)
    (_hv : verticalDirectedWindingNumber γ = 0) : Set (ℤ × ℤ) :=
  {p | Odd (rightRayVerticalCrossingCount γ hγ p.1 p.2)}

theorem oddRayInteriorCellsOfWalk_eq_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0) :
    oddRayInteriorCellsOfWalk γ hγ hh hv =
      Ising2DLambda.NecSuf.KacWard.oddRayInteriorCells m (planeLift γ) := by
  ext p
  simp only [oddRayInteriorCellsOfWalk,
    Ising2DLambda.NecSuf.KacWard.oddRayInteriorCells, Set.mem_setOf_eq,
    rightRayVerticalCrossingCount_from_necSuf]

end Ising2DLambda.KacWard
