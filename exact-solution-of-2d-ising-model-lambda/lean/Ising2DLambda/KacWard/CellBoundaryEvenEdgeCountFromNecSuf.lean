/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.CellBoundaryEvenEdgeCount
import Ising2DLambda.KacWard.CellBoundaryEvenEdgeBijectionFromNecSuf
import Ising2DLambda.NecSuf.KacWard.CellBoundaryEvenEdgeCount

namespace Ising2DLambda.KacWard

/-- The abstract count specializes to the planar cell boundary bijection. -/
theorem cellBoundary_evenEdge_count_from_necSuf (cells : Finset GridCell)
    (hconnected : EdgeConnectedCellSet (↑cells : Set GridCell)ᶜ) :
    Nat.card {E : Finset GridEdge // IsEvenCellEdgeSubset cells E} =
      2 ^ cells.card := by
  exact Ising2DLambda.NecSuf.KacWard.boundary_even_edge_count
    cells (IsEvenCellEdgeSubset cells) _
    (cellBoundary_evenEdge_bijective_from_necSuf cells hconnected)

end Ising2DLambda.KacWard
