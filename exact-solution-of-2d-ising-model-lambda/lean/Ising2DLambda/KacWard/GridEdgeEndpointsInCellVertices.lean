import Ising2DLambda.KacWard.CellCornerConnected
import Ising2DLambda.NecSuf.KacWard.GridEdgeEndpointsInCellVertices
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- Every endpoint of an edge supplied by a cell belongs to that cell's corners. -/
theorem gridEdgeEndpoints_subset_verticesOfCell (x : GridCell) (e : GridEdge)
    (he : e ∈ edgesOfCell x) :
    gridEdgeEndpoints e ⊆ verticesOfCell x := by
  rcases x with ⟨r, c⟩
  simp only [edgesOfCell, Finset.mem_insert, Finset.mem_singleton] at he
  rcases he with h | h | h | h <;> subst e <;>
    simp [gridEdgeEndpoints, verticesOfCell, Finset.insert_subset_iff]

/-- Every endpoint of a cell-set edge belongs to the cell-set vertex set. -/
theorem gridEdgeEndpoints_subset_cellVertices (cells : Finset GridCell)
    (e : GridEdge) (he : e ∈ cellEdges cells) :
    gridEdgeEndpoints e ⊆ cellVertices cells := by
  obtain ⟨x, hx, hxe⟩ := Finset.mem_biUnion.mp he
  exact (gridEdgeEndpoints_subset_verticesOfCell x e hxe).trans
    (Finset.subset_biUnion_of_mem verticesOfCell hx)

theorem gridEdgeEndpoints_subset_cellVertices_from_necSuf
    (cells : Finset GridCell) (e : GridEdge) (he : e ∈ cellEdges cells) :
    gridEdgeEndpoints e ⊆ cellVertices cells := by
  exact Ising2DLambda.NecSuf.KacWard.endpoints_subset_vertices_of_local_inclusion
    cells verticesOfCell edgesOfCell gridEdgeEndpoints
    gridEdgeEndpoints_subset_verticesOfCell e he

end Ising2DLambda.KacWard
