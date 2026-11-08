import Ising2DLambda.KacWard.PlaneDualRayHeight
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- The ray height vanishes in every row without a selected vertical edge. -/
theorem planeDualRayHeight_zero_of_row_absent (edges : Finset GridEdge) (r c : ℤ)
    (hrow : ∀ d : ℤ, (true, (r, d)) ∉ edges) :
    planeDualRayHeight edges r c = 0 := by
  simp only [planeDualRayHeight]
  apply Finset.sum_eq_zero
  intro e he
  rcases e with ⟨b, ⟨s, d⟩⟩
  by_cases hb : b = true
  · by_cases hs : s = r
    · subst b
      subst s
      exact False.elim ((hrow d) he)
    · simp [hs]
  · simp [hb]

/-- Rows with nonzero height belong to the finite set of selected edge rows. -/
theorem planeDualRayHeight_row_support (edges : Finset GridEdge) (r c : ℤ)
    (hheight : planeDualRayHeight edges r c = 1) :
    r ∈ edges.image (fun e => e.2.1) := by
  by_contra hrow
  have habsent : ∀ d : ℤ, (true, (r, d)) ∉ edges := by
    intro d hedges
    exact hrow (Finset.mem_image.mpr ⟨(true, (r, d)), hedges, rfl⟩)
  have hzero := planeDualRayHeight_zero_of_row_absent edges r c habsent
  have : (0 : ZMod 2) = 1 := hzero.symm.trans hheight
  norm_num at this

end Ising2DLambda.KacWard
