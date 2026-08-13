/-
「負の第二係数条件どうしの積」の必要十分版。
二次体を外し、線形順序可換環上で具体版と同じ正因子による比較・移項・平方展開を行う。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

theorem positive_mul_negativeSecond_negativeSecond_necSuf
    {A : Type} [CommRing A] [LinearOrder A] [IsStrictOrderedRing A]
    (a u ap up : A)
    (ha : 0 < a) (hu : 0 < u) (hSq : 2 * (u * u) < a * a)
    (hap : 0 < ap) (hup : 0 < up) (hSqp : 2 * (up * up) < ap * ap) :
    0 < a * ap + 2 * (u * up) ∧
      -(a * up + u * ap) < 0 ∧
      2 * ((-(a * up + u * ap)) * (-(a * up + u * ap))) <
        (a * ap + 2 * (u * up)) * (a * ap + 2 * (u * up)) := by
  have hAPos : 0 < a * ap + 2 * (u * up) :=
    add_pos (mul_pos ha hap) (by positivity)
  have hVPos : 0 < a * up + u * ap :=
    add_pos (mul_pos ha hup) (mul_pos hu hap)
  let D := a * a - 2 * (u * u)
  have hD : 0 < D := by
    dsimp [D]
    linarith
  have hMiddle : D * (2 * (up * up)) < D * (ap * ap) :=
    mul_lt_mul_of_pos_left hSqp hD
  have hMoved :
      (a * a) * (2 * (up * up)) + (2 * (u * u)) * (ap * ap) <
        (a * a) * (ap * ap) + (2 * (u * u)) * (2 * (up * up)) := by
    dsimp [D] at hMiddle
    nlinarith
  refine ⟨hAPos, neg_neg_of_pos hVPos, ?_⟩
  calc
    2 * ((-(a * up + u * ap)) * (-(a * up + u * ap))) =
        (a * a) * (2 * (up * up)) +
          4 * ((a * ap) * (u * up)) +
          (2 * (u * u)) * (ap * ap) := by ring
    _ < (a * a) * (ap * ap) +
          (2 * (u * u)) * (2 * (up * up)) +
          4 * ((a * ap) * (u * up)) := by
        nlinarith
    _ = (a * ap + 2 * (u * up)) * (a * ap + 2 * (u * up)) := by ring

end Ising2DLambda.NecSuf.FisherZero
