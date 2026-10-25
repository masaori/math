import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- The three scalar factors need multiplication with zero and no zero divisors. -/
theorem three_factor_coefficient_ne_zero {R : Type*} [MonoidWithZero R] [NoZeroDivisors R]
    (w ε ρ : R) (hw : w ≠ 0) (hε : ε ≠ 0) (hρ : ρ ≠ 0) :
    (w * ε) * ρ ≠ 0 := by
  have hpair : w * ε ≠ 0 := mul_ne_zero hw hε
  exact mul_ne_zero hpair hρ

end Ising2DLambda.NecSuf.KacWard
