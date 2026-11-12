/-
`claim_real_algebraic_lower_cut_has_supremum`（有理下切断は実数上限を持つ）の必要十分版。

具体版と同じ手順（挟み込みの r で非空、t <_R a <_R s と推移律、有理数の三分律で t < s、
包含写像で ι(t) < ι(s)、実数の完備性）を、集合 α・有理数の写像 rational・関係 lt だけで書く。
具体版が使う性質は次の三つだけである。
  - trans: lt の推移律。t < a < s から t < s を出す段と、s < t と t < s から t < t を出す段に要る。
  - irrefl: lt u u は成り立たない。s = t と s < t の場合を排除する段に要る
    （具体版では三分法の排他性から出る）。
  - ratLt: 有理数の順序 q < q' なら lt (rational q) (rational q')。s < t から s < t を α へ移す段に要る
    （具体版では正の有理数の正値性と狭義順序の定義から出る）。
挟み込みは前の主張（`claim_real_algebraic_rational_pinching`）の結論のうち、幅を使わず
下側と上側の存在だけを、この元 a についての仮定 `hpinch` で受ける。
α に加法・乗法・三分法の網羅性は要らない。
-/
import Ising2DLambda.NecSuf.RealEscape.RealAlgebraicCutRealization

namespace Ising2DLambda.NecSuf.RealEscape

section

variable {α : Type*} (rational : ℚ → α) (lt : α → α → Prop)

/-- 有理下切断の実数像。 -/
def lowerCutImage (a : α) : Set ℝ :=
  {x : ℝ | ∃ q : ℚ, lt (rational q) a ∧ x = (q : ℝ)}

theorem cutRealization_eq_sSup_lowerCutImage (a : α) :
    cutRealization rational lt a = sSup (lowerCutImage rational lt a) := rfl

variable {rational lt}

/-- `lt (rational t) (rational s)` なら有理数の順序で `t < s`。 -/
theorem rat_lt_of_lt_necSuf
    (trans : ∀ u v w : α, lt u v → lt v w → lt u w)
    (irrefl : ∀ u : α, ¬ lt u u)
    (ratLt : ∀ q q' : ℚ, q < q' → lt (rational q) (rational q'))
    {t s : ℚ} (hts : lt (rational t) (rational s)) : t < s := by
  rcases lt_trichotomy t s with h | h | h
  · exact h
  · subst h
    exact absurd hts (irrefl _)
  · exact absurd (trans _ _ _ hts (ratLt s t h)) (irrefl _)

/-- 必要十分版: 像は空でなく上に有界で、`cutRealization` はその最小上界である。 -/
theorem lower_cut_has_supremum_necSuf
    (trans : ∀ u v w : α, lt u v → lt v w → lt u w)
    (irrefl : ∀ u : α, ¬ lt u u)
    (ratLt : ∀ q q' : ℚ, q < q' → lt (rational q) (rational q'))
    (a : α) (hpinch : ∃ r s : ℚ, lt (rational r) a ∧ lt a (rational s)) :
    (lowerCutImage rational lt a).Nonempty ∧
      BddAbove (lowerCutImage rational lt a) ∧
      IsLUB (lowerCutImage rational lt a) (cutRealization rational lt a) := by
  obtain ⟨r, s, hr, hs⟩ := hpinch
  have hne : (lowerCutImage rational lt a).Nonempty := ⟨(r : ℝ), r, hr, rfl⟩
  have hbdd : BddAbove (lowerCutImage rational lt a) := by
    refine ⟨(s : ℝ), ?_⟩
    rintro x ⟨t, ht, rfl⟩
    exact (Rat.cast_lt.mpr (rat_lt_of_lt_necSuf trans irrefl ratLt (trans _ _ _ ht hs))).le
  refine ⟨hne, hbdd, ?_⟩
  rw [cutRealization_eq_sSup_lowerCutImage]
  exact Real.isLUB_sSup hne hbdd

end

end Ising2DLambda.NecSuf.RealEscape
