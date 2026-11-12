/-
人手証明 `claim_cut_realization_preserves_multiplication`（下切断による実現写像は乗法を保つ）の具体版。

  人手証明                                                         このファイル
  正錐の閉性: 正の元の積は正、正の元と非負の元の和は正               `realAlgebraic_pos_mul`、`realAlgebraic_pos_add_nonneg`
                                                                    （`claim_real_algebraic_rational_bounds` の具体版のファイル）
  0 <_R a <_R B のとき、挟み込みの下側を max(r,0)、上側を min(s,B)
  に取り替えて 0 ≤ r、s ≤ B、r <_R a <_R s、s − r < η                  `realAlgebraic_positive_pinch`
  ab − r_a r_b = a(b − r_b) + r_b(a − r_a) で r_a r_b <_R ab           `realAlgebraic_mul_lower`
  s_a s_b − ab = s_a(s_b − b) + b(s_a − a) で ab <_R s_a s_b           `realAlgebraic_mul_upper`
  ι(r_a r_b) ≤ ρ(ab), ρ(a)ρ(b) ≤ ι(s_a s_b) と
  s_a s_b − r_a r_b = (s_a − r_a)s_b + r_a(s_b − r_b) < η(B_a + B_b)    `cutRealization_mul_close_of_pos`
  B_a, B_b は幅 1 の挟み込みの上側。差が正なら ι(q) が差より小さい q を取り η := q/(B_a + B_b)
  （実数内の有理数の稠密性。ℝ への脱出）                              `cutRealization_preserves_multiplication_of_pos`
  ρ(−x) = −ρ(x)（加法の保存と ρ(0) = 0）                              `cutRealization_neg`
  符号を反転しても等式が保たれる                                      `cutRealization_mul_neg_left`、`cutRealization_mul_neg_right`
  三分法で a, b を零・正・負に分ける                                  `cutRealization_preserves_multiplication`

必要十分版の定理・定義は使わない。
-/
import Ising2DLambda.RealEscape.CutRealizationPreservesAddition

namespace Ising2DLambda.RealEscape

open Ising2DLambda.FisherZero
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.CriticalExponent

/-- 有理数の所属は乗法を保つ（`R` は `Qbar` の部分体）。 -/
theorem realClosedRat_mul (data : RealClosedSubfieldData) (r s : ℚ) :
    realClosedRat data (r * s) = realClosedRat data r * realClosedRat data s := by
  simp only [realClosedRat_eq_cast]
  push_cast
  rfl

/-- 有理数の零の所属は `R` の零。 -/
theorem realClosedRat_zero (data : RealClosedSubfieldData) :
    realClosedRat data 0 = 0 := by
  rw [realClosedRat_eq_cast]
  simp

/-- `0 <_R a <_R B` なら、任意の `η ∈ Q_{>0}` について
`0 ≤ r`、`s ≤ B`、`r <_R a <_R s`、`s − r < η` となる `r, s ∈ Q` がある。 -/
theorem realAlgebraic_positive_pinch (data : RealClosedSubfieldData) {a : data.carrier}
    {B : ℚ} (ha : realAlgebraicLt data 0 a) (hB : realAlgebraicLt data a (realClosedRat data B))
    {η : ℚ} (hη : 0 < η) :
    ∃ r s : ℚ, 0 ≤ r ∧ s ≤ B ∧ realAlgebraicLt data (realClosedRat data r) a ∧
      realAlgebraicLt data a (realClosedRat data s) ∧ s - r < η := by
  -- 有理幅 η の挟み込み（`claim_real_algebraic_rational_pinching`）。
  obtain ⟨r, s, hr, hs, _, hw⟩ := realAlgebraic_rational_pinching data a hη
  refine ⟨max r 0, min s B, le_max_right _ _, min_le_right _ _, ?_, ?_, ?_⟩
  · -- r ≤ 0 なら下側は 0 で 0 <_R a、そうでなければ r <_R a。
    rcases le_total r 0 with h | h
    · rw [max_eq_right h, realClosedRat_zero]
      exact ha
    · rw [max_eq_left h]
      exact hr
  · -- s ≤ B なら上側は s、そうでなければ B で a <_R B。
    rcases le_total s B with h | h
    · rw [min_eq_left h]
      exact hs
    · rw [min_eq_right h]
      exact hB
  · -- s − r を小さくする向きにしか取り替えていない。
    have h1 := le_max_left r 0
    have h2 := min_le_left s B
    linarith

/-- `0 <_R a`、`0 <_R b`、`r_a <_R a`、`r_b <_R b`、`0 ≤ r_b` なら `r_a r_b <_R ab`。
`ab − r_a r_b = a(b − r_b) + r_b(a − r_a)` で、第一項は正、第二項は非負。 -/
theorem realAlgebraic_mul_lower (data : RealClosedSubfieldData) {a b : data.carrier}
    {ra rb : ℚ} (ha : realAlgebraicLt data 0 a)
    (hra : realAlgebraicLt data (realClosedRat data ra) a)
    (hrb : realAlgebraicLt data (realClosedRat data rb) b) (hrb0 : 0 ≤ rb) :
    realAlgebraicLt data (realClosedRat data (ra * rb)) (a * b) := by
  rw [realAlgebraicLt_iff_pos_sub]
  have heq : a * b - realClosedRat data (ra * rb) =
      a * (b - realClosedRat data rb) + realClosedRat data rb * (a - realClosedRat data ra) := by
    rw [realClosedRat_mul]
    ring
  rw [heq]
  apply realAlgebraic_pos_add_nonneg data
  · exact realAlgebraic_pos_mul data ha ((realAlgebraicLt_iff_pos_sub data _ _).mp hrb)
  · apply realAlgebraic_nonneg_mul data
    · rw [realClosedRat_eq_cast]
      exact realAlgebraic_rat_nonneg data hrb0
    · exact Or.inl ((realAlgebraicLt_iff_pos_sub data _ _).mp hra)

/-- `0 <_R b`、`0 < s_a`、`a <_R s_a`、`b <_R s_b` なら `ab <_R s_a s_b`。
`s_a s_b − ab = s_a(s_b − b) + b(s_a − a)` で、二項とも正。 -/
theorem realAlgebraic_mul_upper (data : RealClosedSubfieldData) {a b : data.carrier}
    {sa sb : ℚ} (hb : realAlgebraicLt data 0 b) (hsa0 : 0 < sa)
    (hsa : realAlgebraicLt data a (realClosedRat data sa))
    (hsb : realAlgebraicLt data b (realClosedRat data sb)) :
    realAlgebraicLt data (a * b) (realClosedRat data (sa * sb)) := by
  rw [realAlgebraicLt_iff_pos_sub]
  have heq : realClosedRat data (sa * sb) - a * b =
      realClosedRat data sa * (realClosedRat data sb - b) + b * (realClosedRat data sa - a) := by
    rw [realClosedRat_mul]
    ring
  rw [heq]
  apply realAlgebraic_pos_add data
  · apply realAlgebraic_pos_mul data
    · rw [realClosedRat_eq_cast]
      exact realAlgebraic_rat_pos data hsa0
    · exact (realAlgebraicLt_iff_pos_sub data _ _).mp hsb
  · exact realAlgebraic_pos_mul data hb ((realAlgebraicLt_iff_pos_sub data _ _).mp hsa)

/-- `0 <_R x <_R s` なら `0 < s`（推移律と有理数の順序の反映）。 -/
theorem rat_pos_of_realAlgebraic (data : RealClosedSubfieldData) {x : data.carrier} {s : ℚ}
    (hx : realAlgebraicLt data 0 x) (hs : realAlgebraicLt data x (realClosedRat data s)) :
    0 < s := by
  apply realAlgebraic_lowerCut_lt_of_lt data
  rw [realClosedRat_zero]
  exact realAlgebraicLt_trans data _ _ _ hx hs

/-- 正の二元について、任意の `η ∈ Q_{>0}` で `|ρ(ab) − ρ(a)ρ(b)| < ι(η(B_a + B_b))`。 -/
theorem cutRealization_mul_close_of_pos (data : RealClosedSubfieldData) {a b : data.carrier}
    (ha : realAlgebraicLt data 0 a) (hb : realAlgebraicLt data 0 b) {Ba Bb : ℚ}
    (hBa : realAlgebraicLt data a (realClosedRat data Ba))
    (hBb : realAlgebraicLt data b (realClosedRat data Bb)) {η : ℚ} (hη : 0 < η) :
    |realAlgebraicCutRealization data (a * b) -
        realAlgebraicCutRealization data a * realAlgebraicCutRealization data b|
      < ((η * (Ba + Bb) : ℚ) : ℝ) := by
  obtain ⟨ra, sa, hra0, hsaB, hra, hsa, hwa⟩ := realAlgebraic_positive_pinch data ha hBa hη
  obtain ⟨rb, sb, hrb0, hsbB, hrb, hsb, hwb⟩ := realAlgebraic_positive_pinch data hb hBb hη
  have hsa0 : 0 < sa := rat_pos_of_realAlgebraic data ha hsa
  have hsb0 : 0 < sb := rat_pos_of_realAlgebraic data hb hsb
  -- r_a r_b <_R ab <_R s_a s_b。
  have hlo := realAlgebraic_mul_lower data ha hra hrb hrb0
  have hhi := realAlgebraic_mul_upper data hb hsa0 hsa hsb
  -- 切断の挟み込みを ab, a, b に当てる。
  obtain ⟨h1, h2⟩ := cutRealization_pinch data hlo hhi
  obtain ⟨h3, h4⟩ := cutRealization_pinch data hra hsa
  obtain ⟨h5, h6⟩ := cutRealization_pinch data hrb hsb
  -- 実数の積の単調性（下端が非負）。
  have hra0' : (0 : ℝ) ≤ (ra : ℝ) := Rat.cast_nonneg.mpr hra0
  have hrb0' : (0 : ℝ) ≤ (rb : ℝ) := Rat.cast_nonneg.mpr hrb0
  have hρb0 : (0 : ℝ) ≤ realAlgebraicCutRealization data b := le_trans hrb0' h5
  have hsa0' : (0 : ℝ) ≤ (sa : ℝ) := le_trans (le_trans hra0' h3) h4
  have hlow : (ra : ℝ) * (rb : ℝ) ≤
      realAlgebraicCutRealization data a * realAlgebraicCutRealization data b :=
    mul_le_mul h3 h5 hrb0' (le_trans hra0' h3)
  have hupp : realAlgebraicCutRealization data a * realAlgebraicCutRealization data b ≤
      (sa : ℝ) * (sb : ℝ) :=
    mul_le_mul h4 h6 hρb0 hsa0'
  -- 区間の幅: s_a s_b − r_a r_b = (s_a − r_a)s_b + r_a(s_b − r_b) < η(B_a + B_b)。
  have hras : ra ≤ sa := by
    have := realAlgebraic_lowerCut_lt_of_lt data (realAlgebraicLt_trans data _ _ _ hra hsa)
    linarith
  have hwidth : sa * sb - ra * rb < η * (Ba + Bb) := by
    have e : sa * sb - ra * rb = (sa - ra) * sb + ra * (sb - rb) := by ring
    have t1 : (sa - ra) * sb < η * Bb := by
      calc (sa - ra) * sb < η * sb := mul_lt_mul_of_pos_right hwa hsb0
        _ ≤ η * Bb := mul_le_mul_of_nonneg_left hsbB hη.le
    have t2 : ra * (sb - rb) ≤ Ba * η := by
      calc ra * (sb - rb) ≤ ra * η := mul_le_mul_of_nonneg_left hwb.le hra0
        _ ≤ Ba * η := mul_le_mul_of_nonneg_right (le_trans hras hsaB) hη.le
    rw [e]
    linarith
  have hwidth' : (sa : ℝ) * (sb : ℝ) - (ra : ℝ) * (rb : ℝ) < ((η * (Ba + Bb) : ℚ) : ℝ) := by
    rw [← Rat.cast_mul, ← Rat.cast_mul, ← Rat.cast_sub, Rat.cast_lt]
    exact hwidth
  push_cast at h1 h2
  rw [abs_sub_lt_iff]
  constructor <;> linarith

/-- 正の二元について `ρ(ab) = ρ(a)ρ(b)`。 -/
theorem cutRealization_preserves_multiplication_of_pos (data : RealClosedSubfieldData)
    {a b : data.carrier} (ha : realAlgebraicLt data 0 a) (hb : realAlgebraicLt data 0 b) :
    realAlgebraicCutRealization data (a * b) =
      realAlgebraicCutRealization data a * realAlgebraicCutRealization data b := by
  -- 有理上界 a <_R B_a、b <_R B_b（幅 1 の挟み込みの上側。`claim_real_algebraic_rational_pinching`）。
  obtain ⟨_, Ba, _, hBa, _, _⟩ := realAlgebraic_rational_pinching data a one_pos
  obtain ⟨_, Bb, _, hBb, _, _⟩ := realAlgebraic_rational_pinching data b one_pos
  have hK : 0 < Ba + Bb := by
    have := rat_pos_of_realAlgebraic data ha hBa
    have := rat_pos_of_realAlgebraic data hb hBb
    linarith
  by_contra hne
  have hd : 0 < |realAlgebraicCutRealization data (a * b) -
      realAlgebraicCutRealization data a * realAlgebraicCutRealization data b| :=
    abs_pos.mpr (sub_ne_zero.mpr hne)
  -- 実数内の有理数の稠密性（ℝ への脱出）: 0 < ι(q) < 差。
  obtain ⟨q, hq0, hqd⟩ := exists_rat_btwn hd
  have hq : (0 : ℚ) < q := Rat.cast_pos.mp hq0
  have hclose := cutRealization_mul_close_of_pos data ha hb hBa hBb (η := q / (Ba + Bb))
    (div_pos hq hK)
  have h2 : ((q / (Ba + Bb) * (Ba + Bb) : ℚ) : ℝ) = (q : ℝ) := by
    rw [div_mul_cancel₀ q hK.ne']
  rw [h2] at hclose
  linarith

/-- `ρ(−x) = −ρ(x)`。`ρ(x) + ρ(−x) = ρ(x + (−x)) = ρ(0) = 0`。 -/
theorem cutRealization_neg (data : RealClosedSubfieldData) (x : data.carrier) :
    realAlgebraicCutRealization data (-x) = -realAlgebraicCutRealization data x := by
  have h : realAlgebraicCutRealization data x + realAlgebraicCutRealization data (-x) = 0 := by
    calc realAlgebraicCutRealization data x + realAlgebraicCutRealization data (-x)
        = realAlgebraicCutRealization data (x + -x) :=
          (cutRealization_preserves_addition data x (-x)).symm
      _ = realAlgebraicCutRealization data (realClosedRat data 0) := by
          rw [add_neg_cancel, realClosedRat_zero]
      _ = ((0 : ℚ) : ℝ) := cutRealization_agrees_on_rationals data 0
      _ = 0 := Rat.cast_zero
  linarith

/-- 左の因子の符号を反転しても等式は保たれる。 -/
theorem cutRealization_mul_neg_left (data : RealClosedSubfieldData) {x y : data.carrier}
    (h : realAlgebraicCutRealization data (x * y) =
      realAlgebraicCutRealization data x * realAlgebraicCutRealization data y) :
    realAlgebraicCutRealization data ((-x) * y) =
      realAlgebraicCutRealization data (-x) * realAlgebraicCutRealization data y := by
  calc realAlgebraicCutRealization data ((-x) * y)
      = realAlgebraicCutRealization data (-(x * y)) := by rw [neg_mul]
    _ = -realAlgebraicCutRealization data (x * y) := cutRealization_neg data _
    _ = -(realAlgebraicCutRealization data x * realAlgebraicCutRealization data y) := by rw [h]
    _ = realAlgebraicCutRealization data (-x) * realAlgebraicCutRealization data y := by
        rw [cutRealization_neg data x, neg_mul]

/-- 右の因子の符号を反転しても等式は保たれる。 -/
theorem cutRealization_mul_neg_right (data : RealClosedSubfieldData) {x y : data.carrier}
    (h : realAlgebraicCutRealization data (x * y) =
      realAlgebraicCutRealization data x * realAlgebraicCutRealization data y) :
    realAlgebraicCutRealization data (x * (-y)) =
      realAlgebraicCutRealization data x * realAlgebraicCutRealization data (-y) := by
  calc realAlgebraicCutRealization data (x * (-y))
      = realAlgebraicCutRealization data (-(x * y)) := by rw [mul_neg]
    _ = -realAlgebraicCutRealization data (x * y) := cutRealization_neg data _
    _ = -(realAlgebraicCutRealization data x * realAlgebraicCutRealization data y) := by rw [h]
    _ = realAlgebraicCutRealization data x * realAlgebraicCutRealization data (-y) := by
        rw [cutRealization_neg data y, mul_neg]

/-- 三分法: 各元は零であるか、それ自身か符号を反転したものが正である。 -/
theorem realAlgebraic_zero_or_pos_or_neg_pos (data : RealClosedSubfieldData) (x : data.carrier) :
    x = 0 ∨ realAlgebraicLt data 0 x ∨ realAlgebraicLt data 0 (-x) := by
  rcases (realAlgebraicLt_trichotomy data x 0).1 with h | h | h
  · -- x <_R 0: 0 − x = w·w なので (−x) − 0 = w·w。
    right; right
    obtain ⟨w, hw0, hw⟩ := h
    exact ⟨w, hw0, by rw [← hw]; ring⟩
  · exact Or.inl h
  · exact Or.inr (Or.inl h)

/-- 零の実現は零。 -/
theorem cutRealization_zero (data : RealClosedSubfieldData) :
    realAlgebraicCutRealization data 0 = 0 := by
  rw [← realClosedRat_zero, cutRealization_agrees_on_rationals]
  exact Rat.cast_zero

/-- `claim_cut_realization_preserves_multiplication` の具体版: `ρ(ab) = ρ(a)ρ(b)`。 -/
theorem cutRealization_preserves_multiplication (data : RealClosedSubfieldData)
    (a b : data.carrier) :
    realAlgebraicCutRealization data (a * b) =
      realAlgebraicCutRealization data a * realAlgebraicCutRealization data b := by
  rcases realAlgebraic_zero_or_pos_or_neg_pos data a with ha | ha | ha
  · -- a = 0: 両辺とも零。
    rw [ha, zero_mul, cutRealization_zero, zero_mul]
  · rcases realAlgebraic_zero_or_pos_or_neg_pos data b with hb | hb | hb
    · rw [hb, mul_zero, cutRealization_zero, mul_zero]
    · exact cutRealization_preserves_multiplication_of_pos data ha hb
    · -- b = −(−b)。
      have h := cutRealization_mul_neg_right data
        (cutRealization_preserves_multiplication_of_pos data ha hb)
      rwa [neg_neg] at h
  · rcases realAlgebraic_zero_or_pos_or_neg_pos data b with hb | hb | hb
    · rw [hb, mul_zero, cutRealization_zero, mul_zero]
    · have h := cutRealization_mul_neg_left data
        (cutRealization_preserves_multiplication_of_pos data ha hb)
      rwa [neg_neg] at h
    · have h := cutRealization_mul_neg_right data (cutRealization_mul_neg_left data
        (cutRealization_preserves_multiplication_of_pos data ha hb))
      rwa [neg_neg, neg_neg] at h

end Ising2DLambda.RealEscape
