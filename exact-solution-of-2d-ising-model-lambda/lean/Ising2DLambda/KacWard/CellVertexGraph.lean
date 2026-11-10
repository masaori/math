import Ising2DLambda.KacWard.GridEdgeEndpointsInCellVertices
import Ising2DLambda.KacWard.GridEdgeEndpointsInjective
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

/-- The encoded edge and its graph edge meet the same grid vertex. -/
theorem cellGraphEdge_incident_iff (cells : Finset GridCell)
    (e : cellEdges cells) (v : cellVertices cells) :
    v ∈ cellGraphEdge cells e ↔ v.1 ∈ gridEdgeEndpoints e.1 := by
  constructor
  · intro hv
    rw [← cellGraphEdge_endpointSet]
    exact Finset.mem_image.mpr ⟨v, by simpa using hv, rfl⟩
  · intro hv
    rw [← cellGraphEdge_endpointSet] at hv
    obtain ⟨w, hw, heq⟩ := Finset.mem_image.mp hv
    have h : w = v := Subtype.ext heq
    subst w
    simpa using hw

theorem cellGraphEdge_incident_iff_from_necSuf (cells : Finset GridCell)
    (e : cellEdges cells) (v : cellVertices cells) :
    v ∈ cellGraphEdge cells e ↔ v.1 ∈ gridEdgeEndpoints e.1 := by
  rw [← cellGraphEdge_endpointSet]
  exact Ising2DLambda.NecSuf.KacWard.endpoint_incidence_iff_of_subtype
    (cellGraphEdge cells e) v

/-- Distinct coordinate encoded grid edges remain distinct as graph edges. -/
theorem cellGraphEdge_injective (cells : Finset GridCell) :
    Function.Injective (cellGraphEdge cells) := by
  intro e f h
  have hsets := congrArg (fun edge : Sym2 (cellVertices cells) =>
    edge.toFinset.image Subtype.val) h
  rw [cellGraphEdge_endpointSet, cellGraphEdge_endpointSet] at hsets
  exact Subtype.ext (gridEdgeEndpoints_injective hsets)

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

/-- Coordinate encoded cell edges and graph edges correspond one to one. -/
noncomputable def cellGraphEdgeEquiv (cells : Finset GridCell) :
    cellEdges cells ≃ (cellVertexGraph cells).edgeFinset :=
  Equiv.ofBijective
    (fun e => (⟨cellGraphEdge cells e,
      (cellVertexGraph_edgeFinset cells).symm ▸
        Finset.mem_image.mpr ⟨e, Finset.mem_attach _ _, rfl⟩⟩ :
        (cellVertexGraph cells).edgeFinset))
    (by
      constructor
      · intro e f h
        exact cellGraphEdge_injective cells (congrArg Subtype.val h)
      · intro edge
        obtain ⟨edge, hmem⟩ := edge
        rw [cellVertexGraph_edgeFinset] at hmem
        obtain ⟨e, _, he⟩ := Finset.mem_image.mp hmem
        exact ⟨e, Subtype.ext he⟩)

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

/-- Restricting the edge correspondence to a selected set preserves each
vertex's incident-edge count and therefore its parity. -/
theorem cellGraphEdge_incident_card (cells : Finset GridCell)
    (A : Finset (cellEdges cells)) (v : cellVertices cells) :
    (A.filter (fun e => v.1 ∈ gridEdgeEndpoints e.1)).card =
      ((A.image (cellGraphEdgeEquiv cells)).filter
        (fun edge => v ∈ edge.1)).card := by
  classical
  rw [Finset.filter_image]
  have hfilter :
      (A.filter (fun e => v ∈ (cellGraphEdgeEquiv cells e).1)) =
        A.filter (fun e => v.1 ∈ gridEdgeEndpoints e.1) := by
    ext e
    simp only [Finset.mem_filter]
    have hinc : v ∈ (cellGraphEdgeEquiv cells e).1 ↔
        v.1 ∈ gridEdgeEndpoints e.1 :=
      cellGraphEdge_incident_iff cells e v
    simp [hinc]
  rw [hfilter, Finset.card_image_of_injective _ (cellGraphEdgeEquiv cells).injective]

theorem cellGraphEdge_incident_even_iff (cells : Finset GridCell)
    (A : Finset (cellEdges cells)) (v : cellVertices cells) :
    Even (A.filter (fun e => v.1 ∈ gridEdgeEndpoints e.1)).card ↔
      Even ((A.image (cellGraphEdgeEquiv cells)).filter
        (fun edge => v ∈ edge.1)).card := by
  rw [cellGraphEdge_incident_card]

end Ising2DLambda.KacWard
