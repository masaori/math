import Ising2DLambda.KacWard.PlaneDualRayHeightVertical
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- The horizontal edge separates cells of different ray heights exactly when it is selected. -/
theorem planeHeightOne_horizontal_edge (edges : Finset GridEdge)
    (heven : ∀ r c : ℤ,
      ((if (false, (r, c)) ∈ edges then (1 : ZMod 2) else 0) +
        (if (false, (r, c - 1)) ∈ edges then 1 else 0) +
        (if (true, (r, c)) ∈ edges then 1 else 0) +
        (if (true, (r - 1, c)) ∈ edges then 1 else 0)) = 0)
    (r c : ℤ) :
    ((planeDualRayHeight edges r c = 1 ∧
        planeDualRayHeight edges (r - 1) c ≠ 1) ∨
      (planeDualRayHeight edges r c ≠ 1 ∧
        planeDualRayHeight edges (r - 1) c = 1)) ↔
      (false, (r, c)) ∈ edges := by
  have h := planeDualRayHeight_vertical edges heven r c
  have hcases (x : ZMod 2) : x = 0 ∨ x = 1 := by
    fin_cases x <;> first | exact Or.inl rfl | exact Or.inr rfl
  rcases hcases (planeDualRayHeight edges r c) with ht | ht <;>
  rcases hcases (planeDualRayHeight edges (r - 1) c) with hb | hb <;>
  by_cases he : (false, (r, c)) ∈ edges <;>
  simp [ht, hb, he] at h ⊢

/-- Any finite realization of the height-one cells has the prescribed horizontal boundary. -/
theorem planeHeightOne_horizontal_boundary (edges : Finset GridEdge)
    (heven : ∀ r c : ℤ,
      ((if (false, (r, c)) ∈ edges then (1 : ZMod 2) else 0) +
        (if (false, (r, c - 1)) ∈ edges then 1 else 0) +
        (if (true, (r, c)) ∈ edges then 1 else 0) +
        (if (true, (r - 1, c)) ∈ edges then 1 else 0)) = 0)
    (cells : Finset GridCell)
    (hcell : ∀ r c : ℤ, (r, c) ∈ cells ↔ planeDualRayHeight edges r c = 1)
    (r c : ℤ) :
    (false, (r, c)) ∈ planeCellBoundary cells ↔ (false, (r, c)) ∈ edges := by
  have hb : (false, (r, c)) ∈ planeCellBoundary cells ↔
      (((r, c) ∈ cells ∧ (r - 1, c) ∉ cells) ∨
        ((r, c) ∉ cells ∧ (r - 1, c) ∈ cells)) := by
    simp only [planeCellBoundary, Finset.mem_filter, horizontalEdge_mem_cellEdges_iff,
      Bool.false_eq_true, ↓reduceIte]
    tauto
  rw [hb, hcell r c, hcell (r - 1) c]
  exact planeHeightOne_horizontal_edge edges heven r c

end Ising2DLambda.KacWard
