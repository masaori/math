import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- A cyclic coordinate step is a unit displacement corrected at the seam. -/
theorem representative_step_displacement (L : ℕ) (r r' : ℤ)
    (hrL : r < L)
    (hstep : r' = if r ≤ (L : ℤ) - 2 then r + 1 else 0)
    (reverse : Bool) :
    (if reverse then r - r' else r' - r) =
      (if reverse then -1 else 1) -
        (L : ℤ) * (if r = (L : ℤ) - 1 then 1 else 0) *
          (if reverse then -1 else 1) := by
  by_cases h : r ≤ (L : ℤ) - 2
  · have hn : r ≠ (L : ℤ) - 1 := by omega
    cases reverse <;> simp [hstep, h, hn]
  · have heq : r = (L : ℤ) - 1 := by omega
    cases reverse <;> simp [hstep, heq] <;> omega

end Ising2DLambda.NecSuf.KacWard
