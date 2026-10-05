import Mathlib.Algebra.Group.Basic
import Mathlib.Data.Nat.Basic

namespace Ising2DLambda.NecSuf.KacWard

/-- 本文と同じ商・余りと冪の計算。二乗が一となる元だけを使い、
格子、整数環、可換性、加法、逆元、順序は仮定しない。 -/
theorem pow_eq_pow_mod_two_necSuf {M : Type*} [Monoid M]
    (t : M) (htwo : t ^ 2 = 1) (n : ℕ) : t ^ n = t ^ (n % 2) := by
  let q := n / 2
  let r := n % 2
  have hdivision : n = 2 * q + r := (Nat.div_add_mod n 2).symm
  calc
    t ^ n = t ^ (2 * q + r) := congrArg (t ^ ·) hdivision
    _ = t ^ (2 * q) * t ^ r := pow_add _ _ _
    _ = (t ^ 2) ^ q * t ^ r := by rw [pow_mul]
    _ = (1 : M) ^ q * t ^ r := by rw [htwo]
    _ = (1 : M) * t ^ r := by rw [one_pow]
    _ = t ^ r := one_mul _
    _ = t ^ (n % 2) := rfl

end Ising2DLambda.NecSuf.KacWard
