import Ising2DLambda.KacWard.GridEdgeEndpointsInCellVertices
import Ising2DLambda.NecSuf.KacWard.CellVertexGraph
import Mathlib.Combinatorics.SimpleGraph.Finite
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- The cell edges as two-point subsets of the integer lattice. -/
def cellEdgeEndpointSets (cells : Finset GridCell) : Finset (Finset GridVertex) :=
  (cellEdges cells).image gridEdgeEndpoints

/-- The two endpoints of a cell edge, regarded as vertices of the cell graph. -/
def cellGraphEdge (cells : Finset GridCell) (e : cellEdges cells) :
    Sym2 (cellVertices cells) := by
  have h := gridEdgeEndpoints_subset_cellVertices cells e.1 e.2
  rcases e with ⟨⟨b, r, c⟩, he⟩
  cases b
  · exact s(⟨(r, c), h (by simp [gridEdgeEndpoints])⟩,
      ⟨(r, c + 1), h (by simp [gridEdgeEndpoints])⟩)
  · exact s(⟨(r, c), h (by simp [gridEdgeEndpoints])⟩,
      ⟨(r + 1, c), h (by simp [gridEdgeEndpoints])⟩)

theorem cellGraphEdge_endpointSet (cells : Finset GridCell) (e : cellEdges cells) :
    (cellGraphEdge cells e).toFinset.image Subtype.val = gridEdgeEndpoints e.1 := by
  rcases e with ⟨⟨b, r, c⟩, he⟩
  cases b <;> simp [cellGraphEdge, Sym2.toFinset_mk_eq, gridEdgeEndpoints]

/-- The simple graph whose vertices are precisely the corners of the cells. -/
def cellVertexGraph (cells : Finset GridCell) : SimpleGraph (cellVertices cells) :=
  SimpleGraph.fromEdgeSet
    (↑((cellEdges cells).attach.image (cellGraphEdge cells)) : Set (Sym2 (cellVertices cells)))

theorem cellGraphEdge_not_diag (cells : Finset GridCell) (e : cellEdges cells) :
    ¬ (cellGraphEdge cells e).IsDiag := by
  rcases e with ⟨⟨b, r, c⟩, he⟩
  cases b <;> simp [cellGraphEdge, Sym2.mk_isDiag_iff]

noncomputable instance (cells : Finset GridCell) :
    Fintype (cellVertexGraph cells).edgeSet := Fintype.ofFinite _

/-- The graph edges are exactly the image of the coordinate encoded grid edges. -/
theorem cellVertexGraph_edgeFinset (cells : Finset GridCell) :
    (cellVertexGraph cells).edgeFinset =
      (cellEdges cells).attach.image (cellGraphEdge cells) := by
  ext e
  simp only [SimpleGraph.mem_edgeFinset, cellVertexGraph,
    SimpleGraph.edgeSet_fromEdgeSet, Set.mem_sdiff, Finset.mem_coe,
    Sym2.mem_diagSet]
  constructor
  · intro h
    exact h.1
  · intro h
    rcases Finset.mem_image.mp h with ⟨g, _, rfl⟩
    exact ⟨Finset.mem_image.mpr ⟨g, Finset.mem_attach _ _, rfl⟩,
      cellGraphEdge_not_diag cells g⟩

theorem cellVertexGraph_edgeFinset_from_necSuf (cells : Finset GridCell) :
    (cellVertexGraph cells).edgeFinset =
      (cellEdges cells).attach.image (cellGraphEdge cells) := by
  have h := Ising2DLambda.NecSuf.KacWard.finiteGraph_edgeSet_of_endpoint_image
    (cellGraphEdge cells) (cellGraphEdge_not_diag cells)
  ext edge
  rw [SimpleGraph.mem_edgeFinset]
  simpa [cellVertexGraph] using Set.ext_iff.mp h edge

theorem cellVertexGraph_edge_endpoint_image (cells : Finset GridCell) :
    (cellVertexGraph cells).edgeFinset.image
      (fun edge => edge.toFinset.image Subtype.val) = cellEdgeEndpointSets cells := by
  rw [cellVertexGraph_edgeFinset]
  ext edge
  constructor
  · intro h
    obtain ⟨pair, hpair, rfl⟩ := Finset.mem_image.mp h
    obtain ⟨encoded, _, rfl⟩ := Finset.mem_image.mp hpair
    exact Finset.mem_image.mpr ⟨encoded.1, encoded.2,
      (cellGraphEdge_endpointSet cells encoded).symm⟩
  · intro h
    obtain ⟨encoded, hencoded, rfl⟩ := Finset.mem_image.mp h
    let e : cellEdges cells := ⟨encoded, hencoded⟩
    exact Finset.mem_image.mpr ⟨cellGraphEdge cells e,
      Finset.mem_image.mpr ⟨e, Finset.mem_attach _ _, rfl⟩,
      cellGraphEdge_endpointSet cells e⟩

end Ising2DLambda.KacWard
