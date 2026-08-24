/-
人手証明「破れ数ゼロの項から点数乗表示の底に合同式の制約が出る」
（ラベル `claim_rational_power_base_congruences`）の Lean 具体版。

人手証明と同じ順で進む。
第一段: 有理数の表示 `P / b^E = (u/v)^N` から整数の等式 `P * v^N = u^N * b^E` を作る。
第二段: `P` を `m = 0` の項と残りへ分け、`m ≥ 1` の項が `a` で割り切れることから
        `P ≡ Ω 0 * b^E [ZMOD a]` を得る。
第三段: 回文性による両端係数の一致 `Ω E = Ω 0` と、`m ≤ E-1` の項が `b` で割り切れることから
        `P ≡ Ω 0 * a^E [ZMOD b]` を得る。
第四段: 二つの合同式を整数の等式へ入れ、`a` と `b` の互いに素性で共通因子を約す。
-/
import Ising3DCut.LimitQuantity.RationalPowerBaseDenominatorPrimes

namespace Ising3DCut.LimitQuantity

open Finset

/-- 人手証明で `P_L` と置いた整数。破れ数 `m` の配位数 `Ω m` に `a^m b^{E-m}` を掛けた有限和。 -/
def brokenCountSum (Ω : ℕ → ℕ) (a b E : ℕ) : ℕ :=
  ∑ m ∈ range (E + 1), Ω m * a ^ m * b ^ (E - m)

/-- 人手証明の第一段。有理数の等式 `P / b^E = (u/v)^N` から整数の等式を作る。 -/
theorem integer_equation_of_rational_representation
    (P b u v E N : ℕ) (hb : 0 < b) (hv : 0 < v)
    (hrep : (P : ℚ) / (b : ℚ) ^ E = ((u : ℚ) / (v : ℚ)) ^ N) :
    (P : ℤ) * (v : ℤ) ^ N = (u : ℤ) ^ N * (b : ℤ) ^ E := by
  have hb0 : (b : ℚ) ≠ 0 := by exact_mod_cast hb.ne'
  have hv0 : (v : ℚ) ≠ 0 := by exact_mod_cast hv.ne'
  have hbE : ((b : ℚ)) ^ E ≠ 0 := pow_ne_zero E hb0
  have hvN : ((v : ℚ)) ^ N ≠ 0 := pow_ne_zero N hv0
  have hQ : (P : ℚ) * (v : ℚ) ^ N = (u : ℚ) ^ N * (b : ℚ) ^ E := by
    rw [div_pow] at hrep
    field_simp at hrep
    linarith [hrep]
  exact_mod_cast hQ

/-- 人手証明の第二段。`m ≥ 1` の項が `a` で割り切れるので、`P` は法 `a` で `m = 0` の項に等しい。 -/
theorem brokenCountSum_modEq_a (Ω : ℕ → ℕ) (a b E : ℕ) :
    (brokenCountSum Ω a b E : ℤ) ≡ (Ω 0 : ℤ) * (b : ℤ) ^ E [ZMOD (a : ℤ)] := by
  have hsplit :
      (brokenCountSum Ω a b E : ℤ)
        = (∑ i ∈ range E, ((Ω (i + 1) : ℤ) * (a : ℤ) ^ (i + 1) * (b : ℤ) ^ (E - (i + 1))))
          + (Ω 0 : ℤ) * (b : ℤ) ^ E := by
    unfold brokenCountSum
    push_cast [Finset.sum_range_succ']
    simp
  have hdvd : (a : ℤ) ∣ ∑ i ∈ range E, ((Ω (i + 1) : ℤ) * (a : ℤ) ^ (i + 1) * (b : ℤ) ^ (E - (i + 1))) := by
    refine Finset.dvd_sum ?_
    intro i _
    have : (a : ℤ) ∣ (a : ℤ) ^ (i + 1) := dvd_pow_self _ (Nat.succ_ne_zero i)
    exact Dvd.dvd.mul_right (Dvd.dvd.mul_left this _) _
  rw [hsplit]
  have hzero : (∑ i ∈ range E, ((Ω (i + 1) : ℤ) * (a : ℤ) ^ (i + 1) * (b : ℤ) ^ (E - (i + 1))))
      ≡ 0 [ZMOD (a : ℤ)] := (Int.modEq_zero_iff_dvd).mpr hdvd
  simpa using hzero.add_right ((Ω 0 : ℤ) * (b : ℤ) ^ E)

/-- 人手証明の第三段。回文性による両端係数の一致 `Ω E = Ω 0` と、`m ≤ E-1` の項が `b` で
割り切れることから、`P` は法 `b` で `m = E` の項に等しい。 -/
theorem brokenCountSum_modEq_b (Ω : ℕ → ℕ) (a b E : ℕ) (hpal : Ω E = Ω 0) :
    (brokenCountSum Ω a b E : ℤ) ≡ (Ω 0 : ℤ) * (a : ℤ) ^ E [ZMOD (b : ℤ)] := by
  have hsplit :
      (brokenCountSum Ω a b E : ℤ)
        = (∑ m ∈ range E, ((Ω m : ℤ) * (a : ℤ) ^ m * (b : ℤ) ^ (E - m)))
          + (Ω 0 : ℤ) * (a : ℤ) ^ E := by
    unfold brokenCountSum
    push_cast [Finset.sum_range_succ]
    simp [hpal]
  have hdvd : (b : ℤ) ∣ ∑ m ∈ range E, ((Ω m : ℤ) * (a : ℤ) ^ m * (b : ℤ) ^ (E - m)) := by
    refine Finset.dvd_sum ?_
    intro m hm
    have hlt : m < E := Finset.mem_range.mp hm
    have hpos : 0 < E - m := Nat.sub_pos_of_lt hlt
    exact Dvd.dvd.mul_left (dvd_pow_self _ hpos.ne') _
  rw [hsplit]
  have hzero : (∑ m ∈ range E, ((Ω m : ℤ) * (a : ℤ) ^ m * (b : ℤ) ^ (E - m)))
      ≡ 0 [ZMOD (b : ℤ)] := (Int.modEq_zero_iff_dvd).mpr hdvd
  simpa using hzero.add_right ((Ω 0 : ℤ) * (a : ℤ) ^ E)

/-- 人手証明の全体。有理数の表示と回文性から、点数乗表示の底が満たす二つの整数条件を得る。 -/
theorem rational_power_base_congruences
    (Ω : ℕ → ℕ) (a b u v E N : ℕ) (hb : 0 < b) (hv : 0 < v) (hE : 1 ≤ E)
    (hab : Nat.Coprime a b) (hpal : Ω E = Ω 0)
    (hrep : (brokenCountSum Ω a b E : ℚ) / (b : ℚ) ^ E = ((u : ℚ) / (v : ℚ)) ^ N) :
    ((Ω 0 : ℤ) * (v : ℤ) ^ N ≡ (u : ℤ) ^ N [ZMOD (a : ℤ)])
      ∧ (b : ℤ) ∣ (Ω 0 : ℤ) * (v : ℤ) ^ N := by
  set P : ℕ := brokenCountSum Ω a b E with hP
  have hint : (P : ℤ) * (v : ℤ) ^ N = (u : ℤ) ^ N * (b : ℤ) ^ E :=
    integer_equation_of_rational_representation P b u v E N hb hv hrep
  have hcopE : IsCoprime ((b : ℤ) ^ E) (a : ℤ) := by
    have h1 : IsCoprime (a : ℤ) (b : ℤ) := Int.isCoprime_iff_gcd_eq_one.mpr (by
      simpa [Int.gcd_natCast_natCast] using hab)
    exact (h1.symm).pow_left
  constructor
  · -- 法 a の合同式
    have h1 : (P : ℤ) * (v : ℤ) ^ N
        ≡ ((Ω 0 : ℤ) * (b : ℤ) ^ E) * (v : ℤ) ^ N [ZMOD (a : ℤ)] :=
      (brokenCountSum_modEq_a Ω a b E).mul_right _
    have h2 : ((Ω 0 : ℤ) * (v : ℤ) ^ N) * (b : ℤ) ^ E
        ≡ ((u : ℤ) ^ N) * (b : ℤ) ^ E [ZMOD (a : ℤ)] := by
      calc ((Ω 0 : ℤ) * (v : ℤ) ^ N) * (b : ℤ) ^ E
          = ((Ω 0 : ℤ) * (b : ℤ) ^ E) * (v : ℤ) ^ N := by ring
        _ ≡ (P : ℤ) * (v : ℤ) ^ N [ZMOD (a : ℤ)] := h1.symm
        _ = (u : ℤ) ^ N * (b : ℤ) ^ E := hint
    -- 合同式の両辺から `b^E` を約す（`a` と `b^E` が互いに素）
    have hdvd : (a : ℤ) ∣ ((u : ℤ) ^ N - (Ω 0 : ℤ) * (v : ℤ) ^ N) * (b : ℤ) ^ E := by
      have := (Int.modEq_iff_dvd).mp h2
      simpa [sub_mul] using this
    exact (Int.modEq_iff_dvd).mpr (hcopE.symm.dvd_of_dvd_mul_right hdvd)
  · -- 法 b の整除
    have hbdvd : (b : ℤ) ∣ (u : ℤ) ^ N * (b : ℤ) ^ E :=
      Dvd.dvd.mul_left (dvd_pow_self _ (by omega : E ≠ 0)) _
    have h1 : (P : ℤ) * (v : ℤ) ^ N
        ≡ ((Ω 0 : ℤ) * (a : ℤ) ^ E) * (v : ℤ) ^ N [ZMOD (b : ℤ)] :=
      (brokenCountSum_modEq_b Ω a b E hpal).mul_right _
    have h0 : (P : ℤ) * (v : ℤ) ^ N ≡ 0 [ZMOD (b : ℤ)] := by
      rw [hint]; exact (Int.modEq_zero_iff_dvd).mpr hbdvd
    have h2 : ((Ω 0 : ℤ) * (v : ℤ) ^ N) * (a : ℤ) ^ E ≡ 0 [ZMOD (b : ℤ)] := by
      calc ((Ω 0 : ℤ) * (v : ℤ) ^ N) * (a : ℤ) ^ E
          = ((Ω 0 : ℤ) * (a : ℤ) ^ E) * (v : ℤ) ^ N := by ring
        _ ≡ (P : ℤ) * (v : ℤ) ^ N [ZMOD (b : ℤ)] := h1.symm
        _ ≡ 0 [ZMOD (b : ℤ)] := h0
    have hdvd2 : (b : ℤ) ∣ ((Ω 0 : ℤ) * (v : ℤ) ^ N) * (a : ℤ) ^ E :=
      (Int.modEq_zero_iff_dvd).mp h2
    have hcopA : IsCoprime ((b : ℤ)) ((a : ℤ) ^ E) := by
      have h1 : IsCoprime (a : ℤ) (b : ℤ) := Int.isCoprime_iff_gcd_eq_one.mpr (by
        simpa [Int.gcd_natCast_natCast] using hab)
      exact (h1.symm).pow_right
    exact (IsCoprime.dvd_of_dvd_mul_right hcopA hdvd2)

end Ising3DCut.LimitQuantity
