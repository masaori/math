import Ising3DCut.LimitQuantity.NumeratorDividesTwiceBaseMinusOne
import Ising3DCut.NecSuf.NumeratorDividesTwiceBaseMinusOne

namespace Ising3DCut.LimitQuantity

/-- `numerator_divides_twice_base_minus_one` を必要十分版から導いた版。 -/
theorem numerator_divides_twice_base_minus_one_viaNecSuf
    (a : ℤ) (c : ℤ) (hc : 1 ≤ c) (m n : ℕ) (hm : 0 < m) (hn : 0 < n)
    (hcop : Nat.gcd m n = 1)
    (ham : a ∣ 2 * (c ^ m - 1)) (han : a ∣ 2 * (c ^ n - 1)) :
    a ∣ 2 * (c - 1) := by
  apply Ising3DCut.NecSuf.relation_of_relation_and_three_equalities
      (fun x y : ℤ => x ∣ y) a
      (Int.gcd (2 * (c ^ m - 1)) (2 * (c ^ n - 1)) : ℤ)
      (2 * (Int.gcd (c ^ m - 1) (c ^ n - 1) : ℤ))
      (2 * (c ^ Nat.gcd m n - 1))
      (2 * (c - 1))
  · exact Int.dvd_coe_gcd ham han
  · exact int_gcd_two_mul_eq_two_mul_gcd _ _
  · rw [powerMinusOne_gcd_equals_power_of_exponent_gcd c hc m n hm hn]
  · rw [hcop, pow_one]

end Ising3DCut.LimitQuantity
