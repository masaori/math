/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.GridEdgeEndpointsInCellVertices
import Ising2DLambda.NecSuf.KacWard.GridEdgeEndpointsInCellVertices

namespace Ising2DLambda.KacWard

theorem gridEdgeEndpoints_subset_cellVertices_from_necSuf
    (cells : Finset GridCell) (e : GridEdge) (he : e ∈ cellEdges cells) :
    gridEdgeEndpoints e ⊆ cellVertices cells := by
  exact Ising2DLambda.NecSuf.KacWard.endpoints_subset_vertices_of_local_inclusion
    cells verticesOfCell edgesOfCell gridEdgeEndpoints
    gridEdgeEndpoints_subset_verticesOfCell e he

end Ising2DLambda.KacWard
