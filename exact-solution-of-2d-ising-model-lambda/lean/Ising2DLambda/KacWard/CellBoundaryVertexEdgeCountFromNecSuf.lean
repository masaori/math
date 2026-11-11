import Ising2DLambda.KacWard.CellBoundaryVertexEdgeCount
import Ising2DLambda.NecSuf.KacWard.BoundaryVertexEdgeCount
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- The concrete cell-boundary count is the specialization of the finite
incidence theorem to encoded grid edges and their two endpoints. -/
theorem cellBoundaryVertices_card_eq_boundary_card_from_necSuf
    (cells : Finset GridCell)
    (hdegree : ∀ v ∈ cellBoundaryVertices cells,
      ((planeCellBoundary cells).filter fun e => v ∈ gridEdgeEndpoints e).card = 2) :
    (cellBoundaryVertices cells).card = (planeCellBoundary cells).card := by
  apply Ising2DLambda.NecSuf.KacWard.boundary_vertex_edge_count_necSuf
    (planeCellBoundary cells) (cellBoundaryVertices cells) gridEdgeEndpoints
  · intro ⟨b, ⟨r, c⟩⟩ he
    cases b <;> simp [gridEdgeEndpoints]
  · intro e he v hv
    exact Finset.mem_biUnion.mpr ⟨e, he, hv⟩
  · exact hdegree

end Ising2DLambda.KacWard
