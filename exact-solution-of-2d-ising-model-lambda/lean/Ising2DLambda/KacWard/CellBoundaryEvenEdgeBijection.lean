import Ising2DLambda.KacWard.EvenEdgeSetCellBoundary
import Ising2DLambda.KacWard.PlaneCellBoundaryInjective
import Ising2DLambda.KacWard.CellGridIncidentParity
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- 本文の偶辺集合: `E_□(S)` に含まれ、各格子頂点に接する辺の本数が偶数の有限集合。 -/
def IsEvenCellEdgeSubset (cells : Finset GridCell) (edges : Finset GridEdge) : Prop :=
  edges ⊆ cellEdges cells ∧
    ∀ r c : ℤ, Even (edges.filter (fun e => (r, c) ∈ gridEdgeEndpoints e)).card

theorem boundary_subset (selected cells : Finset GridCell)
    (hselected : selected ⊆ cells) :
    planeCellBoundary selected ⊆ cellEdges cells := by
  intro e he
  have hmem : e ∈ cellEdges selected := (Finset.mem_filter.mp he).1
  obtain ⟨p, hp, hpe⟩ := Finset.mem_biUnion.mp hmem
  exact Finset.mem_biUnion.mpr ⟨p, hselected hp, hpe⟩

theorem boundary_fourEdge_even (selected : Finset GridCell) :
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

/-- 本文: 境界の各頂点の四方向の偶奇（`claim_plane_cell_boundary_even_at_vertex`）を、
`claim_grid_incident_four_edge_parity` で接続辺数の偶数性へ移す。 -/
theorem boundary_even (selected : Finset GridCell) (r c : ℤ) :
    Even ((planeCellBoundary selected).filter
      (fun e => (r, c) ∈ gridEdgeEndpoints e)).card :=
  (gridIncidentEven_iff (planeCellBoundary selected) r c).mp
    (boundary_fourEdge_even selected r c)

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
      evenEdgeSet_cell_boundary cells edges.1
        (fun r c => (gridIncidentEven_iff edges.1 r c).mpr (edges.2.2 r c))
        edges.2.1 hconnected
    exact ⟨⟨selected, hsubset⟩, Subtype.ext hboundary⟩

end Ising2DLambda.KacWard
