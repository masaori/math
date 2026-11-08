import Ising2DLambda.KacWard.CellComplexOneCellIncrement
import Ising2DLambda.KacWard.WalkSideInteriorBandConnected
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- A horizontal grid edge belongs to the cell complex exactly when one of its
two incident cells is selected. -/
theorem horizontalEdge_mem_cellEdges_iff (cells : Finset GridCell) (r c : ℤ) :
    (false, (r, c)) ∈ cellEdges cells ↔
      (r, c) ∈ cells ∨ (r - 1, c) ∈ cells := by
  simp only [cellEdges, Finset.mem_biUnion, edgesOfCell, Finset.mem_insert,
    Finset.mem_singleton]
  constructor
  · rintro ⟨⟨a, b⟩, hab, h⟩
    simp at h
    rcases h with h | h
    · rcases h with ⟨ha, hb⟩
      exact Or.inl (by simpa [ha, hb] using hab)
    · rcases h with ⟨ha, hb⟩
      have hr : r - 1 = a := by omega
      exact Or.inr (by simpa [hr, hb] using hab)
  · rintro (h | h)
    · exact ⟨(r, c), h, by simp⟩
    · refine ⟨(r - 1, c), h, ?_⟩
      simp

/-- A vertical grid edge belongs to the cell complex exactly when one of its
two incident cells is selected. -/
theorem verticalEdge_mem_cellEdges_iff (cells : Finset GridCell) (r c : ℤ) :
    (true, (r, c)) ∈ cellEdges cells ↔
      (r, c) ∈ cells ∨ (r, c - 1) ∈ cells := by
  simp only [cellEdges, Finset.mem_biUnion, edgesOfCell, Finset.mem_insert,
    Finset.mem_singleton]
  constructor
  · rintro ⟨⟨a, b⟩, hab, h⟩
    simp at h
    rcases h with h | h
    · rcases h with ⟨ha, hb⟩
      exact Or.inl (by simpa [ha, hb] using hab)
    · rcases h with ⟨ha, hb⟩
      have hc : c - 1 = b := by omega
      exact Or.inr (by simpa [ha, hc] using hab)
  · rintro (h | h)
    · exact ⟨(r, c), h, by simp⟩
    · refine ⟨(r, c - 1), h, ?_⟩
      simp

/-- Neighboring exterior cells have no horizontal grid edge between them. -/
theorem horizontalEdge_not_mem_of_exterior (cells : Finset GridCell) (r c : ℤ)
    (hupper : (r, c) ∉ cells) (hlower : (r - 1, c) ∉ cells) :
    (false, (r, c)) ∉ cellEdges cells := by
  rw [horizontalEdge_mem_cellEdges_iff]
  exact not_or.mpr ⟨hupper, hlower⟩

/-- Neighboring exterior cells have no vertical grid edge between them. -/
theorem verticalEdge_not_mem_of_exterior (cells : Finset GridCell) (r c : ℤ)
    (hright : (r, c) ∉ cells) (hleft : (r, c - 1) ∉ cells) :
    (true, (r, c)) ∉ cellEdges cells := by
  rw [verticalEdge_mem_cellEdges_iff]
  exact not_or.mpr ⟨hright, hleft⟩

/-- The grid edge common to two neighboring cells, with its orientation recorded. -/
def SharedGridEdge (p q : GridCell) (e : GridEdge) : Prop :=
  (q = (p.1, p.2 - 1) ∧ e = (true, p)) ∨
  (q = (p.1, p.2 + 1) ∧ e = (true, q)) ∨
  (q = (p.1 - 1, p.2) ∧ e = (false, p)) ∨
  (q = (p.1 + 1, p.2) ∧ e = (false, q))

/-- Every step between exterior cells crosses a grid edge absent from the cell complex. -/
theorem exterior_adjacent_has_missing_shared_edge (cells : Finset GridCell)
    (p q : GridCell) (hp : p ∉ cells) (hq : q ∉ cells)
    (hadj : CellEdgeAdjacent p q) :
    ∃ e : GridEdge, e ∉ cellEdges cells ∧ SharedGridEdge p q e := by
  rcases p with ⟨r, c⟩
  rcases q with ⟨s, d⟩
  change (s = r ∧ (d = c - 1 ∨ d = c + 1)) ∨
    (d = c ∧ (s = r - 1 ∨ s = r + 1)) at hadj
  rcases hadj with ⟨hs, hd | hd⟩ | ⟨hd, hs | hs⟩
  · refine ⟨(true, (r, c)), ?_, ?_⟩
    apply verticalEdge_not_mem_of_exterior cells r c hp
    simpa [hs, hd] using hq
    simp [SharedGridEdge, hs, hd]
  · refine ⟨(true, (s, d)), ?_, ?_⟩
    apply verticalEdge_not_mem_of_exterior cells s d hq
    simpa [hs, hd] using hp
    simp [SharedGridEdge, hs, hd]
  · refine ⟨(false, (r, c)), ?_, ?_⟩
    apply horizontalEdge_not_mem_of_exterior cells r c hp
    simpa [hs, hd] using hq
    simp [SharedGridEdge, hs, hd]
  · refine ⟨(false, (s, d)), ?_, ?_⟩
    apply horizontalEdge_not_mem_of_exterior cells s d hq
    simpa [hs, hd] using hp
    simp [SharedGridEdge, hs, hd]

/-- An exterior cell path can be traversed using only absent grid edges. -/
theorem exterior_path_avoids_cellEdges (cells : Finset GridCell)
    {p q : GridCell}
    (hpath : Relation.ReflTransGen
      (fun a b => a ∉ cells ∧ b ∉ cells ∧ CellEdgeAdjacent a b) p q) :
    Relation.ReflTransGen
      (fun a b => ∃ e : GridEdge, e ∉ cellEdges cells ∧
        SharedGridEdge a b e) p q := by
  have hmono :
      (fun a b : GridCell => a ∉ cells ∧ b ∉ cells ∧ CellEdgeAdjacent a b) ≤
        (fun a b : GridCell => ∃ e : GridEdge, e ∉ cellEdges cells ∧
          SharedGridEdge a b e) := by
    intro a b h
    exact exterior_adjacent_has_missing_shared_edge cells a b h.1 h.2.1 h.2.2
  exact (Relation.ReflTransGen.mono hmono p q) hpath

/-- Cells lie in the same combinatorial component of the complement of the
selected grid edges when they can be joined across missing shared edges. -/
def SameComplementCellRegion (cells : Finset GridCell) (p q : GridCell) : Prop :=
  Relation.ReflTransGen
    (fun a b => ∃ e : GridEdge, e ∉ cellEdges cells ∧ SharedGridEdge a b e) p q

/-- Edge connectivity of all exterior cells puts any two of them in one
combinatorial component of the complement of the grid edges. -/
theorem exterior_cells_same_complement_region (cells : Finset GridCell)
    (hconnected : EdgeConnectedCellSet (↑cells : Set GridCell)ᶜ)
    (p q : GridCell) (hp : p ∉ cells) (hq : q ∉ cells) :
    SameComplementCellRegion cells p q := by
  have hpath := hconnected (show p ∈ (↑cells : Set GridCell)ᶜ from hp)
    (show q ∈ (↑cells : Set GridCell)ᶜ from hq)
  exact exterior_path_avoids_cellEdges cells hpath

end Ising2DLambda.KacWard
