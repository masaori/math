/-
「非負係数条件と負の第二係数条件の積」の必要十分版。
二次体を外し、本文の二つの平方比較と四つの符号場合だけを残す。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

theorem positive_mul_nonnegative_negativeSecond_necSuf
    {A : Type} [CommRing A] [LinearOrder A] [IsStrictOrderedRing A]
    (a b ap u : A)
    (ha : 0 ≤ a) (hb : 0 ≤ b)
    (hap : 0 < ap) (hSq : 2 * (u * u) < ap * ap)
    (hUnequal : a * a ≠ 2 * (b * b)) :
    (0 ≤ a * ap - 2 * (b * u) ∧ 0 ≤ b * ap - a * u ∧
      (a * ap - 2 * (b * u), b * ap - a * u) ≠ (0, 0)) ∨
    (0 < a * ap - 2 * (b * u) ∧ b * ap - a * u < 0 ∧
      2 * ((b * ap - a * u) * (b * ap - a * u)) <
        (a * ap - 2 * (b * u)) * (a * ap - 2 * (b * u))) ∨
    (a * ap - 2 * (b * u) < 0 ∧ 0 < b * ap - a * u ∧
      (a * ap - 2 * (b * u)) * (a * ap - 2 * (b * u)) <
        2 * ((b * ap - a * u) * (b * ap - a * u))) := by
  rcases lt_or_gt_of_ne hUnequal with hSecond | hFirst
  · have hbPos : 0 < b := by nlinarith [sq_nonneg a, sq_nonneg b]
    have hBPos : 0 < b * ap - a * u := by
      by_contra hNot
      have hBLe : b * ap ≤ a * u := by nlinarith
      have haPos : 0 < a := by
        by_contra hA
        have haZero : a = 0 := le_antisymm (le_of_not_gt hA) ha
        have hBLeZero : b * ap ≤ 0 := by simpa [haZero] using hBLe
        exact (not_lt_of_ge hBLeZero) (mul_pos hbPos hap)
      have hSquareLe : (b * ap) * (b * ap) ≤ (a * u) * (a * u) := by
        exact mul_self_le_mul_self (mul_nonneg (le_of_lt hbPos) (le_of_lt hap)) hBLe
      have hStrict : 2 * ((a * u) * (a * u)) < (a * a) * (ap * ap) := by
        nlinarith [mul_lt_mul_of_pos_left hSq (mul_pos haPos haPos)]
      have hOpposite : (a * a) * (ap * ap) < 2 * ((b * ap) * (b * ap)) := by
        nlinarith [mul_lt_mul_of_pos_right hSecond (mul_pos hap hap)]
      nlinarith
    by_cases hA : 0 ≤ a * ap - 2 * (b * u)
    · apply Or.inl
      refine ⟨hA, le_of_lt hBPos, ?_⟩
      intro hPair
      exact (ne_of_gt hBPos) (congrArg Prod.snd hPair)
    · apply Or.inr
      apply Or.inr
      have hANeg : a * ap - 2 * (b * u) < 0 := lt_of_not_ge hA
      refine ⟨hANeg, hBPos, ?_⟩
      have hLinear : ap * (2 * (b * u) - a * ap) ≤ (2 * u) * (b * ap - a * u) := by
        nlinarith
      have hLinearNonneg : 0 ≤ ap * (2 * (b * u) - a * ap) :=
        mul_nonneg (le_of_lt hap) (by nlinarith)
      have hSquareLe :
          (ap * (2 * (b * u) - a * ap)) * (ap * (2 * (b * u) - a * ap)) ≤
            ((2 * u) * (b * ap - a * u)) * ((2 * u) * (b * ap - a * u)) := by
        exact mul_self_le_mul_self hLinearNonneg hLinear
      nlinarith [mul_lt_mul_of_pos_right hSq
        (mul_pos (by nlinarith : 0 < b * ap - a * u) (by nlinarith : 0 < b * ap - a * u))]
  · have haPos : 0 < a := by nlinarith [sq_nonneg a, sq_nonneg b]
    have hAPos : 0 < a * ap - 2 * (b * u) := by
      by_contra hNot
      have hALe : a * ap ≤ 2 * (b * u) := by nlinarith
      have hbPos : 0 < b := by
        by_contra hB
        have hbZero : b = 0 := le_antisymm (le_of_not_gt hB) hb
        have hALeZero : a * ap ≤ 0 := by simpa [hbZero] using hALe
        exact (not_lt_of_ge hALeZero) (mul_pos haPos hap)
      have hSquareLe : (a * ap) * (a * ap) ≤ (2 * (b * u)) * (2 * (b * u)) := by
        exact mul_self_le_mul_self (mul_nonneg (le_of_lt haPos) (le_of_lt hap)) hALe
      have hStrict : (2 * (b * b)) * (2 * (u * u)) < (2 * (b * b)) * (ap * ap) :=
        mul_lt_mul_of_pos_left hSq (by positivity)
      nlinarith
    by_cases hB : 0 ≤ b * ap - a * u
    · apply Or.inl
      refine ⟨le_of_lt hAPos, hB, ?_⟩
      intro hPair
      exact (ne_of_gt hAPos) (congrArg Prod.fst hPair)
    · apply Or.inr
      apply Or.inl
      have hBNeg : b * ap - a * u < 0 := lt_of_not_ge hB
      refine ⟨hAPos, hBNeg, ?_⟩
      have hLinear : ap * (a * u - b * ap) ≤ u * (a * ap - 2 * (b * u)) := by
        nlinarith
      have hLinearNonneg : 0 ≤ ap * (a * u - b * ap) :=
        mul_nonneg (le_of_lt hap) (by nlinarith)
      have hSquareLe :
          (ap * (a * u - b * ap)) * (ap * (a * u - b * ap)) ≤
            (u * (a * ap - 2 * (b * u))) * (u * (a * ap - 2 * (b * u))) := by
        exact mul_self_le_mul_self hLinearNonneg hLinear
      nlinarith [mul_lt_mul_of_pos_right hSq
        (mul_pos (by nlinarith : 0 < a * u - b * ap) (by nlinarith : 0 < a * u - b * ap))]

end Ising2DLambda.NecSuf.FisherZero
