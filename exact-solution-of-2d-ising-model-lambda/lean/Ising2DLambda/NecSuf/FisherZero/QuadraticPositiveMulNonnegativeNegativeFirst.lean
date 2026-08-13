/-
「非負係数条件と負の第一係数条件の積」の必要十分版。
二次体を外し、本文の二つの平方比較と四つの符号場合だけを残す。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

theorem positive_mul_nonnegative_negativeFirst_necSuf
    {A : Type} [CommRing A] [LinearOrder A] [IsStrictOrderedRing A]
    (a b c bp : A)
    (ha : 0 ≤ a) (hb : 0 ≤ b)
    (hbp : 0 < bp) (hSq : c * c < 2 * (bp * bp))
    (hUnequal : a * a ≠ 2 * (b * b)) :
    (0 ≤ 2 * (b * bp) - a * c ∧ 0 ≤ a * bp - b * c ∧
      (2 * (b * bp) - a * c, a * bp - b * c) ≠ (0, 0)) ∨
    (0 < 2 * (b * bp) - a * c ∧ a * bp - b * c < 0 ∧
      2 * ((a * bp - b * c) * (a * bp - b * c)) <
        (2 * (b * bp) - a * c) * (2 * (b * bp) - a * c)) ∨
    (2 * (b * bp) - a * c < 0 ∧ 0 < a * bp - b * c ∧
      (2 * (b * bp) - a * c) * (2 * (b * bp) - a * c) <
        2 * ((a * bp - b * c) * (a * bp - b * c))) := by
  rcases lt_or_gt_of_ne hUnequal with hSecond | hFirst
  · have hbPos : 0 < b := by nlinarith [sq_nonneg a, sq_nonneg b]
    have hAPos : 0 < 2 * (b * bp) - a * c := by
      by_contra hNot
      have hALe : 2 * (b * bp) ≤ a * c := by nlinarith
      have haPos : 0 < a := by
        by_contra hA
        have haZero : a = 0 := le_antisymm (le_of_not_gt hA) ha
        have hALeZero : 2 * (b * bp) ≤ 0 := by simpa [haZero] using hALe
        exact (not_lt_of_ge hALeZero) (by positivity)
      have hSquareLe :
          (2 * (b * bp)) * (2 * (b * bp)) ≤ (a * c) * (a * c) := by
        exact mul_self_le_mul_self (by positivity) hALe
      have hStrict : (a * a) * (c * c) < (a * a) * (2 * (bp * bp)) :=
        mul_lt_mul_of_pos_left hSq (mul_pos haPos haPos)
      nlinarith
    by_cases hB : 0 ≤ a * bp - b * c
    · apply Or.inl
      refine ⟨le_of_lt hAPos, hB, ?_⟩
      intro hPair
      exact (ne_of_gt hAPos) (congrArg Prod.fst hPair)
    · apply Or.inr
      apply Or.inl
      have hBNeg : a * bp - b * c < 0 := lt_of_not_ge hB
      refine ⟨hAPos, hBNeg, ?_⟩
      have hLinear : (2 * bp) * (b * c - a * bp) ≤
          c * (2 * (b * bp) - a * c) := by
        nlinarith
      have hLinearNonneg : 0 ≤ (2 * bp) * (b * c - a * bp) :=
        mul_nonneg (by positivity) (by nlinarith)
      have hSquareLe :
          ((2 * bp) * (b * c - a * bp)) * ((2 * bp) * (b * c - a * bp)) ≤
            (c * (2 * (b * bp) - a * c)) * (c * (2 * (b * bp) - a * c)) :=
        mul_self_le_mul_self hLinearNonneg hLinear
      nlinarith [mul_lt_mul_of_pos_right hSq
        (mul_pos (by nlinarith : 0 < 2 * (b * bp) - a * c)
          (by nlinarith : 0 < 2 * (b * bp) - a * c))]
  · have haPos : 0 < a := by nlinarith [sq_nonneg a, sq_nonneg b]
    have hBPos : 0 < a * bp - b * c := by
      by_contra hNot
      have hBLe : a * bp ≤ b * c := by nlinarith
      have hbPos : 0 < b := by
        by_contra hB
        have hbZero : b = 0 := le_antisymm (le_of_not_gt hB) hb
        have hBLeZero : a * bp ≤ 0 := by simpa [hbZero] using hBLe
        exact (not_lt_of_ge hBLeZero) (mul_pos haPos hbp)
      have hSquareLe : (a * bp) * (a * bp) ≤ (b * c) * (b * c) :=
        mul_self_le_mul_self (mul_nonneg (le_of_lt haPos) (le_of_lt hbp)) hBLe
      have hStrict : (b * b) * (c * c) < (b * b) * (2 * (bp * bp)) :=
        mul_lt_mul_of_pos_left hSq (mul_pos hbPos hbPos)
      nlinarith
    by_cases hA : 0 ≤ 2 * (b * bp) - a * c
    · apply Or.inl
      refine ⟨hA, le_of_lt hBPos, ?_⟩
      intro hPair
      exact (ne_of_gt hBPos) (congrArg Prod.snd hPair)
    · apply Or.inr
      apply Or.inr
      have hANeg : 2 * (b * bp) - a * c < 0 := lt_of_not_ge hA
      refine ⟨hANeg, hBPos, ?_⟩
      have hLinear : bp * (a * c - 2 * (b * bp)) ≤ c * (a * bp - b * c) := by
        nlinarith
      have hLinearNonneg : 0 ≤ bp * (a * c - 2 * (b * bp)) :=
        mul_nonneg (le_of_lt hbp) (by nlinarith)
      have hSquareLe :
          (bp * (a * c - 2 * (b * bp))) * (bp * (a * c - 2 * (b * bp))) ≤
            (c * (a * bp - b * c)) * (c * (a * bp - b * c)) :=
        mul_self_le_mul_self hLinearNonneg hLinear
      nlinarith [mul_lt_mul_of_pos_right hSq
        (mul_pos (by nlinarith : 0 < a * bp - b * c)
          (by nlinarith : 0 < a * bp - b * c))]

end Ising2DLambda.NecSuf.FisherZero
