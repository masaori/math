/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.CellVertexGraph
import Ising2DLambda.NecSuf.KacWard.CellVertexGraph

namespace Ising2DLambda.KacWard

theorem cellGraphEdge_incident_iff_from_necSuf (cells : Finset GridCell)
    (e : cellEdges cells) (v : cellVertices cells) :
    v ∈ cellGraphEdge cells e ↔ v.1 ∈ gridEdgeEndpoints e.1 := by
  rw [← cellGraphEdge_endpointSet]
  exact Ising2DLambda.NecSuf.KacWard.endpoint_incidence_iff_of_subtype
    (cellGraphEdge cells e) v

theorem cellVertexGraph_edgeFinset_from_necSuf (cells : Finset GridCell) :
    (cellVertexGraph cells).edgeFinset =
      (cellEdges cells).attach.image (cellGraphEdge cells) := by
  have h := Ising2DLambda.NecSuf.KacWard.finiteGraph_edgeSet_of_endpoint_image
    (cellGraphEdge cells) (cellGraphEdge_not_diag cells)
  ext edge
  rw [SimpleGraph.mem_edgeFinset]
  simpa [cellVertexGraph] using Set.ext_iff.mp h edge

end Ising2DLambda.KacWard
