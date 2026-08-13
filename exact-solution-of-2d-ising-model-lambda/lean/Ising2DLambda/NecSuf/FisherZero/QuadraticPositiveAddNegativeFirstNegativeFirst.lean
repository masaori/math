/-
「負の第一係数条件どうしの和」の必要十分版。
二次体を外し、線形順序環上の係数四つについて具体版と同じ積の平方比較と平方展開を行う。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

set_option maxHeartbeats 800000 in
theorem positive_add_negativeFirst_negativeFirst_necSuf
    {A : Type} [CommRing A] [LinearOrder A] [IsStrictOrderedRing A]
    (a b a' b' : A)
    (ha : a < 0) (hb : 0 < b) (hSq : a * a < 2 * b * b)
    (hap : a' < 0) (hbp : 0 < b') (hSqp : a' * a' < 2 * b' * b') :
    a + a' < 0 ∧ 0 < b + b' ∧
      (a + a') * (a + a') < 2 * (b + b') * (b + b') := by
  have haa' : 0 < a * a' := mul_pos_of_neg_of_neg ha hap
  have hCrossNonneg : 0 ≤ a * a' := le_of_lt haa'
  have hbb' : 0 < b * b' := mul_pos hb hbp
  have hRightNonneg : 0 ≤ 2 * (b * b') := by positivity
  have ha'Square : 0 < a' * a' := mul_pos_of_neg_of_neg hap hap
  have hbSquare : 0 < 2 * b * b := by
    have h : 0 < b * b := mul_pos hb hb
    nlinarith
  have hProductSquare :
      (a * a') * (a * a') < (2 * (b * b')) * (2 * (b * b')) := by
    calc
      (a * a') * (a * a') = (a * a) * (a' * a') := by ring
      _ < (2 * b * b) * (a' * a') := by
        exact mul_lt_mul_of_pos_right hSq ha'Square
      _ < (2 * b * b) * (2 * b' * b') := by
        exact mul_lt_mul_of_pos_left hSqp hbSquare
      _ = (2 * (b * b')) * (2 * (b * b')) := by ring
  have hCross : a * a' < 2 * (b * b') := by
    by_contra hNot
    have hReverse : 2 * (b * b') ≤ a * a' := le_of_not_gt hNot
    have hFirst : (2 * (b * b')) * (2 * (b * b')) ≤ (a * a') * (2 * (b * b')) :=
      mul_le_mul_of_nonneg_right hReverse hRightNonneg
    have hSecond : (a * a') * (2 * (b * b')) ≤ (a * a') * (a * a') :=
      mul_le_mul_of_nonneg_left hReverse hCrossNonneg
    have hReverseSquare : (2 * (b * b')) * (2 * (b * b')) ≤
        (a * a') * (a * a') := le_trans hFirst hSecond
    exact (not_lt_of_ge hReverseSquare) hProductSquare
  have hCrossTwice : 2 * (a * a') < 2 * (2 * (b * b')) :=
    mul_lt_mul_of_pos_left hCross (by norm_num)
  have hFirstAdd :
      a * a + (2 * (a * a') + a' * a') <
        2 * b * b + (2 * (a * a') + a' * a') :=
    by simpa [add_comm] using
      (add_lt_add_right hSq (2 * (a * a') + a' * a'))
  have hCrossAdd :
      2 * b * b + 2 * (a * a') + a' * a' <
        2 * b * b + 2 * (2 * (b * b')) + a' * a' :=
    by simpa [add_comm, add_left_comm, add_assoc] using
      (add_lt_add_right (add_lt_add_left hCrossTwice (2 * b * b)) (a' * a'))
  have hSecondAdd :
      2 * b * b + 2 * (2 * (b * b')) + a' * a' <
        2 * b * b + 2 * (2 * (b * b')) + 2 * b' * b' :=
    by simpa [add_comm, add_left_comm, add_assoc] using
      (add_lt_add_left hSqp (2 * b * b + 2 * (2 * (b * b'))))
  refine ⟨add_neg ha hap, add_pos hb hbp, ?_⟩
  calc
    (a + a') * (a + a') =
        a * a + 2 * (a * a') + a' * a' := by ring
    _ < 2 * b * b + 2 * (a * a') + a' * a' := by
      simpa [add_assoc] using hFirstAdd
    _ < 2 * b * b + 2 * (2 * (b * b')) + a' * a' := hCrossAdd
    _ < 2 * b * b + 2 * (2 * (b * b')) + 2 * b' * b' := hSecondAdd
    _ = 2 * (b + b') * (b + b') := by ring

end Ising2DLambda.NecSuf.FisherZero
