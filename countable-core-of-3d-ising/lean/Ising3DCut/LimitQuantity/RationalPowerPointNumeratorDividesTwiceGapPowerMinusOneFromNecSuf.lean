/-
必要十分版から、具体版の「分子は隣接する二つの箱の頂点数の差だけの点数乗から
1 を引いた数の 2 倍を割る」を導く。
-/
import Ising3DCut.LimitQuantity.RationalPowerPointNumeratorDividesTwiceGapPowerMinusOne
import Ising3DCut.NecSuf.RationalPowerPointNumeratorDividesTwiceGapPowerMinusOne

namespace Ising3DCut.LimitQuantity

/-- 具体版を必要十分版の特殊化として導いた版。 -/
theorem rational_power_point_numerator_divides_twice_gap_power_minus_one_viaNecSuf
    (c : ℚ) (a : ℤ) (L : ℕ)
    (hden : c.den = 1)
    (hcongN : Int.ModEq a (c.num ^ (L ^ 3)) (2 * (1 : ℤ) ^ (L ^ 3)))
    (hcongM : Int.ModEq a (c.num ^ ((L + 1) ^ 3)) (2 * (1 : ℤ) ^ ((L + 1) ^ 3))) :
    c = (c.num : ℚ) ∧ a ∣ 2 * (c.num ^ (3 * L ^ 2 + 3 * L + 1) - 1) := by
  have hc : c = (c.num : ℚ) := eq_num_of_den_eq_one c hden
  have hN : Int.ModEq a (c.num ^ (L ^ 3)) 2 :=
    base_power_congr_two a c.num 1 2 (L ^ 3) rfl rfl hcongN
  have hM : Int.ModEq a (c.num ^ ((L + 1) ^ 3)) 2 :=
    base_power_congr_two a c.num 1 2 ((L + 1) ^ 3) rfl rfl hcongM
  exact Ising3DCut.NecSuf.equality_and_dvd_twice_gap_power_minus_one
    c (c.num : ℚ) a c.num (L ^ 3) ((L + 1) ^ 3) (3 * L ^ 2 + 3 * L + 1)
      hc (vertex_count_succ_eq_add_gap L) hN hM

end Ising3DCut.LimitQuantity
