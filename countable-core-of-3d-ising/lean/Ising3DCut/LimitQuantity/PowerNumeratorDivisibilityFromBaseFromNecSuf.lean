/-
必要十分版 `Ising3DCut.NecSuf.dvd_mul_pow_sub_pow_of_dvd_mul_sub` から、
具体版と同じ結論（閾値の箱の点数乗についての整除）を導く。
具体版が要求している有理数の分子・自然数の引き算は、この抽象版の
特殊化（`R = ℤ`、`k = 2`、`y = 1`）に整数への移送を足したものである。
-/
import Ising3DCut.NecSuf.PowerNumeratorDivisibilityFromBase
import Ising3DCut.LimitQuantity.PowerNumeratorDivisibilityFromBase
import Ising3DCut.LimitQuantity.RationalPowerBaseCongruencesFromNecSuf
import Ising3DCut.LimitQuantity.RationalPowerPointNumeratorDividesTwiceGapPowerMinusOneFromNecSuf
import Ising3DCut.LimitQuantity.NumeratorDividesTwiceBaseMinusOneFromNecSuf
import Ising3DCut.LimitQuantity.AdjacentVertexNumberGapsAreCoprimeFromNecSuf

namespace Ising3DCut.LimitQuantity

/-- 必要十分版からの導出。底についての箱に依存しない整除
`a ∣ 2 (c - 1)` から、点数乗についての整除 `a ∣ 2 (c^{L₀³} - 1)` を得る。 -/
theorem power_numerator_divisibility_of_base_divisibility_fromNecSuf
    {q c : ℚ} {L₀ : ℕ} (hc : 0 < c)
    (hbase : q.num.natAbs ∣ 2 * (c.num.natAbs - 1)) :
    (q.num.natAbs : ℤ) ∣ 2 * ((c.num.natAbs : ℤ) ^ (L₀ ^ 3) - 1) := by
  have hcnum : 1 ≤ c.num.natAbs := by
    have : 0 < c.num := Rat.num_pos.mpr hc
    omega
  have hint : (q.num.natAbs : ℤ) ∣ 2 * ((c.num.natAbs : ℤ) - 1) := by
    have hcast : ((2 * (c.num.natAbs - 1) : ℕ) : ℤ)
        = 2 * ((c.num.natAbs : ℤ) - 1) := by
      push_cast [Nat.cast_sub hcnum]
      ring
    exact hcast ▸ Int.natCast_dvd_natCast.mpr hbase
  simpa using
    NecSuf.dvd_mul_pow_sub_pow_of_dvd_mul_sub (R := ℤ) (L₀ ^ 3) hint

set_option maxHeartbeats 800000

/-- 有限箱の合同式から底についての箱に依存しない整除を得る。
合同式、頂点数差への移送、二差の互いに素性、最大公約数による縮約の
各段を、それぞれの必要十分版から導く。 -/
theorem base_divisibility_of_rational_value_form_viaNecSuf
    {q c : ℚ} {L₀ : ℕ} (hq : 0 < q) (hL₀ : 2 ≤ L₀) (hc : 0 < c)
    (hcden : c.den = 1)
    (hform : ∀ L, L₀ ≤ L → rationalValueSeq q L = c ^ (L ^ 3)) :
    q.num.natAbs ∣ 2 * (c.num.natAbs - 1) := by
  have hcong (L : ℕ) (hL : L₀ ≤ L) :
      Int.ModEq (q.num.natAbs : ℤ) (c.num ^ (L ^ 3))
        (2 * (1 : ℤ) ^ (L ^ 3)) := by
    have hrep := (rational_power_base_congruences_viaNecSuf
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
      (q.num.natAbs : ℤ) ∣ 2 * (c.num ^ vertexNumberGap L - 1) := by
    simpa [vertexNumberGap] using
      (rational_power_point_numerator_divides_twice_gap_power_minus_one_viaNecSuf
        c q.num.natAbs L hcden (hcong L hL) (hcong (L + 1) (by omega))).2
  have hint : (q.num.natAbs : ℤ) ∣ 2 * (c.num - 1) :=
    numerator_divides_twice_base_minus_one_viaNecSuf q.num.natAbs c.num
      (by have := Rat.num_pos.mpr hc; omega)
      (vertexNumberGap L₀) (vertexNumberGap (L₀ + 1))
      (by simp [vertexNumberGap]) (by simp [vertexNumberGap])
      (adjacent_vertex_number_gaps_are_coprime_viaNecSuf L₀)
      (hgap L₀ (le_refl _)) (hgap (L₀ + 1) (by omega))
  have hcnum : 0 < c.num := Rat.num_pos.mpr hc
  have hcnumAbs : 1 ≤ c.num.natAbs := by omega
  have hcast : ((2 * (c.num.natAbs - 1) : ℕ) : ℤ) = 2 * (c.num - 1) := by
    push_cast [Nat.cast_sub hcnumAbs]
    rw [abs_of_pos hcnum]
  exact Int.natCast_dvd_natCast.mp (hcast ▸ hint)

/-- 有限箱の合同式から底の整除を得る必要十分版の導出と、
整除を冨等式の分類へ渡す導出を束ねる。 -/
theorem eq_one_of_cross_power_identity_from_free_box_closed_viaNecSuf
    {q : ℚ} (hq : 0 < q) {L₀ : ℕ} (hL₀ : 2 ≤ L₀)
    (hcross : ∀ L, L₀ ≤ L →
      rationalValueSeq q L ^ ((L + 1) ^ 3) = rationalValueSeq q (L + 1) ^ (L ^ 3)) :
    q = 1 := by
  apply eq_one_of_cross_power_identity_from_free_box_base_divisibility hq hL₀ hcross
  intro c hc hcden hform
  exact base_divisibility_of_rational_value_form_viaNecSuf hq hL₀ hc hcden hform

end Ising3DCut.LimitQuantity
