import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- The coefficient needs only nonzero powers and the absence of zero divisors. -/
theorem gauge_pair_weight_ne_zero_necSuf {F : Type*} [Field F]
    (z : F) (hz : z ≠ 0) (p q r t : ℤ) :
    z ^ (2 : ℕ) * ((z ^ p * z ^ q) * (z ^ r * z ^ t)) ≠ 0 := by
  have htwo : z ^ (2 : ℕ) ≠ 0 := pow_ne_zero 2 hz
  have hp : z ^ p ≠ 0 := zpow_ne_zero p hz
  have hq : z ^ q ≠ 0 := zpow_ne_zero q hz
  have hr : z ^ r ≠ 0 := zpow_ne_zero r hz
  have ht : z ^ t ≠ 0 := zpow_ne_zero t hz
  exact mul_ne_zero htwo (mul_ne_zero (mul_ne_zero hp hq) (mul_ne_zero hr ht))

end Ising2DLambda.NecSuf.KacWard
