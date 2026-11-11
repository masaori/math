import Mathlib.Data.ZMod.Basic

namespace Ising2DLambda.NecSuf.KacWard

/-- A three-valued turn table recovers the next direction when the reverse direction is excluded. -/
theorem step_advances_direction_necSuf (a b : ZMod 4)
    (hreverse : b ≠ a + 2) :
    b = a + ((if b = a then (0 : ℤ)
      else if b = a + 1 then 1
      else if b = a - 1 then -1 else 0) : ZMod 4) := by
  have hcases : b = a ∨ b = a + 1 ∨ b = a - 1 ∨ b = a + 2 := by decide +revert
  rcases hcases with h | h | h | h
  · simp [h]
  · simp [h]
  · simp [h, sub_eq_add_neg] <;> decide
  · exact (hreverse h).elim

/-- The three-valued turn table changes sign when the directed pair is reversed. -/
theorem reversed_pair_turn_sign_necSuf (a b : ZMod 4)
    (hreverse : b ≠ a + 2) :
    (if a + 2 = b + 2 then (0 : ℤ)
      else if a + 2 = b + 2 + 1 then 1
      else if a + 2 = b + 2 - 1 then -1 else 0) =
    -(if b = a then (0 : ℤ)
      else if b = a + 1 then 1
      else if b = a - 1 then -1 else 0) := by
  fin_cases a <;> fin_cases b <;> simp_all <;> decide

end Ising2DLambda.NecSuf.KacWard
