import Ising2DLambda.KacWard.PlaneHeightOneBoundary
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

theorem same_height_one_across_missing_edge
    (selected cells : Finset GridCell) (edges : Finset GridEdge)
    (hboundary : planeCellBoundary selected = edges)
    (hsubset : edges ⊆ cellEdges cells)
    (p q : GridCell)
    (hstep : ∃ e : GridEdge, e ∉ cellEdges cells ∧ SharedGridEdge p q e) :
    (p ∈ selected ↔ q ∈ selected) := by
  obtain ⟨e, he, hshared⟩ := hstep
  have hnot : e ∉ planeCellBoundary selected := by
    rw [hboundary]
    exact fun hz => he (hsubset hz)
  rcases p with ⟨r, c⟩
  rcases q with ⟨s, d⟩
  rcases hshared with ⟨hq, rfl⟩ | ⟨hq, rfl⟩ | ⟨hq, rfl⟩ | ⟨hq, rfl⟩
  · have hs : s = r := (Prod.mk.inj hq).1
    have hd : d = c - 1 := (Prod.mk.inj hq).2
    subst s
    subst d
    simp only [planeCellBoundary, Finset.mem_filter,
      verticalEdge_mem_cellEdges_iff, ↓reduceIte] at hnot
    tauto
  · have hs : s = r := (Prod.mk.inj hq).1
    have hd : d = c + 1 := (Prod.mk.inj hq).2
    subst s
    subst d
    simp only [planeCellBoundary, Finset.mem_filter,
      verticalEdge_mem_cellEdges_iff, ↓reduceIte] at hnot
    have hc : c + 1 - 1 = c := by omega
    simp only [hc] at hnot
    tauto
  · have hs : s = r - 1 := (Prod.mk.inj hq).1
    have hd : d = c := (Prod.mk.inj hq).2
    subst s
    subst d
    simp only [planeCellBoundary, Finset.mem_filter,
      horizontalEdge_mem_cellEdges_iff, Bool.false_eq_true, ↓reduceIte] at hnot
    tauto
  · have hs : s = r + 1 := (Prod.mk.inj hq).1
    have hd : d = c := (Prod.mk.inj hq).2
    subst s
    subst d
    simp only [planeCellBoundary, Finset.mem_filter,
      horizontalEdge_mem_cellEdges_iff, Bool.false_eq_true, ↓reduceIte] at hnot
    have hr : r + 1 - 1 = r := by omega
    simp only [hr] at hnot
    tauto

/-- An even edge set supported by a cell complex has no height-one cells in
the connected complement of that complex. -/
theorem planeHeightOne_exterior_inclusion (cells : Finset GridCell)
    (edges : Finset GridEdge)
    (heven : ∀ r c : ℤ,
      ((if (false, (r, c)) ∈ edges then (1 : ZMod 2) else 0) +
        (if (false, (r, c - 1)) ∈ edges then 1 else 0) +
        (if (true, (r, c)) ∈ edges then 1 else 0) +
        (if (true, (r - 1, c)) ∈ edges then 1 else 0)) = 0)
    (hsubset : edges ⊆ cellEdges cells)
    (hconnected : EdgeConnectedCellSet (↑cells : Set GridCell)ᶜ) :
    ∀ r c : ℤ, planeDualRayHeight edges r c = 1 → (r, c) ∈ cells := by
  obtain ⟨selected, hselected, hboundary⟩ := planeHeightOne_boundary edges heven
  have hconst : ∀ p q : GridCell, SameComplementCellRegion cells p q →
      (p ∈ selected ↔ q ∈ selected) := by
    intro p q hpath
    induction hpath with
    | refl => rfl
    | tail _ hstep ih =>
      exact ih.trans (same_height_one_across_missing_edge selected cells edges
        hboundary hsubset _ _ hstep)
  have hfree : ((Set.univ : Set GridCell) \ ↑(cells ∪ selected)).Nonempty :=
    ((Set.infinite_univ).sdiff (Finset.finite_toSet (cells ∪ selected))).nonempty
  obtain ⟨q, hq⟩ := hfree
  have hqcells : q ∉ cells := by
    intro hc
    exact hq.2 (Finset.mem_coe.mpr (Finset.mem_union_left selected hc))
  have hqselected : q ∉ selected := by
    intro hc
    exact hq.2 (Finset.mem_coe.mpr (Finset.mem_union_right cells hc))
  intro r c hh
  by_contra hp
  have hpath := exterior_cells_same_complement_region cells hconnected
    (r, c) q hp hqcells
  exact hqselected ((hconst (r, c) q hpath).mp ((hselected r c).2 hh))

end Ising2DLambda.KacWard
