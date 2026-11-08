import Ising2DLambda.KacWard.PlaneCellBoundary
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- Parity of the selected vertical edges crossed by the ray to the right of a cell. -/
def planeDualRayHeight (edges : Finset GridEdge) (r c : ℤ) : ZMod 2 :=
  ∑ e ∈ edges, if e.1 = true ∧ e.2.1 = r ∧ c < e.2.2 then 1 else 0

/-- Moving the ray's starting cell one column changes exactly one crossing. -/
theorem planeDualRayHeight_horizontal (edges : Finset GridEdge) (r c : ℤ) :
    planeDualRayHeight edges r (c - 1) =
      planeDualRayHeight edges r c +
        if (true, (r, c)) ∈ edges then 1 else 0 := by
  have hlocal (e : GridEdge) :
      (if e.1 = true ∧ e.2.1 = r ∧ c - 1 < e.2.2 then (1 : ZMod 2) else 0) =
        (if e.1 = true ∧ e.2.1 = r ∧ c < e.2.2 then 1 else 0) +
          (if e = (true, (r, c)) then 1 else 0) := by
    rcases e with ⟨b, ⟨s, d⟩⟩
    by_cases hb : b = true
    · by_cases hs : s = r
      · by_cases hcd : d = c
        · subst d
          simp [hb, hs]
        · by_cases hgt : c < d
          · have hleft : c - 1 < d := by omega
            simp [hb, hs, hcd, hgt, hleft]
          · have hleft : ¬ c - 1 < d := by omega
            simp [hb, hs, hcd, hgt, hleft]
      · simp [hs]
    · simp [hb]
  simp only [planeDualRayHeight]
  calc
    (∑ e ∈ edges, if e.1 = true ∧ e.2.1 = r ∧ c - 1 < e.2.2 then (1 : ZMod 2) else 0) =
        ∑ e ∈ edges,
          ((if e.1 = true ∧ e.2.1 = r ∧ c < e.2.2 then (1 : ZMod 2) else 0) +
            if e = (true, (r, c)) then 1 else 0) := by
              apply Finset.sum_congr rfl
              intro e _
              exact hlocal e
    _ = (∑ e ∈ edges, if e.1 = true ∧ e.2.1 = r ∧ c < e.2.2 then (1 : ZMod 2) else 0) +
          (∑ e ∈ edges, if e = (true, (r, c)) then (1 : ZMod 2) else 0) := by
            rw [Finset.sum_add_distrib]
    _ = _ := by simp

end Ising2DLambda.KacWard
