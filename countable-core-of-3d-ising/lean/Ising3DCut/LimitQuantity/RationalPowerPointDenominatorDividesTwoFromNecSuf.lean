/-
必要十分版 `NecSuf.denominator_one_and_outer_denominator_divides_constant` から、
具体版の「点数乗表示が成り立つ正の有理点の既約分母は 2 を割る」を導く。
-/
import Ising3DCut.LimitQuantity.RationalPowerPointDenominatorDividesTwo
import Ising3DCut.NecSuf.RationalPowerPointDenominatorDividesTwo

namespace Ising3DCut.LimitQuantity

/-- `rational_power_point_denominator_divides_two` を必要十分版から導いた版。 -/
theorem rational_power_point_denominator_divides_two_viaNecSuf
    (c : ℚ) (b N : ℕ)
    (hodd : ∀ p : ℕ, p.Prime → p ≠ 2 → ¬ p ∣ c.den)
    (htwo : ¬ (2 : ℕ) ∣ c.den)
    (hdvd : b ∣ 2 * c.den ^ N) :
    c.den = 1 ∧ b ∣ 2 := by
  apply Ising3DCut.NecSuf.denominator_one_and_outer_denominator_divides_constant
      c.den b 2 N 2
  · intro p hp hpv
    exact prime_dvd_den_eq_two_of_no_odd_prime c hodd p hp hpv
  · exact htwo
  · exact hdvd

end Ising3DCut.LimitQuantity
