/-
「有限箱の量が末尾で一定となる正の有理点は 1 に限られる」の接続の最後の一段。

束ね定理 `eq_one_of_cross_power_identity_from_free_box_numerator_connections` は
底についての箱に依存しない分子整除を二つ要求している。
ここでは、そのうち閾値の箱の点数乗についての整除
`a ∣ 2 (c^{L₀³} - 1)` が、もう一方の箱に依存しない整除 `a ∣ 2 (c - 1)` だけから
従うことを示し、外から与える仮定を一つに減らす。

一つの整除を冪の側へ持ち上げるだけであり、極限も無限和も現れない。
-/
import Ising3DCut.LimitQuantity.FreeBoxSumHeadSplit
import Ising3DCut.LimitQuantity.NumeratorDividesTwiceThresholdBoxValueMinusOne

namespace Ising3DCut.LimitQuantity

/-- 自然数の整除を整数の側へ移す一段。`1 ≤ c` なので `c ^ n - 1` の
自然数の引き算は整数の引き算と一致する。 -/
theorem int_dvd_two_mul_pow_sub_one_of_nat
    {a c n : ℕ} (hc : 1 ≤ c) (h : a ∣ 2 * (c ^ n - 1)) :
    (a : ℤ) ∣ 2 * ((c : ℤ) ^ n - 1) := by
  have hpow : 1 ≤ c ^ n := Nat.one_le_pow _ _ (by omega)
  have hcast : ((2 * (c ^ n - 1) : ℕ) : ℤ) = 2 * ((c : ℤ) ^ n - 1) := by
    push_cast [Nat.cast_sub hpow]
    ring
  exact hcast ▸ Int.natCast_dvd_natCast.mpr h

/-- 底についての箱に依存しない整除 `a ∣ 2 (c - 1)` から、
閾値の箱の点数乗についての整除 `a ∣ 2 (c^{L₀³} - 1)` を得る。 -/
theorem power_numerator_divisibility_of_base_divisibility
    {q c : ℚ} {L₀ : ℕ} (hc : 0 < c)
    (hbase : q.num.natAbs ∣ 2 * (c.num.natAbs - 1)) :
    (q.num.natAbs : ℤ) ∣ 2 * ((c.num.natAbs : ℤ) ^ (L₀ ^ 3) - 1) := by
  have hcnum : 1 ≤ c.num.natAbs := by
    have : 0 < c.num := Rat.num_pos.mpr hc
    omega
  exact int_dvd_two_mul_pow_sub_one_of_nat hcnum
    (numerator_divides_twice_threshold_box_value_minus_one hcnum hbase rfl)

/-- 束ね定理の外から与える仮定を、箱に依存しない整除 `a ∣ 2 (c - 1)` の
一つだけに減らした版。 -/
theorem eq_one_of_cross_power_identity_from_free_box_base_divisibility
    {q : ℚ} (hq : 0 < q) {L₀ : ℕ} (hL₀ : 2 ≤ L₀)
    (hcross : ∀ L, L₀ ≤ L →
      rationalValueSeq q L ^ ((L + 1) ^ 3) = rationalValueSeq q (L + 1) ^ (L ^ 3))
    (hbaseDvd : ∀ c : ℚ, 0 < c → c.den = 1 →
      (∀ L, L₀ ≤ L → rationalValueSeq q L = c ^ (L ^ 3)) →
      q.num.natAbs ∣ 2 * (c.num.natAbs - 1)) :
    q = 1 := by
  refine eq_one_of_cross_power_identity_from_free_box_numerator_connections
    hq hL₀ hcross hbaseDvd ?_
  intro c hc hcden hform
  exact power_numerator_divisibility_of_base_divisibility hc (hbaseDvd c hc hcden hform)

end Ising3DCut.LimitQuantity
