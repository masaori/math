import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- Only the two possible exponents and the nonzero base are needed. -/
theorem two_value_power_ne_zero {F : Type*} [MonoidWithZero F] [Nontrivial F]
    (z : F) (hz : z ≠ 0) (k : ℕ) (hk : k = 0 ∨ k = 1) : z ^ k ≠ 0 := by
  rcases hk with h | h
  · rw [h, pow_zero]
    exact one_ne_zero
  · rw [h, pow_one]
    exact hz

end Ising2DLambda.NecSuf.KacWard
