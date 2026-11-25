/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.OddRayInteriorCells
import Ising2DLambda.NecSuf.KacWard.OddRayInteriorCells

namespace Ising2DLambda.KacWard

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
