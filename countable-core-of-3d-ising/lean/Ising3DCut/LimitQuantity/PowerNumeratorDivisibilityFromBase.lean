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
import Ising3DCut.LimitQuantity.AdjacentVertexNumberGapsAreCoprime
import Ising3DCut.LimitQuantity.NumeratorDividesTwiceBaseMinusOne
import Ising3DCut.LimitQuantity.NumeratorDividesTwiceThresholdBoxValueMinusOne
import Ising3DCut.LimitQuantity.RationalPowerPointNumeratorDividesTwiceGapPowerMinusOne

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

set_option maxHeartbeats 800000

/-- 末尾の点数乗表示から、底についての箱に依存しない整除を得る。
隣接する三箱の有限合同式を二つの頂点数差へ移し、その二差の互いに素性を使う。 -/
theorem base_divisibility_of_rational_value_form
    {q c : ℚ} {L₀ : ℕ} (hq : 0 < q) (hL₀ : 2 ≤ L₀) (hc : 0 < c)
    (hcden : c.den = 1)
    (hform : ∀ L, L₀ ≤ L → rationalValueSeq q L = c ^ (L ^ 3)) :
    q.num.natAbs ∣ 2 * (c.num.natAbs - 1) := by
  have hcong (L : ℕ) (hL : L₀ ≤ L) :
      Int.ModEq (q.num.natAbs : ℤ) (c.num ^ (L ^ 3))
        (2 * (1 : ℤ) ^ (L ^ 3)) := by
    have hrep := (rational_power_base_congruences
      (NullModel.multiplicity L) q.num.natAbs q.den c.num.natAbs c.den
      (Fintype.card (NullModel.Edge L)) (L ^ 3) q.den_pos c.den_pos
      (one_le_card_edge (le_trans hL₀ hL)) q.reduced
      (by simpa using (NullModel.multiplicity_palindrome (L := L)
        (m := Fintype.card (NullModel.Edge L)) (le_refl _))) (by
          rw [← rationalValueSeq_eq_brokenCountSum_div hq L]
          simpa [Rat.num_div_den, abs_of_pos (Rat.num_pos.mpr hc)] using hform L hL)).1
    rw [NullModel.multiplicity_zero_eq_two (by omega), hcden] at hrep
    simpa [abs_of_pos (Rat.num_pos.mpr hc)] using hrep.symm
  have hgap (L : ℕ) (hL : L₀ ≤ L) :
      (q.num.natAbs : ℤ) ∣
        2 * (c.num ^ vertexNumberGap L - 1) := by
    simpa [vertexNumberGap] using
      (rational_power_point_numerator_divides_twice_gap_power_minus_one
        c q.num.natAbs L hcden (hcong L hL) (hcong (L + 1) (by omega))).2
  have hint : (q.num.natAbs : ℤ) ∣ 2 * (c.num - 1) :=
    numerator_divides_twice_base_minus_one q.num.natAbs c.num
      (by have := Rat.num_pos.mpr hc; omega)
      (vertexNumberGap L₀) (vertexNumberGap (L₀ + 1))
      (by simp [vertexNumberGap]) (by simp [vertexNumberGap])
      (adjacent_vertex_number_gaps_are_coprime L₀) (hgap L₀ (le_refl _))
      (hgap (L₀ + 1) (by omega))
  have hcnum : 0 < c.num := Rat.num_pos.mpr hc
  have hcnumAbs : 1 ≤ c.num.natAbs := by omega
  have hcast : ((2 * (c.num.natAbs - 1) : ℕ) : ℤ) = 2 * (c.num - 1) := by
    push_cast [Nat.cast_sub hcnumAbs]
    rw [abs_of_pos hcnum]
  exact Int.natCast_dvd_natCast.mp (hcast ▸ hint)

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

/-- 有限箱の合同式から残る整除も接続し、冪等式だけから有理点を `1` に定める。 -/
theorem eq_one_of_cross_power_identity_from_free_box_closed
    {q : ℚ} (hq : 0 < q) {L₀ : ℕ} (hL₀ : 2 ≤ L₀)
    (hcross : ∀ L, L₀ ≤ L →
      rationalValueSeq q L ^ ((L + 1) ^ 3) = rationalValueSeq q (L + 1) ^ (L ^ 3)) :
    q = 1 := by
  apply eq_one_of_cross_power_identity_from_free_box_base_divisibility hq hL₀ hcross
  intro c hc hcden hform
  exact base_divisibility_of_rational_value_form hq hL₀ hc hcden hform

end Ising3DCut.LimitQuantity
