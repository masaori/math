import Ising2DLambda.KacWard.CellGridIncidentParity
import Ising2DLambda.NecSuf.KacWard.CellGraphEvenEdgeBijection
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- Even incidence for a selected set of encoded edges of a cell set. -/
def IsEvenEncodedCellEdgeSet (cells : Finset GridCell)
    (A : Finset (cellEdges cells)) : Prop :=
  ∀ r c : ℤ,
    Even (A.filter (fun e => (r, c) ∈ gridEdgeEndpoints e.1)).card

/-- Even incidence for a selected set of edges of the cell vertex graph. -/
def IsEvenCellGraphEdgeSet (cells : Finset GridCell)
    (B : Finset (cellVertexGraph cells).edgeFinset) : Prop :=
  ∀ v : cellVertices cells, Even (B.filter (fun e => v ∈ e.1)).card

/-- The edge correspondence preserves the global even-incidence condition. -/
theorem cellGraphEdge_even_iff (cells : Finset GridCell)
    (A : Finset (cellEdges cells)) :
    IsEvenEncodedCellEdgeSet cells A ↔
      IsEvenCellGraphEdgeSet cells (A.image (cellGraphEdgeEquiv cells)) := by
  constructor
  · intro h v
    exact (cellGraphEdge_incident_even_iff cells A v).mp (h v.1.1 v.1.2)
  · intro h r c
    by_cases hv : (r, c) ∈ cellVertices cells
    · exact (cellGraphEdge_incident_even_iff cells A ⟨(r, c), hv⟩).mpr (h ⟨(r, c), hv⟩)
    · have hempty : A.filter (fun e => (r, c) ∈ gridEdgeEndpoints e.1) = ∅ := by
        ext e
        constructor
        · intro he
          have hendpoint := gridEdgeEndpoints_subset_cellVertices cells e.1 e.2
          exact False.elim (hv (hendpoint (Finset.mem_filter.mp he).2))
        · simp
      simp [hempty]

/-- Even encoded-edge subsets and even graph-edge subsets correspond bijectively. -/
theorem cellGraphEvenEdge_bijective (cells : Finset GridCell) :
    Function.Bijective
      (fun A : {A : Finset (cellEdges cells) // IsEvenEncodedCellEdgeSet cells A} =>
        (⟨A.1.image (cellGraphEdgeEquiv cells),
          (cellGraphEdge_even_iff cells A.1).mp A.2⟩ :
          {B : Finset (cellVertexGraph cells).edgeFinset //
            IsEvenCellGraphEdgeSet cells B})) := by
  constructor
  · intro A B h
    apply Subtype.ext
    have himage := congrArg (fun s => s.image (cellGraphEdgeEquiv cells).symm)
      (congrArg Subtype.val h)
    simpa [Finset.image_image] using himage
  · intro B
    let A : Finset (cellEdges cells) := B.1.image (cellGraphEdgeEquiv cells).symm
    have himage : A.image (cellGraphEdgeEquiv cells) = B.1 := by
      simp [A, Finset.image_image]
    have heven : IsEvenEncodedCellEdgeSet cells A := by
      apply (cellGraphEdge_even_iff cells A).mpr
      simpa [himage] using B.2
    exact ⟨⟨A, heven⟩, Subtype.ext himage⟩

theorem cellGraphEvenEdge_bijective_from_necSuf (cells : Finset GridCell) :
    Function.Bijective
      (fun A : {A : Finset (cellEdges cells) // IsEvenEncodedCellEdgeSet cells A} =>
        (⟨A.1.image (cellGraphEdgeEquiv cells),
          (cellGraphEdge_even_iff cells A.1).mp A.2⟩ :
          {B : Finset (cellVertexGraph cells).edgeFinset //
            IsEvenCellGraphEdgeSet cells B})) := by
  exact Ising2DLambda.NecSuf.KacWard.subsetProperty_bijective_of_edgeEquiv
    (cellGraphEdgeEquiv cells)
    (IsEvenEncodedCellEdgeSet cells)
    (IsEvenCellGraphEdgeSet cells)
    (cellGraphEdge_even_iff cells)

end Ising2DLambda.KacWard
