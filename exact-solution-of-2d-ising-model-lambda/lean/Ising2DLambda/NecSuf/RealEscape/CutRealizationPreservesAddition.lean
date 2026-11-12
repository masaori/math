/-
`claim_cut_realization_preserves_addition`（下切断による実現写像は加法を保つ）の必要十分版。

具体版と同じ手順（切断の挟み込み、a, b の有理挟み込みを足して a + b を挟む、
二つの実数が同じ区間 [A, B] に入り B − A < ι(2ε)、実数内の有理数の稠密性）を、
加法を持つ集合 α・有理数の写像 rational・関係 lt だけで書く。仮定は次のとおりである。
  - trans, irrefl, ratLt: 前の主張（下切断の上限）と同じ。切断の挟み込みの上側に要る。
  - addRight, addLeft: 不等式の両辺に同じ元を右・左から足しても lt が保たれる。
    r_a + r_b < a + r_b < a + b と a + b < a + s_b < s_a + s_b を作る段に要る
    （具体版では狭義順序の定義で差が変わらないことから出る）。α の加法の可換性は使わないので、
    右と左を別々に仮定する。
  - ratAdd: rational は有理数の加法を保つ。足した下側・上側を一つの有理数の像として読む段に要る。
  - hpa, hpb: a, b の任意の正の有理幅での挟み込み（`claim_real_algebraic_rational_pinching` の結論）。
    下側が上側より小さいこと（0 < s − r）は使わないので、仮定に入れない。
α に零・加法逆元・乗法・三分法の網羅性は要らない。
-/
import Ising2DLambda.NecSuf.RealEscape.CutRealizationAgreesOnRationals

namespace Ising2DLambda.NecSuf.RealEscape

section

variable {α : Type*} [Add α] {rational : ℚ → α} {lt : α → α → Prop}

omit [Add α] in
/-- 切断の挟み込み。 -/
theorem cutRealization_pinch_necSuf
    (trans : ∀ u v w : α, lt u v → lt v w → lt u w)
    (irrefl : ∀ u : α, ¬ lt u u)
    (ratLt : ∀ q q' : ℚ, q < q' → lt (rational q) (rational q'))
    {x : α} {r s : ℚ} (hr : lt (rational r) x) (hs : lt x (rational s)) :
    (r : ℝ) ≤ cutRealization rational lt x ∧ cutRealization rational lt x ≤ (s : ℝ) := by
  have hlub := (lower_cut_has_supremum_necSuf trans irrefl ratLt x ⟨r, s, hr, hs⟩).2.2
  refine ⟨hlub.1 ⟨r, hr, rfl⟩, hlub.2 ?_⟩
  rintro y ⟨t, ht, rfl⟩
  exact (Rat.cast_lt.mpr (rat_lt_of_lt_necSuf trans irrefl ratLt (trans _ _ _ ht hs))).le

/-- 必要十分版: `cutRealization (a + b) = cutRealization a + cutRealization b`。 -/
theorem cutRealization_preserves_addition_necSuf
    (trans : ∀ u v w : α, lt u v → lt v w → lt u w)
    (irrefl : ∀ u : α, ¬ lt u u)
    (ratLt : ∀ q q' : ℚ, q < q' → lt (rational q) (rational q'))
    (addRight : ∀ u v w : α, lt u v → lt (u + w) (v + w))
    (addLeft : ∀ u v w : α, lt u v → lt (w + u) (w + v))
    (ratAdd : ∀ r s : ℚ, rational (r + s) = rational r + rational s)
    (a b : α)
    (hpa : ∀ ε : ℚ, 0 < ε → ∃ r s : ℚ, lt (rational r) a ∧ lt a (rational s) ∧ s - r < ε)
    (hpb : ∀ ε : ℚ, 0 < ε → ∃ r s : ℚ, lt (rational r) b ∧ lt b (rational s) ∧ s - r < ε) :
    cutRealization rational lt (a + b) =
      cutRealization rational lt a + cutRealization rational lt b := by
  have hclose : ∀ ε : ℚ, 0 < ε →
      |cutRealization rational lt (a + b) -
          (cutRealization rational lt a + cutRealization rational lt b)| < ((2 * ε : ℚ) : ℝ) := by
    intro ε hε
    obtain ⟨ra, sa, hra, hsa, hwa⟩ := hpa ε hε
    obtain ⟨rb, sb, hrb, hsb, hwb⟩ := hpb ε hε
    have hlo : lt (rational (ra + rb)) (a + b) := by
      rw [ratAdd]
      exact trans _ _ _ (addRight _ _ _ hra) (addLeft _ _ a hrb)
    have hhi : lt (a + b) (rational (sa + sb)) := by
      rw [ratAdd]
      exact trans _ _ _ (addLeft _ _ a hsb) (addRight _ _ _ hsa)
    obtain ⟨h1, h2⟩ := cutRealization_pinch_necSuf trans irrefl ratLt hlo hhi
    obtain ⟨h3, h4⟩ := cutRealization_pinch_necSuf trans irrefl ratLt hra hsa
    obtain ⟨h5, h6⟩ := cutRealization_pinch_necSuf trans irrefl ratLt hrb hsb
    have hw : ((sa + sb : ℚ) : ℝ) - ((ra + rb : ℚ) : ℝ) < ((2 * ε : ℚ) : ℝ) := by
      rw [← Rat.cast_sub, Rat.cast_lt]
      linarith
    push_cast at h1 h2 hw
    rw [abs_sub_lt_iff]
    push_cast
    constructor <;> linarith
  by_contra hne
  have hd : 0 < |cutRealization rational lt (a + b) -
      (cutRealization rational lt a + cutRealization rational lt b)| :=
    abs_pos.mpr (sub_ne_zero.mpr hne)
  obtain ⟨q, hq0, hqd⟩ := exists_rat_btwn hd
  have hq : (0 : ℚ) < q := Rat.cast_pos.mp hq0
  have h := hclose (q / 2) (by positivity)
  have h2 : ((2 * (q / 2) : ℚ) : ℝ) = (q : ℝ) := by
    rw [show (2 * (q / 2) : ℚ) = q by ring]
  rw [h2] at h
  linarith

end

end Ising2DLambda.NecSuf.RealEscape
