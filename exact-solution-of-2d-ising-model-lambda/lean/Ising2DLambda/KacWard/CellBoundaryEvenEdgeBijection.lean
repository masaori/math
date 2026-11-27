import Ising2DLambda.KacWard.EvenEdgeSetCellBoundary
import Ising2DLambda.KacWard.PlaneCellBoundaryInjective
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

theorem boundary_subset (selected cells : Finset GridCell)
    (hselected : selected ⊆ cells) :
    planeCellBoundary selected ⊆ cellEdges cells := by
  intro e he
  have hmem : e ∈ cellEdges selected := (Finset.mem_filter.mp he).1
  obtain ⟨p, hp, hpe⟩ := Finset.mem_biUnion.mp hmem
  exact Finset.mem_biUnion.mpr ⟨p, hselected hp, hpe⟩

theorem boundary_even (selected : Finset GridCell) :
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

/-- 本文の写像 `T ↦ B_□(T)`（`T ⊆ S`）。値が `E_□(S)` に含まれる偶辺集合であることは
`boundary_subset`・`boundary_even`。 -/
def cellBoundaryEvenEdgeMap (cells : Finset GridCell)
    (selected : {T : Finset GridCell // T ⊆ cells}) :
    {E : Finset GridEdge // IsEvenCellEdgeSubset cells E} :=
  ⟨planeCellBoundary selected.1,
    boundary_subset selected.1 cells selected.2,
    boundary_even selected.1⟩

/-- Boundary is a bijection from subsets of a hole-free cell set to even edge subsets. -/
theorem cellBoundary_evenEdge_bijective (cells : Finset GridCell)
    (hconnected : EdgeConnectedCellSet (↑cells : Set GridCell)ᶜ) :
    Function.Bijective (cellBoundaryEvenEdgeMap cells) := by
  constructor
  · intro a b h
    apply Subtype.ext
    exact planeCellBoundary_injective (congrArg Subtype.val h)
  · intro edges
    obtain ⟨selected, hsubset, hboundary⟩ :=
      evenEdgeSet_cell_boundary cells edges.1 edges.2.2 edges.2.1 hconnected
    exact ⟨⟨selected, hsubset⟩, Subtype.ext hboundary⟩

end Ising2DLambda.KacWard
