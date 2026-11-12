/-
人手証明 `claim_real_algebraic_rational_pinching`（実閉部分体の元は任意の有理幅で挟める）の具体版。

  人手証明                                                         このファイル
  −M <_R a <_R M となる M ∈ N_{>0}（Archimedes 性）                  `realAlgebraic_archimedean`
  ε = e/f、n := 2f + 1、0 < 2/n < ε（有理数の順序）                    `rational_two_div_succ_lt`
  J := {j ∈ Z : −Mn ≤ j ≤ Mn, j/n ≤_R a}、−Mn ∈ J、j₀ := max J         本定理の冒頭
  j₀ ≠ Mn（M ≤_R a <_R M から M <_R M、三分法の排他性に反する）       `realAlgebraic_not_le_of_lt`
  a <_R (j₀+1)/n（最大性で (j₀+1)/n ≤_R a でなく、三分法）            `realAlgebraic_lt_of_not_le`
  r <_R j₀/n（狭義順序の定義と正の有理数の正値性）                     `realAlgebraic_rat_lt_of_sub_pos`
  r <_R a（j₀/n ≤_R a の二つの場合と推移律）                           `realAlgebraic_lt_of_lt_of_le`
  s − r = 2/n、0 < s − r < ε                                           本定理の末尾

必要十分版の定理・定義は使わない。住処: Q と Qbar（実閉部分体 R ⊂ Qbar）。実数体・複素数体は現れない。
-/
import Ising2DLambda.CriticalExponent.RealAlgebraicArchimedean
import Mathlib.Data.Int.Interval

namespace Ising2DLambda.CriticalExponent

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero

/-- 有理数の順序: `ε = e/f`（`e, f ∈ N_{>0}`）、`n = 2f + 1` なら `0 < 2/n < ε`。 -/
theorem rational_two_div_succ_lt {ε : ℚ} (hε : 0 < ε) :
    0 < (2 : ℚ) / ((2 * ε.den + 1 : ℕ) : ℚ) ∧ (2 : ℚ) / ((2 * ε.den + 1 : ℕ) : ℚ) < ε := by
  have hf : (0 : ℚ) < (ε.den : ℚ) := by exact_mod_cast ε.den_pos
  have he : (1 : ℚ) ≤ (ε.num : ℚ) := by exact_mod_cast Rat.num_pos.mpr hε
  have hn : ((2 * ε.den + 1 : ℕ) : ℚ) = 2 * (ε.den : ℚ) + 1 := by push_cast; ring
  rw [hn]
  have hn0 : (0 : ℚ) < 2 * (ε.den : ℚ) + 1 := by linarith
  refine ⟨div_pos (by norm_num) hn0, ?_⟩
  calc (2 : ℚ) / (2 * (ε.den : ℚ) + 1)
      < 1 / (ε.den : ℚ) := by
        rw [div_lt_div_iff₀ hn0 hf]
        linarith
    _ ≤ (ε.num : ℚ) / (ε.den : ℚ) := div_le_div_of_nonneg_right he hf.le
    _ = ε := Rat.num_div_den ε

/-- 三分法の排他性: `v ≤_R u` と `u <_R v` は同時に成り立たない（`v <_R v` を導いて矛盾）。 -/
theorem realAlgebraic_not_le_of_lt (data : RealClosedSubfieldData) {u v : data.carrier}
    (huv : realAlgebraicLt data u v) : ¬ realAlgebraicLe data v u := by
  intro hvu
  have hvv : realAlgebraicLt data v v := by
    rcases hvu with hvu | hvu
    · exact realAlgebraicLt_trans data v u v hvu huv
    · rw [hvu] at huv ⊢
      exact huv
  exact (realAlgebraicLt_trichotomy data v v).2.1 ⟨hvv, rfl⟩

/-- 三分法: `s ≤_R a` でないなら `a <_R s`。 -/
theorem realAlgebraic_lt_of_not_le (data : RealClosedSubfieldData) {a s : data.carrier}
    (h : ¬ realAlgebraicLe data s a) : realAlgebraicLt data a s := by
  rcases (realAlgebraicLt_trichotomy data a s).1 with has | has | hsa
  · exact has
  · exact absurd (Or.inr has.symm) h
  · exact absurd (Or.inl hsa) h

/-- `r <_R b` と `b ≤_R a` から `r <_R a`（等しい場合は書き換え、狭義の場合は推移律）。 -/
theorem realAlgebraic_lt_of_lt_of_le (data : RealClosedSubfieldData) {r b a : data.carrier}
    (hrb : realAlgebraicLt data r b) (hba : realAlgebraicLe data b a) :
    realAlgebraicLt data r a := by
  rcases hba with hba | hba
  · exact realAlgebraicLt_trans data r b a hrb hba
  · rw [← hba]
    exact hrb

/-- `claim_real_algebraic_rational_pinching` の具体版:
`r <_R a <_R s` かつ `0 < s − r < ε` となる `r, s ∈ Q` がある。 -/
theorem realAlgebraic_rational_pinching (data : RealClosedSubfieldData) (a : data.carrier)
    {ε : ℚ} (hε : 0 < ε) :
    ∃ r s : ℚ, realAlgebraicLt data (realClosedRat data r) a ∧
      realAlgebraicLt data a (realClosedRat data s) ∧ 0 < s - r ∧ s - r < ε := by
  classical
  -- Archimedes 性: −M <_R a <_R M。
  obtain ⟨M, _, hlo, hhi⟩ := realAlgebraic_archimedean data a
  -- ε = e/f、n := 2f + 1、0 < 2/n < ε。
  obtain ⟨hwidth0, hwidth⟩ := rational_two_div_succ_lt hε
  set n : ℕ := 2 * ε.den + 1 with hndef
  have hnpos : (0 : ℚ) < (n : ℚ) := by positivity
  have hnne : (n : ℚ) ≠ 0 := hnpos.ne'
  -- J := {j ∈ Z : −Mn ≤ j ≤ Mn, j/n ≤_R a}。
  set J : Finset ℤ := (Finset.Icc (-((M : ℤ) * n)) ((M : ℤ) * n)).filter
    (fun j => realAlgebraicLe data (realClosedRat data ((j : ℚ) / n)) a) with hJdef
  -- −Mn ∈ J（−Mn/n = −M と −M <_R a）。
  have hbottom : -((M : ℤ) * n) ∈ J := by
    rw [hJdef, Finset.mem_filter, Finset.mem_Icc]
    have hMn : (0 : ℤ) ≤ (M : ℤ) * n := by positivity
    refine ⟨⟨le_refl _, by omega⟩, ?_⟩
    have hq : (((-((M : ℤ) * n) : ℤ) : ℚ) / n) = -(M : ℚ) := by
      push_cast
      field_simp
    rw [hq]
    exact Or.inl hlo
  have hne : J.Nonempty := ⟨_, hbottom⟩
  -- j₀ := max J。
  set j₀ : ℤ := J.max' hne with hj0def
  have hj0mem : j₀ ∈ J := J.max'_mem hne
  rw [hJdef, Finset.mem_filter, Finset.mem_Icc] at hj0mem
  obtain ⟨⟨hj0lo, hj0hi⟩, hj0le⟩ := hj0mem
  -- j₀ ≠ Mn: そうなら M ≤_R a <_R M。
  have hj0ne : j₀ ≠ (M : ℤ) * n := by
    intro heq
    have hq : ((j₀ : ℚ) / n) = (M : ℚ) := by
      rw [heq]
      push_cast
      field_simp
    rw [hq] at hj0le
    exact realAlgebraic_not_le_of_lt data hhi hj0le
  -- j₀ + 1 は区間に入り、最大性から J に入らない。
  have hsucc_not : j₀ + 1 ∉ J := by
    intro hmem
    have := J.le_max' (j₀ + 1) hmem
    rw [← hj0def] at this
    omega
  have hsucc_not_le :
      ¬ realAlgebraicLe data (realClosedRat data (((j₀ + 1 : ℤ) : ℚ) / n)) a := by
    intro hle
    apply hsucc_not
    rw [hJdef, Finset.mem_filter, Finset.mem_Icc]
    refine ⟨⟨by omega, by omega⟩, hle⟩
  -- a <_R s（三分法）。
  have has : realAlgebraicLt data a (realClosedRat data (((j₀ + 1 : ℤ) : ℚ) / n)) :=
    realAlgebraic_lt_of_not_le data hsucc_not_le
  -- r <_R j₀/n（狭義順序の定義と正の有理数の正値性）。
  have hrj : (((j₀ - 1 : ℤ) : ℚ) / n) < ((j₀ : ℚ) / n) := by
    rw [div_lt_div_iff_of_pos_right hnpos]
    push_cast
    linarith
  have hrlt : realAlgebraicLt data (realClosedRat data (((j₀ - 1 : ℤ) : ℚ) / n))
      (realClosedRat data ((j₀ : ℚ) / n)) :=
    realAlgebraic_rat_lt_of_sub_pos data (realAlgebraic_rat_sub_pos data hrj)
  -- r <_R a。
  have hra := realAlgebraic_lt_of_lt_of_le data hrlt hj0le
  -- s − r = 2/n。
  have hdiff : (((j₀ + 1 : ℤ) : ℚ) / n) - (((j₀ - 1 : ℤ) : ℚ) / n) = (2 : ℚ) / n := by
    push_cast
    field_simp
    ring
  refine ⟨((j₀ - 1 : ℤ) : ℚ) / n, ((j₀ + 1 : ℤ) : ℚ) / n, hra, has, ?_, ?_⟩
  · rw [hdiff]
    exact hwidth0
  · rw [hdiff]
    exact hwidth

end Ising2DLambda.CriticalExponent
