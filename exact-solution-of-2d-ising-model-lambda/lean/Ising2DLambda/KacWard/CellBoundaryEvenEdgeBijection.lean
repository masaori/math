import Ising2DLambda.KacWard.EvenEdgeSetCellBoundary
import Ising2DLambda.KacWard.PlaneCellBoundaryInjective
import Ising2DLambda.NecSuf.KacWard.CellBoundaryEvenEdgeBijection
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- Even edge subsets supported on the cell graph, expressed at every grid vertex. -/
def IsEvenCellEdgeSubset (cells : Finset GridCell) (edges : Finset GridEdge) : Prop :=
  edges ⊆ cellEdges cells ∧
    ∀ r c : ℤ,
      ((if (false, (r, c)) ∈ edges then (1 : ZMod 2) else 0) +
        (if (false, (r, c - 1)) ∈ edges then 1 else 0) +
        (if (true, (r, c)) ∈ edges then 1 else 0) +
        (if (true, (r - 1, c)) ∈ edges then 1 else 0)) = 0

private theorem boundary_subset (selected cells : Finset GridCell)
    (hselected : selected ⊆ cells) :
    planeCellBoundary selected ⊆ cellEdges cells := by
  intro e he
  have hmem : e ∈ cellEdges selected := (Finset.mem_filter.mp he).1
  obtain ⟨p, hp, hpe⟩ := Finset.mem_biUnion.mp hmem
  exact Finset.mem_biUnion.mpr ⟨p, hselected hp, hpe⟩

private theorem boundary_even (selected : Finset GridCell) :
    ∀ r c : ℤ,
      ((if (false, (r, c)) ∈ planeCellBoundary selected then (1 : ZMod 2) else 0) +
        (if (false, (r, c - 1)) ∈ planeCellBoundary selected then 1 else 0) +
        (if (true, (r, c)) ∈ planeCellBoundary selected then 1 else 0) +
        (if (true, (r - 1, c)) ∈ planeCellBoundary selected then 1 else 0)) = 0 := by
  intro r c
  have h := planeCellBoundary_vertex_even selected r c
  by_cases h₁ : (false, (r, c)) ∈ planeCellBoundary selected <;>
    by_cases h₂ : (false, (r, c - 1)) ∈ planeCellBoundary selected <;>
    by_cases h₃ : (true, (r, c)) ∈ planeCellBoundary selected <;>
    by_cases h₄ : (true, (r - 1, c)) ∈ planeCellBoundary selected <;>
    simp_all <;> decide

/-- Boundary is a bijection from subsets of a hole-free cell set to even edge subsets. -/
theorem cellBoundary_evenEdge_bijective (cells : Finset GridCell)
    (hconnected : EdgeConnectedCellSet (↑cells : Set GridCell)ᶜ) :
    Function.Bijective
      (fun selected : {T : Finset GridCell // T ⊆ cells} =>
        (⟨planeCellBoundary selected.1,
          boundary_subset selected.1 cells selected.2,
          boundary_even selected.1⟩ :
          {E : Finset GridEdge // IsEvenCellEdgeSubset cells E})) := by
  constructor
  · intro a b h
    apply Subtype.ext
    exact planeCellBoundary_injective (congrArg Subtype.val h)
  · intro edges
    obtain ⟨selected, hsubset, hboundary⟩ :=
      evenEdgeSet_cell_boundary cells edges.1 edges.2.2 edges.2.1 hconnected
    exact ⟨⟨selected, hsubset⟩, Subtype.ext hboundary⟩

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
