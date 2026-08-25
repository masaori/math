import Ising3DCut.LimitQuantity.PowerMinusOneGcdEqualsPowerOfExponentGcd
import Ising3DCut.NecSuf.PowerMinusOneGcdEqualsPowerOfExponentGcd

namespace Ising3DCut.LimitQuantity

theorem powerMinusOne_gcd_equals_power_of_exponent_gcd_viaNecSuf
    (c : ℤ) (hc : 1 ≤ c) (m n : ℕ) (hm : 0 < m) (hn : 0 < n) :
    (Int.gcd (c ^ m - 1) (c ^ n - 1) : ℤ) = c ^ Nat.gcd m n - 1 := by
  apply Ising3DCut.NecSuf.combine_eq_normalize_of_reaches_self
      (fun a b : ℤ => (Int.gcd a b : ℤ)) (fun a : ℤ => a)
      (c ^ m - 1) (c ^ n - 1) (c ^ Nat.gcd m n - 1)
  · exact_mod_cast powerMinusOne_gcd_reaches_exponent_gcd c m n hm hn
  · have hnonneg : (0 : ℤ) ≤ c ^ Nat.gcd m n - 1 := by
      have : (1 : ℤ) ≤ c ^ Nat.gcd m n := one_le_pow₀ hc
      linarith
    exact int_gcd_self_eq_of_nonneg _ hnonneg

end Ising3DCut.LimitQuantity
