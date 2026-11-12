/-
`claim_real_algebraic_rational_pinching`（実閉部分体の元は任意の有理幅で挟める）の必要十分版。

具体版と同じ手順（n := 2f + 1、J の最大元 j₀、j₀ ≠ Mn、三分法で a < (j₀+1)/n、
(j₀−1)/n < j₀/n ≤ a と推移律）を、標数零の可除環 K と「正」の述語 P だけで書く。
順序は「u < v は P (v − u)」、「u ≤ v は P (v − u) または u = v」として読む。
具体版が使う P の性質は次の四つだけである。
  - posAdd: 正の元の和は正。推移律 (w − u) = (w − v) + (v − u) の段に要る。
  - ratPos: 正の有理数の像は正。(j₀−1)/n < j₀/n を K へ移す段に要る。
  - notPosZero: 零は正でない。j₀ = Mn と仮定して M < M を導いた段の矛盾に要る
    （具体版では三分法の排他性「a < a と a = a は同時に成り立たない」から出る）。
  - trichotomy: 各元は正・零・負（−u が正）のいずれか。(j₀+1)/n ≤ a でないことから
    a < (j₀+1)/n を出す段に要る。排他性は使わない。
Archimedes 性は前の主張（`claim_real_algebraic_archimedean`）の結論として、
この元 a についての仮定 `hlo`・`hhi` で受ける。
積・可換性・平方であることは使わない。K に標数零を置くのは、
有理数の差の像を像の差へ書き換える（`Rat.cast_sub`）ためである。
-/
import Mathlib.Algebra.Order.Field.Basic
import Mathlib.Algebra.Order.Field.Rat
import Mathlib.Data.Int.Interval
import Mathlib.Data.Rat.Cast.CharZero
import Mathlib.Tactic.Abel
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring
import Mathlib.Data.Finset.Max

namespace Ising2DLambda.NecSuf.CriticalExponent

/-- 有理数の順序: `ε = e/f`（`e, f ∈ N_{>0}`）、`n = 2f + 1` なら `0 < 2/n < ε`。 -/
theorem rational_two_div_succ_lt_necSuf {ε : ℚ} (hε : 0 < ε) :
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

section

variable {K : Type*} [DivisionRing K] {P : K → Prop}

/-- 推移律: `P (v − u)` と `P (w − v)` から `P (w − u)`。 -/
theorem pinching_sub_pos_trans_necSuf
    (posAdd : ∀ u v : K, P u → P v → P (u + v))
    {u v w : K} (huv : P (v - u)) (hvw : P (w - v)) : P (w - u) := by
  have h : w - u = (w - v) + (v - u) := by abel
  rw [h]
  exact posAdd _ _ hvw huv

/-- `v ≤ u` と `u < v` は同時に成り立たない（`v < v`、すなわち `P 0` を導いて矛盾）。 -/
theorem not_le_of_lt_necSuf
    (posAdd : ∀ u v : K, P u → P v → P (u + v)) (notPosZero : ¬ P 0)
    {u v : K} (huv : P (v - u)) : ¬ (P (u - v) ∨ v = u) := by
  intro hvu
  apply notPosZero
  rcases hvu with hvu | hvu
  · have h := pinching_sub_pos_trans_necSuf posAdd hvu huv
    rwa [sub_self] at h
  · rw [hvu, sub_self] at huv
    exact huv

/-- 三分法: `s ≤ a` でないなら `a < s`。 -/
theorem lt_of_not_le_necSuf
    (trichotomy : ∀ u : K, P u ∨ u = 0 ∨ P (-u))
    {a s : K} (h : ¬ (P (a - s) ∨ s = a)) : P (s - a) := by
  rcases trichotomy (s - a) with hpos | hzero | hneg
  · exact hpos
  · exact absurd (Or.inr (sub_eq_zero.mp hzero)) h
  · rw [neg_sub] at hneg
    exact absurd (Or.inl hneg) h

/-- `r < b` と `b ≤ a` から `r < a`。 -/
theorem lt_of_lt_of_le_necSuf
    (posAdd : ∀ u v : K, P u → P v → P (u + v))
    {r b a : K} (hrb : P (b - r)) (hba : P (a - b) ∨ b = a) : P (a - r) := by
  rcases hba with hba | hba
  · exact pinching_sub_pos_trans_necSuf posAdd hrb hba
  · rw [← hba]
    exact hrb

/-- 必要十分版の主定理: `a − r` と `s − a` がともに正で `0 < s − r < ε` となる `r, s ∈ Q` がある。 -/
theorem rational_pinching_necSuf [CharZero K]
    (posAdd : ∀ u v : K, P u → P v → P (u + v))
    (ratPos : ∀ q : ℚ, 0 < q → P (q : K))
    (notPosZero : ¬ P 0)
    (trichotomy : ∀ u : K, P u ∨ u = 0 ∨ P (-u))
    (a : K) {M : ℕ} (hlo : P (a - ((-(M : ℚ) : ℚ) : K))) (hhi : P (((M : ℚ) : K) - a))
    {ε : ℚ} (hε : 0 < ε) :
    ∃ r s : ℚ, P (a - (r : K)) ∧ P ((s : K) - a) ∧ 0 < s - r ∧ s - r < ε := by
  classical
  obtain ⟨hwidth0, hwidth⟩ := rational_two_div_succ_lt_necSuf hε
  set n : ℕ := 2 * ε.den + 1 with hndef
  have hnpos : (0 : ℚ) < (n : ℚ) := by positivity
  set J : Finset ℤ := (Finset.Icc (-((M : ℤ) * n)) ((M : ℤ) * n)).filter
    (fun j => P (a - ((((j : ℚ) / n : ℚ)) : K)) ∨ ((((j : ℚ) / n : ℚ)) : K) = a) with hJdef
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
  set j₀ : ℤ := J.max' hne with hj0def
  have hj0mem : j₀ ∈ J := J.max'_mem hne
  rw [hJdef, Finset.mem_filter, Finset.mem_Icc] at hj0mem
  obtain ⟨⟨hj0lo, hj0hi⟩, hj0le⟩ := hj0mem
  -- j₀ ≠ Mn: そうなら M ≤ a < M。
  have hj0ne : j₀ ≠ (M : ℤ) * n := by
    intro heq
    have hq : ((j₀ : ℚ) / n) = (M : ℚ) := by
      rw [heq]
      push_cast
      field_simp
    rw [hq] at hj0le
    exact not_le_of_lt_necSuf posAdd notPosZero hhi hj0le
  have hsucc_not : j₀ + 1 ∉ J := by
    intro hmem
    have := J.le_max' (j₀ + 1) hmem
    rw [← hj0def] at this
    omega
  have hsucc_not_le : ¬ (P (a - (((((j₀ + 1 : ℤ) : ℚ) / n : ℚ)) : K)) ∨
      (((((j₀ + 1 : ℤ) : ℚ) / n : ℚ)) : K) = a) := by
    intro hle
    apply hsucc_not
    rw [hJdef, Finset.mem_filter, Finset.mem_Icc]
    refine ⟨⟨by omega, by omega⟩, hle⟩
  -- a < s（三分法）。
  have has := lt_of_not_le_necSuf trichotomy hsucc_not_le
  -- r < j₀/n（正の有理数の像は正）。
  have hrj : (((j₀ - 1 : ℤ) : ℚ) / n) < ((j₀ : ℚ) / n) := by
    rw [div_lt_div_iff_of_pos_right hnpos]
    push_cast
    linarith
  have hrlt : P ((((j₀ : ℚ) / n : ℚ) : K) - ((((j₀ - 1 : ℤ) : ℚ) / n : ℚ) : K)) := by
    have h : (((j₀ : ℚ) / n : ℚ) : K) - ((((j₀ - 1 : ℤ) : ℚ) / n : ℚ) : K)
        = ((((j₀ : ℚ) / n) - (((j₀ - 1 : ℤ) : ℚ) / n) : ℚ) : K) := by
      push_cast
      rfl
    rw [h]
    exact ratPos _ (sub_pos.mpr hrj)
  -- r < a（推移律）。
  have hra := lt_of_lt_of_le_necSuf posAdd hrlt hj0le
  have hdiff : (((j₀ + 1 : ℤ) : ℚ) / n) - (((j₀ - 1 : ℤ) : ℚ) / n) = (2 : ℚ) / n := by
    push_cast
    field_simp
    ring
  refine ⟨((j₀ - 1 : ℤ) : ℚ) / n, ((j₀ + 1 : ℤ) : ℚ) / n, hra, has, ?_, ?_⟩
  · rw [hdiff]
    exact hwidth0
  · rw [hdiff]
    exact hwidth

end

end Ising2DLambda.NecSuf.CriticalExponent
