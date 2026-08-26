/-
人手証明「有理点 2 では点数乗表示は末尾で成り立たない」
（ラベル `claim_eventual_power_form_at_two_is_impossible`）の Lean 具体版。

有限箱値を多重度の有限和として自然数内に置き、破れ数 0 と 1 の項を分ける。
残りの各項は 4 で割れるため有限箱値は法 4 で 2 である。一方、指数が 2 以上の
正の自然数乗は、底が奇数なら奇数、偶数なら 4 で割れるので、法 4 で 2 にはならない。

住処は自然数と有限和だけである。箱の大きさの極限、上限、下限、積分、微分、
無限和、級数、指数関数、実対数は使わない。
-/
import Mathlib.Algebra.BigOperators.ModEq
import Ising3DCut.LimitQuantity.SiteCountIndependentOfQ
import Ising3DCut.NullModel.ZeroBreakageConstant
import Ising3DCut.NullModel.SquareAroundEdge

namespace Ising3DCut.LimitQuantity

open Finset NullModel

/-- 有理点 2 での有限箱値を、整数係数多項式の自然数値として書いた有限和。 -/
noncomputable def partitionValueAtTwoNat (L : ℕ) : ℕ :=
  ∑ m ∈ range (Fintype.card (Edge L) + 1), multiplicity L m * 2 ^ m

/-- 人手証明の最初の三行。`L ≥ 2` なら破れ数 0 の項は 2、破れ数 1 の項は 0、
それより後の項はすべて 4 で割れるので、有限箱値は法 4 で 2 である。 -/
theorem partitionValueAtTwoNat_mod_four {L : ℕ} (hL : 2 ≤ L) :
    partitionValueAtTwoNat L % 4 = 2 := by
  have hzero : multiplicity L 0 = 2 := multiplicity_zero_eq_two (by omega)
  have hone : multiplicity L 1 = 0 := by
    rw [multiplicity, Fintype.card_eq_zero_iff]
    constructor
    intro σ
    exact brokenCount_ne_one hL σ.1 ((Finset.mem_filter.mp σ.2).2)
  have hcong :
      (∑ m ∈ range (Fintype.card (Edge L) + 1), multiplicity L m * 2 ^ m)
        ≡ multiplicity L 0 * 2 ^ 0 [MOD 4] := by
    apply Nat.sum_modEq_single
    · intro hnotmem
      exact absurd (Finset.mem_range.mpr (by omega)) hnotmem
    · intro m hm hm0
      rcases m with _ | m
      · exact absurd rfl hm0
      · rcases m with _ | m
        · simpa [hone] using (Nat.ModEq.refl 0)
        · apply Nat.modEq_zero_iff_dvd.mpr
          exact Dvd.dvd.mul_left (pow_dvd_pow 2 (by omega : 2 ≤ m + 2)) _
  simpa [partitionValueAtTwoNat, hzero, Nat.ModEq] using hcong

/-- 指数が 2 以上の正の自然数乗は法 4 で 2 にはならない。 -/
theorem positive_power_ne_two_mod_four {c n : ℕ} (hc : 0 < c) (hn : 2 ≤ n) :
    c ^ n % 4 ≠ 2 := by
  rcases Nat.even_or_odd c with heven | hodd
  · obtain ⟨d, rfl⟩ := heven
    have hadd : d + d = 2 * d := by omega
    rw [hadd]
    have hfour : 4 ∣ (2 * d) ^ n := by
      exact (show 4 ∣ (2 * d) ^ 2 from ⟨d ^ 2, by ring⟩).trans
        (pow_dvd_pow (2 * d) hn)
    rw [Nat.dvd_iff_mod_eq_zero.mp hfour]
    norm_num
  · have hoddPow : Odd (c ^ n) := hodd.pow
    intro hmod
    have : Even (c ^ n) := Nat.even_iff.mpr (by omega)
    exact (Nat.not_even_iff_odd.mpr hoddPow) this

/-- `claim_eventual_power_form_at_two_is_impossible` の具体版。 -/
theorem eventual_power_form_at_two_is_impossible :
    ¬ ∃ L₀ c : ℕ, 0 < L₀ ∧ 0 < c ∧
      ∀ L, L₀ ≤ L → partitionValueAtTwoNat L = c ^ Fintype.card (Site L) := by
  rintro ⟨L₀, c, hL₀, hc, hpower⟩
  let L := max L₀ 2
  have hL₀L : L₀ ≤ L := le_max_left _ _
  have hL2 : 2 ≤ L := le_max_right _ _
  have hcount : Fintype.card (Site L) = L ^ 3 := card_site L
  have hexponent : 2 ≤ Fintype.card (Site L) := by
    rw [hcount]
    calc
      2 ≤ 2 ^ 3 := by norm_num
      _ ≤ L ^ 3 := Nat.pow_le_pow_left hL2 3
  have hmod := partitionValueAtTwoNat_mod_four hL2
  rw [hpower L hL₀L] at hmod
  exact positive_power_ne_two_mod_four hc hexponent hmod

end Ising3DCut.LimitQuantity
