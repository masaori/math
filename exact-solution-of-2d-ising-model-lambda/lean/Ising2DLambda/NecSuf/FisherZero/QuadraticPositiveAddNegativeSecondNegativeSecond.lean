/-
「負の第二係数条件どうしの和」の必要十分版。
二次体を外し、線形順序環上の係数四つについて具体版と同じ積の平方比較と平方展開を行う。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

set_option maxHeartbeats 800000 in
theorem positive_add_negativeSecond_negativeSecond_necSuf
    {A : Type} [CommRing A] [LinearOrder A] [IsStrictOrderedRing A]
    (a b a' b' : A)
    (ha : 0 < a) (hb : b < 0) (hSq : 2 * b * b < a * a)
    (hap : 0 < a') (hbp : b' < 0) (hSqp : 2 * b' * b' < a' * a') :
    0 < a + a' ∧ b + b' < 0 ∧
      2 * (b + b') * (b + b') < (a + a') * (a + a') := by
  have hbb' : 0 < b * b' := mul_pos_of_neg_of_neg hb hbp
  have hCrossNonneg : 0 ≤ 2 * (b * b') := by positivity
  have haa' : 0 < a * a' := mul_pos ha hap
  have hb'Square : 0 < 2 * b' * b' := by
    have h : 0 < b' * b' := mul_pos_of_neg_of_neg hbp hbp
    nlinarith
  have haSquare : 0 < a * a := mul_pos ha ha
  have hProductSquare :
      (2 * (b * b')) * (2 * (b * b')) < (a * a') * (a * a') := by
    calc
      (2 * (b * b')) * (2 * (b * b')) =
          (2 * b * b) * (2 * b' * b') := by ring
      _ < (a * a) * (2 * b' * b') := by
        exact mul_lt_mul_of_pos_right hSq hb'Square
      _ < (a * a) * (a' * a') := by
        exact mul_lt_mul_of_pos_left hSqp haSquare
      _ = (a * a') * (a * a') := by ring
  have hCross : 2 * (b * b') < a * a' := by
    by_contra hNot
    have hReverse : a * a' ≤ 2 * (b * b') := le_of_not_gt hNot
    have hFirst : (a * a') * (a * a') ≤ 2 * (b * b') * (a * a') :=
      mul_le_mul_of_nonneg_right hReverse (le_of_lt haa')
    have hSecond : 2 * (b * b') * (a * a') ≤
        2 * (b * b') * (2 * (b * b')) :=
      mul_le_mul_of_nonneg_left hReverse hCrossNonneg
    have hReverseSquare : (a * a') * (a * a') ≤
        (2 * (b * b')) * (2 * (b * b')) := le_trans hFirst hSecond
    exact (not_lt_of_ge hReverseSquare) hProductSquare
  have hCrossTwice : 2 * (2 * (b * b')) < 2 * (a * a') :=
    mul_lt_mul_of_pos_left hCross (by norm_num)
  have hFirstAdd :
      2 * b * b + (2 * (2 * (b * b')) + 2 * b' * b') <
        a * a + (2 * (2 * (b * b')) + 2 * b' * b') :=
    by simpa [add_comm] using
      (add_lt_add_right hSq (2 * (2 * (b * b')) + 2 * b' * b'))
  have hCrossAdd :
      a * a + 2 * (2 * (b * b')) + 2 * b' * b' <
        a * a + 2 * (a * a') + 2 * b' * b' :=
    by simpa [add_comm, add_left_comm, add_assoc] using
      (add_lt_add_right (add_lt_add_left hCrossTwice (a * a)) (2 * b' * b'))
  have hSecondAdd :
      a * a + 2 * (a * a') + 2 * b' * b' <
        a * a + 2 * (a * a') + a' * a' :=
    by simpa [add_comm, add_left_comm, add_assoc] using
      (add_lt_add_left hSqp (a * a + 2 * (a * a')))
  refine ⟨add_pos ha hap, add_neg hb hbp, ?_⟩
  calc
    2 * (b + b') * (b + b') =
        2 * b * b + 2 * (2 * (b * b')) + 2 * b' * b' := by ring
    _ < a * a + 2 * (2 * (b * b')) + 2 * b' * b' := by
      simpa [add_assoc] using hFirstAdd
    _ < a * a + 2 * (a * a') + 2 * b' * b' := hCrossAdd
    _ < a * a + 2 * (a * a') + a' * a' := hSecondAdd
    _ = (a + a') * (a + a') := by ring

end Ising2DLambda.NecSuf.FisherZero
