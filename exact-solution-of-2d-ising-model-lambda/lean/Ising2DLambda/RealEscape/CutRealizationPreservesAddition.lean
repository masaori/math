/-
人手証明 `claim_cut_realization_preserves_addition`（下切断による実現写像は加法を保つ）の具体版。

  人手証明                                                         このファイル
  r <_R x <_R s なら ι(r) ≤ ρ(x)（r ∈ C_x と上限の性質）、
  t ∈ C_x は推移律で t <_R s、三分法の排他性と有理数の三分律で t < s、
  ι(s) は像の上界なので ρ(x) ≤ ι(s)                                  `cutRealization_pinch`
  挟み込みを a, b に当てる                                            `realAlgebraic_rational_pinching`
  r_a + r_b <_R a + r_b <_R a + b <_R a + s_b <_R s_a + s_b
  （狭義順序の定義で差は変わらない、推移律）                          `realAlgebraic_add_pinch`
  A ≤ ρ(a+b) ≤ B、A ≤ ρ(a) + ρ(b) ≤ B、B − A < ι(2ε)                  `cutRealization_add_close`
  差が正なら ι(2ε) が差より小さい ε が取れる（実数内の有理数の稠密性。ℝ への脱出）
                                                                    `cutRealization_preserves_addition`

必要十分版の定理・定義は使わない。
-/
import Ising2DLambda.RealEscape.CutRealizationAgreesOnRationals

namespace Ising2DLambda.RealEscape

open Ising2DLambda.FisherZero
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.CriticalExponent

/-- 切断の挟み込み: `r <_R x <_R s` なら `ι(r) ≤ ρ(x) ≤ ι(s)`。 -/
theorem cutRealization_pinch (data : RealClosedSubfieldData) {x : data.carrier} {r s : ℚ}
    (hr : realAlgebraicLt data (realClosedRat data r) x)
    (hs : realAlgebraicLt data x (realClosedRat data s)) :
    (r : ℝ) ≤ realAlgebraicCutRealization data x ∧
      realAlgebraicCutRealization data x ≤ (s : ℝ) := by
  -- ρ(x) は下切断の像の最小上界（`claim_real_algebraic_lower_cut_has_supremum`）。
  have hlub := (realAlgebraic_lower_cut_has_supremum data x).2.2
  refine ⟨hlub.1 ⟨r, hr, rfl⟩, hlub.2 ?_⟩
  rintro y ⟨t, ht, rfl⟩
  -- t <_R x <_R s と推移律で t <_R s、三分法の排他性と有理数の三分律で t < s。
  exact (Rat.cast_lt.mpr (realAlgebraic_lowerCut_lt_of_lt data
    (realAlgebraicLt_trans data _ _ _ ht hs))).le

/-- 狭義順序の定義: `(v + w) − (u + w) = v − u` なので、`u <_R v` なら `u + w <_R v + w`。 -/
theorem realAlgebraicLt_add_right (data : RealClosedSubfieldData) {u v : data.carrier}
    (w : data.carrier) (h : realAlgebraicLt data u v) :
    realAlgebraicLt data (u + w) (v + w) := by
  obtain ⟨t, ht0, ht⟩ := h
  refine ⟨t, ht0, ?_⟩
  calc v + w - (u + w) = v - u := by ring
    _ = t * t := ht

/-- 狭義順序の定義: `(w + v) − (w + u) = v − u` なので、`u <_R v` なら `w + u <_R w + v`。 -/
theorem realAlgebraicLt_add_left (data : RealClosedSubfieldData) {u v : data.carrier}
    (w : data.carrier) (h : realAlgebraicLt data u v) :
    realAlgebraicLt data (w + u) (w + v) := by
  obtain ⟨t, ht0, ht⟩ := h
  refine ⟨t, ht0, ?_⟩
  calc w + v - (w + u) = v - u := by ring
    _ = t * t := ht

/-- 有理数の所属は加法を保つ（`R` は `Qbar` の部分体）。 -/
theorem realClosedRat_add (data : RealClosedSubfieldData) (r s : ℚ) :
    realClosedRat data (r + s) = realClosedRat data r + realClosedRat data s := by
  simp only [realClosedRat_eq_cast]
  push_cast
  rfl

/-- `r_a <_R a <_R s_a`、`r_b <_R b <_R s_b` なら `r_a + r_b <_R a + b <_R s_a + s_b`。 -/
theorem realAlgebraic_add_pinch (data : RealClosedSubfieldData) {a b : data.carrier}
    {ra sa rb sb : ℚ}
    (hra : realAlgebraicLt data (realClosedRat data ra) a)
    (hsa : realAlgebraicLt data a (realClosedRat data sa))
    (hrb : realAlgebraicLt data (realClosedRat data rb) b)
    (hsb : realAlgebraicLt data b (realClosedRat data sb)) :
    realAlgebraicLt data (realClosedRat data (ra + rb)) (a + b) ∧
      realAlgebraicLt data (a + b) (realClosedRat data (sa + sb)) := by
  rw [realClosedRat_add, realClosedRat_add]
  constructor
  · -- r_a + r_b <_R a + r_b <_R a + b。
    exact realAlgebraicLt_trans data _ _ _
      (realAlgebraicLt_add_right data _ hra) (realAlgebraicLt_add_left data a hrb)
  · -- a + b <_R a + s_b <_R s_a + s_b。
    exact realAlgebraicLt_trans data _ _ _
      (realAlgebraicLt_add_left data a hsb) (realAlgebraicLt_add_right data _ hsa)

/-- 任意の `ε ∈ Q_{>0}` について `|ρ(a+b) − (ρ(a) + ρ(b))| < ι(2ε)`。 -/
theorem cutRealization_add_close (data : RealClosedSubfieldData) (a b : data.carrier)
    {ε : ℚ} (hε : 0 < ε) :
    |realAlgebraicCutRealization data (a + b) -
        (realAlgebraicCutRealization data a + realAlgebraicCutRealization data b)|
      < ((2 * ε : ℚ) : ℝ) := by
  obtain ⟨ra, sa, hra, hsa, _, hwa⟩ := realAlgebraic_rational_pinching data a hε
  obtain ⟨rb, sb, hrb, hsb, _, hwb⟩ := realAlgebraic_rational_pinching data b hε
  obtain ⟨hlo, hhi⟩ := realAlgebraic_add_pinch data hra hsa hrb hsb
  -- A ≤ ρ(a+b) ≤ B。
  obtain ⟨h1, h2⟩ := cutRealization_pinch data hlo hhi
  -- ρ(a), ρ(b) の挟み込み。
  obtain ⟨h3, h4⟩ := cutRealization_pinch data hra hsa
  obtain ⟨h5, h6⟩ := cutRealization_pinch data hrb hsb
  -- B − A = ι((s_a − r_a) + (s_b − r_b)) < ι(2ε)。
  have hw : ((sa + sb : ℚ) : ℝ) - ((ra + rb : ℚ) : ℝ) < ((2 * ε : ℚ) : ℝ) := by
    rw [← Rat.cast_sub, Rat.cast_lt]
    linarith
  push_cast at h1 h2 hw
  rw [abs_sub_lt_iff]
  push_cast
  constructor <;> linarith

/-- `claim_cut_realization_preserves_addition` の具体版: `ρ(a + b) = ρ(a) + ρ(b)`。 -/
theorem cutRealization_preserves_addition (data : RealClosedSubfieldData) (a b : data.carrier) :
    realAlgebraicCutRealization data (a + b) =
      realAlgebraicCutRealization data a + realAlgebraicCutRealization data b := by
  by_contra hne
  have hd : 0 < |realAlgebraicCutRealization data (a + b) -
      (realAlgebraicCutRealization data a + realAlgebraicCutRealization data b)| :=
    abs_pos.mpr (sub_ne_zero.mpr hne)
  -- 実数内の有理数の稠密性（ℝ への脱出）: 0 < ι(q) < 差。
  obtain ⟨q, hq0, hqd⟩ := exists_rat_btwn hd
  have hq : (0 : ℚ) < q := Rat.cast_pos.mp hq0
  have hclose := cutRealization_add_close data a b (ε := q / 2) (by positivity)
  have h2 : ((2 * (q / 2) : ℚ) : ℝ) = (q : ℝ) := by
    rw [show (2 * (q / 2) : ℚ) = q by ring]
  rw [h2] at hclose
  linarith

end Ising2DLambda.RealEscape
