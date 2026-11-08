import Ising2DLambda.KacWard.CellComplexOneCellIncrement
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

end Ising2DLambda.KacWard
