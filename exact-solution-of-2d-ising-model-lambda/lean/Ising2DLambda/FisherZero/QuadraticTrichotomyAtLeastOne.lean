/-
「二次体の三分律（少なくとも一つ）」の具体版。
本文と同じく表示係数の四つの符号の場合に分け、混合符号では平方の大小を二分する。
-/
import Ising2DLambda.FisherZero.QuadraticZeroNegation
import Ising2DLambda.FisherZero.RationalSquareNeDoubleSquare

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_quadratic_trichotomy_at_least_one` の具体版。 -/
theorem quadraticTrichotomyAtLeastOne
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi : QuadraticFieldElement s) :
    xi ∈ quadraticPositiveCone s ∨
      (xi : Qbar) = 0 ∨
      quadraticNegElement s xi ∈ quadraticPositiveCone s := by
  let a := (quadraticRepresentation s xi).1
  let b := (quadraticRepresentation s xi).2
  by_cases ha : 0 < a
  · by_cases hb : 0 ≤ b
    · left
      change quadraticCoefficientPositive (quadraticRepresentation s xi)
      simpa [quadraticCoefficientPositive, a, b] using
        (Or.inl ⟨le_of_lt ha, hb, by
          intro hab
          have := congrArg Prod.fst hab
          simp at this
          exact (ne_of_gt ha) this⟩ : quadraticCoefficientPositive (a, b))
    · have hbNeg : b < 0 := lt_of_not_ge hb
      have hb0 : b ≠ 0 := ne_of_lt hbNeg
      have hne := rationalSquareNeDoubleSquare a b hb0
      rcases lt_or_gt_of_ne hne with hlt | hgt
      · right
        right
        change quadraticCoefficientPositive
          (quadraticRepresentation s (quadraticNegElement s xi))
        rw [quadraticRepresentation_neg s hs xi]
        right
        right
        refine ⟨neg_lt_zero.mpr ha, neg_pos.mpr hbNeg, ?_⟩
        · calc
            (-a) * (-a) = a * a := by ring
            _ < 2 * (b * b) := hlt
            _ = 2 * (-b) * (-b) := by ring
      · left
        change quadraticCoefficientPositive (quadraticRepresentation s xi)
        right
        left
        exact ⟨ha, hbNeg, by simpa [mul_assoc] using hgt⟩
  · have haNonpos : a ≤ 0 := le_of_not_gt ha
    by_cases hb : b ≤ 0
    · by_cases hab : (a, b) = (0, 0)
      · right
        left
        apply (quadraticRepresentation_eq_zero_iff s hs xi).2
        simpa [a, b] using hab
      · right
        right
        change quadraticCoefficientPositive
          (quadraticRepresentation s (quadraticNegElement s xi))
        rw [quadraticRepresentation_neg s hs xi]
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
        change quadraticCoefficientPositive (quadraticRepresentation s xi)
        left
        exact ⟨ha0.ge, le_of_lt hbPos, by
          intro hab
          have := congrArg Prod.snd hab
          simp at this
          exact (ne_of_gt hbPos) this⟩
      have haNeg : a < 0 := lt_of_le_of_ne haNonpos ha0
      have hb0 : b ≠ 0 := ne_of_gt hbPos
      have hne := rationalSquareNeDoubleSquare a b hb0
      rcases lt_or_gt_of_ne hne with hlt | hgt
      · left
        change quadraticCoefficientPositive (quadraticRepresentation s xi)
        right
        right
        exact ⟨haNeg, hbPos, by simpa [mul_assoc] using hlt⟩
      · right
        right
        change quadraticCoefficientPositive
          (quadraticRepresentation s (quadraticNegElement s xi))
        rw [quadraticRepresentation_neg s hs xi]
        right
        left
        refine ⟨neg_pos.mpr haNeg, neg_lt_zero.mpr hbPos, ?_⟩
        calc
          2 * (-b) * (-b) = 2 * (b * b) := by ring
          _ < a * a := hgt
          _ = (-a) * (-a) := by ring

end Ising2DLambda.FisherZero
