/-
「負の第一係数条件どうしの積」の必要十分版。
二次体を外し、線形順序可換環上で具体版と同じ正因子による比較・移項・平方展開を行う。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

theorem positive_mul_negativeFirst_negativeFirst_necSuf
    {A : Type} [CommRing A] [LinearOrder A] [IsStrictOrderedRing A]
    (c b cp bp : A)
    (hc : 0 < c) (hb : 0 < b) (hSq : c * c < 2 * (b * b))
    (hcp : 0 < cp) (hbp : 0 < bp) (hSqp : cp * cp < 2 * (bp * bp)) :
    0 < c * cp + 2 * (b * bp) ∧
      -(c * bp + b * cp) < 0 ∧
      2 * ((-(c * bp + b * cp)) * (-(c * bp + b * cp))) <
        (c * cp + 2 * (b * bp)) * (c * cp + 2 * (b * bp)) := by
  have hAPos : 0 < c * cp + 2 * (b * bp) :=
    add_pos (mul_pos hc hcp) (by positivity)
  have hVPos : 0 < c * bp + b * cp :=
    add_pos (mul_pos hc hbp) (mul_pos hb hcp)
  let D := 2 * (b * b) - c * c
  have hD : 0 < D := by
    dsimp [D]
    linarith
  have hMiddle : D * (cp * cp) < D * (2 * (bp * bp)) :=
    mul_lt_mul_of_pos_left hSqp hD
  have hMoved :
      (2 * (b * b)) * (cp * cp) + (c * c) * (2 * (bp * bp)) <
        (2 * (b * b)) * (2 * (bp * bp)) + (c * c) * (cp * cp) := by
    dsimp [D] at hMiddle
    nlinarith
  refine ⟨hAPos, neg_neg_of_pos hVPos, ?_⟩
  calc
    2 * ((-(c * bp + b * cp)) * (-(c * bp + b * cp))) =
        (c * c) * (2 * (bp * bp)) +
          4 * ((c * cp) * (b * bp)) +
          (2 * (b * b)) * (cp * cp) := by ring
    _ < (2 * (b * b)) * (2 * (bp * bp)) +
          (c * c) * (cp * cp) +
          4 * ((c * cp) * (b * bp)) := by
        nlinarith
    _ = (c * cp + 2 * (b * bp)) * (c * cp + 2 * (b * bp)) := by ring

end Ising2DLambda.NecSuf.FisherZero
