/-
「二次体の三分律（少なくとも一つ）」の必要十分版。
代数的数・二次体・表示写像を外し、順序環上の係数対について本文と同じ四場合分けだけを残す。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

/-- 本文の正錐を定める三つの係数条件。 -/
def quadraticCoefficientPositiveNecSuf {A : Type} [Ring A] [LinearOrder A]
    [IsStrictOrderedRing A]
    (ab : A × A) : Prop :=
  (0 ≤ ab.1 ∧ 0 ≤ ab.2 ∧ ab ≠ (0, 0)) ∨
  (0 < ab.1 ∧ ab.2 < 0 ∧ 2 * ab.2 * ab.2 < ab.1 * ab.1) ∨
  (ab.1 < 0 ∧ 0 < ab.2 ∧ ab.1 * ab.1 < 2 * ab.2 * ab.2)

/-- 係数対は正・零・加法逆元が正の少なくとも一つに入る。 -/
theorem quadratic_trichotomy_at_least_one_necSuf
    {A : Type} [Ring A] [LinearOrder A] [IsStrictOrderedRing A] (a b : A)
    (hMixed : b ≠ 0 → a * a ≠ 2 * (b * b)) :
    quadraticCoefficientPositiveNecSuf (a, b) ∨
      (a, b) = (0, 0) ∨
      quadraticCoefficientPositiveNecSuf (-a, -b) := by
  by_cases ha : 0 < a
  · by_cases hb : 0 ≤ b
    · exact Or.inl (Or.inl ⟨le_of_lt ha, hb, by
        intro hab
        have := congrArg Prod.fst hab
        simp at this
        exact (ne_of_gt ha) this⟩)
    · have hbNeg : b < 0 := lt_of_not_ge hb
      have hb0 : b ≠ 0 := ne_of_lt hbNeg
      have hne := hMixed hb0
      rcases lt_or_gt_of_ne hne with hlt | hgt
      · right
        right
        right
        right
        refine ⟨neg_lt_zero.mpr ha, neg_pos.mpr hbNeg, ?_⟩
        · calc
            (-a) * (-a) = a * a := by simp
            _ < 2 * (b * b) := hlt
            _ = 2 * (-b) * (-b) := by simp [mul_assoc]
      · left
        right
        left
        exact ⟨ha, hbNeg, by simpa [mul_assoc] using hgt⟩
  · have haNonpos : a ≤ 0 := le_of_not_gt ha
    by_cases hb : b ≤ 0
    · by_cases hab : (a, b) = (0, 0)
      · exact Or.inr (Or.inl hab)
      · right
        right
        left
        exact ⟨neg_nonneg.mpr haNonpos, neg_nonneg.mpr hb, by
          intro hzero
          apply hab
          apply Prod.ext
          · simpa using congrArg Neg.neg (congrArg Prod.fst hzero)
          · simpa using congrArg Neg.neg (congrArg Prod.snd hzero)⟩
    · have hbPos : 0 < b := lt_of_not_ge hb
      by_cases ha0 : a = 0
      · left
        left
        exact ⟨by simpa [ha0], le_of_lt hbPos, by
          intro hab
          have := congrArg Prod.snd hab
          simp at this
          exact (ne_of_gt hbPos) this⟩
      have haNeg : a < 0 := lt_of_le_of_ne haNonpos ha0
      have hb0 : b ≠ 0 := ne_of_gt hbPos
      have hne := hMixed hb0
      rcases lt_or_gt_of_ne hne with hlt | hgt
      · left
        right
        right
        exact ⟨haNeg, hbPos, by simpa [mul_assoc] using hlt⟩
      · right
        right
        right
        left
        refine ⟨neg_pos.mpr haNeg, neg_lt_zero.mpr hbPos, ?_⟩
        calc
          2 * (-b) * (-b) = 2 * (b * b) := by simp [mul_assoc]
          _ < a * a := hgt
          _ = (-a) * (-a) := by simp

end Ising2DLambda.NecSuf.FisherZero
