import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- `claim_untwisted_mode_zero_condition`: the same two algebraic steps use
commutativity and the absence of zero divisors. Neither division nor order is used. -/
theorem untwistedMode_zero_condition
    {R : Type*} [CommRing R] [NoZeroDivisors R] (q : R) :
    ((1 + q ^ 2) ^ 2 - q * (1 - q ^ 2) * (1 + 1 + 1 + 1) = 0 ↔
      q ^ 2 + 2 * q - 1 = 0) := by
  have hsum : (1 + q ^ 2) ^ 2 - q * (1 - q ^ 2) * (1 + 1 + 1 + 1) =
      (1 + q ^ 2) ^ 2 - 4 * q * (1 - q ^ 2) := by ring
  have hfactor : (1 + q ^ 2) ^ 2 - 4 * q * (1 - q ^ 2) =
      (1 - 2 * q - q ^ 2) ^ 2 := by ring
  rw [hsum, hfactor]
  constructor
  · intro h
    have hbase : 1 - 2 * q - q ^ 2 = 0 := by
      have hm : (1 - 2 * q - q ^ 2) * (1 - 2 * q - q ^ 2) = 0 := by
        simpa [pow_two] using h
      exact (mul_eq_zero.mp hm).elim id id
    calc
      q ^ 2 + 2 * q - 1 = -(1 - 2 * q - q ^ 2) := by ring
      _ = 0 := by rw [hbase]; ring
  · intro h
    have hbase : 1 - 2 * q - q ^ 2 = 0 := by
      calc
        1 - 2 * q - q ^ 2 = -(q ^ 2 + 2 * q - 1) := by ring
        _ = 0 := by rw [h]; ring
    rw [hbase]
    ring

end Ising2DLambda.NecSuf.KacWard
