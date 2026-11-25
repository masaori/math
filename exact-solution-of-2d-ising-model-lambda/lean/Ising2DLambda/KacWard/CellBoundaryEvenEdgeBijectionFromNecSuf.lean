/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.CellBoundaryEvenEdgeBijection
import Ising2DLambda.NecSuf.KacWard.CellBoundaryEvenEdgeBijection

namespace Ising2DLambda.KacWard

/-- The abstract finite-boundary argument specializes to planar cell boundaries. -/
theorem cellBoundary_evenEdge_bijective_from_necSuf (cells : Finset GridCell)
    (hconnected : EdgeConnectedCellSet (↑cells : Set GridCell)ᶜ) :
    Function.Bijective
      (fun selected : {T : Finset GridCell // T ⊆ cells} =>
        (⟨planeCellBoundary selected.1,
          boundary_subset selected.1 cells selected.2,
          boundary_even selected.1⟩ :
          {E : Finset GridEdge // IsEvenCellEdgeSubset cells E})) := by
  have hclosed : ∀ selected, selected ⊆ cells →
      IsEvenCellEdgeSubset cells (planeCellBoundary selected) := by
    intro selected hsubset
    exact ⟨boundary_subset selected cells hsubset, boundary_even selected⟩
  have hkernel : ∀ selected, planeCellBoundary selected = ∅ → selected = ∅ := by
    intro selected hboundary
    by_contra hnon
    exact (planeCellBoundary_nonempty selected
      (Finset.nonempty_iff_ne_empty.mpr hnon)).ne_empty hboundary
  have hpreimage : ∀ edges, IsEvenCellEdgeSubset cells edges →
      ∃ selected, selected ⊆ cells ∧ planeCellBoundary selected = edges := by
    intro edges hedges
    exact evenEdgeSet_cell_boundary cells edges hedges.2 hedges.1 hconnected
  exact Ising2DLambda.NecSuf.KacWard.boundary_bijective_of_even_edge_preimages
    planeCellBoundary cells (IsEvenCellEdgeSubset cells)
    planeCellBoundary_symmDiff hkernel hclosed hpreimage

end Ising2DLambda.KacWard
