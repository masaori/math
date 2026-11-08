import Ising2DLambda.KacWard.PlaneDualRayHeight
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- A vertical edge separates cells of different ray heights exactly when it is selected. -/
theorem planeHeightOne_vertical_edge (edges : Finset GridEdge) (r c : ℤ) :
    ((planeDualRayHeight edges r (c - 1) = 1 ∧
        planeDualRayHeight edges r c ≠ 1) ∨
      (planeDualRayHeight edges r (c - 1) ≠ 1 ∧
        planeDualRayHeight edges r c = 1)) ↔
      (true, (r, c)) ∈ edges := by
  have h := planeDualRayHeight_horizontal edges r c
  have hcases (x : ZMod 2) : x = 0 ∨ x = 1 := by
    fin_cases x <;> first | exact Or.inl rfl | exact Or.inr rfl
  by_cases he : (true, (r, c)) ∈ edges
  · rw [if_pos he] at h
    rw [h]
    rcases hcases (planeDualRayHeight edges r c) with hh | hh <;> simp [he, hh]
  · rw [if_neg he] at h
    rw [h]
    rcases hcases (planeDualRayHeight edges r c) with hh | hh <;> simp [he, hh]

end Ising2DLambda.KacWard
