/-
`claim_cut_realization_agrees_on_rationals`（下切断による実現写像は有理数をそのまま実現する）の必要十分版。

具体版と同じ手順（下切断の同値 C_q = {r < q}、ι(q) が上界、稠密性で最小、
前の主張の最小上界との一意性）を、集合 α・有理数の写像 rational・関係 lt だけで書く。
仮定は前の主張の必要十分版と同じ三つだけである。
  - trans: 推移律。r <_R q から r < q を出す段（q < r を排除する）に要る。
  - irrefl: lt u u は成り立たない。q < r と q = r を排除する段に要る。
  - ratLt: 有理数の順序 r < q を lt へ移す。r < q から r ∈ C_q を出す段と、
    前の主張に渡す挟み込み（q − 1 < q < q + 1）を作る段に要る。
前の主張では挟み込みを仮定で受けたが、a = rational q では ratLt から作れるので仮定に置かない。
α に加法・乗法・三分法の網羅性は要らない。
-/
import Ising2DLambda.NecSuf.RealEscape.RealAlgebraicLowerCutSupremum

namespace Ising2DLambda.NecSuf.RealEscape

section

variable {α : Type*} {rational : ℚ → α} {lt : α → α → Prop}

/-- 下切断の同値。 -/
theorem mem_lowerCutImage_rat_necSuf
    (trans : ∀ u v w : α, lt u v → lt v w → lt u w)
    (irrefl : ∀ u : α, ¬ lt u u)
    (ratLt : ∀ q q' : ℚ, q < q' → lt (rational q) (rational q'))
    (q r : ℚ) : (r : ℝ) ∈ lowerCutImage rational lt (rational q) ↔ r < q := by
  constructor
  · rintro ⟨t, ht, hx⟩
    have htr : t = r := (Rat.cast_injective hx).symm
    subst htr
    exact rat_lt_of_lt_necSuf trans irrefl ratLt ht
  · intro h
    exact ⟨r, ratLt r q h, rfl⟩

/-- `ι(q)` は下切断の像の最小上界。 -/
theorem lowerCutImage_rat_isLUB_necSuf
    (trans : ∀ u v w : α, lt u v → lt v w → lt u w)
    (irrefl : ∀ u : α, ¬ lt u u)
    (ratLt : ∀ q q' : ℚ, q < q' → lt (rational q) (rational q'))
    (q : ℚ) : IsLUB (lowerCutImage rational lt (rational q)) (q : ℝ) := by
  refine ⟨?_, ?_⟩
  · rintro x ⟨r, hr, rfl⟩
    exact (Rat.cast_lt.mpr (rat_lt_of_lt_necSuf trans irrefl ratLt hr)).le
  · intro y hy
    by_contra hle
    have hlt := not_le.mp hle
    obtain ⟨r, hyr, hrq⟩ := exists_rat_btwn hlt
    have hmem : (r : ℝ) ∈ lowerCutImage rational lt (rational q) :=
      (mem_lowerCutImage_rat_necSuf trans irrefl ratLt q r).mpr (Rat.cast_lt.mp hrq)
    exact absurd (hy hmem) (not_le.mpr hyr)

/-- 必要十分版: `cutRealization (rational q) = ι(q)`。 -/
theorem cutRealization_agrees_on_rationals_necSuf
    (trans : ∀ u v w : α, lt u v → lt v w → lt u w)
    (irrefl : ∀ u : α, ¬ lt u u)
    (ratLt : ∀ q q' : ℚ, q < q' → lt (rational q) (rational q'))
    (q : ℚ) : cutRealization rational lt (rational q) = (q : ℝ) := by
  have hpinch : ∃ r s : ℚ, lt (rational r) (rational q) ∧ lt (rational q) (rational s) :=
    ⟨q - 1, q + 1, ratLt _ _ (by linarith), ratLt _ _ (by linarith)⟩
  have hρ := (lower_cut_has_supremum_necSuf trans irrefl ratLt (rational q) hpinch).2.2
  exact hρ.unique (lowerCutImage_rat_isLUB_necSuf trans irrefl ratLt q)

end

end Ising2DLambda.NecSuf.RealEscape
