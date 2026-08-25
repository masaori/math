/-
必要十分版 `NecSuf.equality_and_dvd_difference_of_common_residue` から、具体版の
「点数乗表示が成り立つ正の有理点の分子は隣接する二つの箱の底の点数乗の差を割る」を導く。
-/
import Ising3DCut.LimitQuantity.RationalPowerPointNumeratorDividesBasePowerDifference
import Ising3DCut.NecSuf.RationalPowerPointNumeratorDividesBasePowerDifference

namespace Ising3DCut.LimitQuantity

/-- `rational_power_point_numerator_divides_base_power_difference` を必要十分版から導いた版。 -/
theorem rational_power_point_numerator_divides_base_power_difference_viaNecSuf
    (c : ℚ) (a : ℤ) (N M : ℕ)
    (hden : c.den = 1)
    (hcongN : Int.ModEq a (c.num ^ N) (2 * (1 : ℤ) ^ N))
    (hcongM : Int.ModEq a (c.num ^ M) (2 * (1 : ℤ) ^ M)) :
    c = (c.num : ℚ) ∧ a ∣ c.num ^ M - c.num ^ N := by
  have hc : c = (c.num : ℚ) := eq_num_of_den_eq_one c hden
  have hN : Int.ModEq a (c.num ^ N) 2 :=
    base_power_congr_two a c.num 1 2 N rfl rfl hcongN
  have hM : Int.ModEq a (c.num ^ M) 2 :=
    base_power_congr_two a c.num 1 2 M rfl rfl hcongM
  exact Ising3DCut.NecSuf.equality_and_dvd_difference_of_common_residue
    c (c.num : ℚ) a (c.num ^ N) (c.num ^ M) 2 hc hN hM

end Ising3DCut.LimitQuantity
