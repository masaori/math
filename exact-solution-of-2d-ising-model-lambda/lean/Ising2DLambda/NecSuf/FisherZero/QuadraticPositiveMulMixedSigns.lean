/-
「二つの混合符号条件の積」の必要十分版。
二次体を外し、線形順序可換環上で具体版と同じ正因子による比較・移項・平方展開を行う。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

theorem positive_mul_mixedSigns_necSuf
    {A : Type} [CommRing A] [LinearOrder A] [IsStrictOrderedRing A]
    (a u cp bp : A)
    (ha : 0 < a) (hu : 0 < u) (hSq : 2 * (u * u) < a * a)
    (hcp : 0 < cp) (hbp : 0 < bp) (hSqp : cp * cp < 2 * (bp * bp)) :
    -(a * cp + 2 * (u * bp)) < 0 ∧
      0 < a * bp + u * cp ∧
      (-(a * cp + 2 * (u * bp))) * (-(a * cp + 2 * (u * bp))) <
        2 * ((a * bp + u * cp) * (a * bp + u * cp)) := by
  have hCPos : 0 < a * cp + 2 * (u * bp) :=
    add_pos (mul_pos ha hcp) (by positivity)
  have hBPos : 0 < a * bp + u * cp :=
    add_pos (mul_pos ha hbp) (mul_pos hu hcp)
  let D := a * a - 2 * (u * u)
  have hD : 0 < D := by
    dsimp [D]
    linarith
  have hMiddle : D * (cp * cp) < D * (2 * (bp * bp)) :=
    mul_lt_mul_of_pos_left hSqp hD
  have hMoved :
      (a * a) * (cp * cp) + (2 * (u * u)) * (2 * (bp * bp)) <
        (a * a) * (2 * (bp * bp)) + (2 * (u * u)) * (cp * cp) := by
    dsimp [D] at hMiddle
    nlinarith
  refine ⟨neg_neg_of_pos hCPos, hBPos, ?_⟩
  calc
    (-(a * cp + 2 * (u * bp))) * (-(a * cp + 2 * (u * bp))) =
        (a * a) * (cp * cp) +
          4 * ((a * cp) * (u * bp)) +
          (2 * (u * u)) * (2 * (bp * bp)) := by ring
    _ < (a * a) * (2 * (bp * bp)) +
          (2 * (u * u)) * (cp * cp) +
          4 * ((a * cp) * (u * bp)) := by
        nlinarith
    _ = 2 * ((a * bp + u * cp) * (a * bp + u * cp)) := by ring

end Ising2DLambda.NecSuf.FisherZero
