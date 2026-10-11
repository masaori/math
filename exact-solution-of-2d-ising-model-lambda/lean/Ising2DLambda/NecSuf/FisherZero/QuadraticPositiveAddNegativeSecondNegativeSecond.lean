/-
「負の第二係数条件どうしの和」の必要十分版。
二次体を外し、線形順序環上の係数四つについて具体版と同じ積の平方比較と平方展開を行う。
-/
import Ising2DLambda.NecSuf.FisherZero.RationalSquareLtImpliesLt

namespace Ising2DLambda.NecSuf.FisherZero

set_option maxHeartbeats 800000 in
theorem positive_add_negativeSecond_negativeSecond_necSuf
    {A : Type} [CommRing A] [LinearOrder A] [IsStrictOrderedRing A]
    (a b ap bp : A)
    (ha : 0 < a) (hb : b < 0) (hSq : 2 * b * b < a * a)
    (hap : 0 < ap) (hbp : bp < 0) (hSqp : 2 * bp * bp < ap * ap) :
    0 < a + ap ∧ b + bp < 0 ∧
      2 * (b + bp) * (b + bp) < (a + ap) * (a + ap) := by
  have hSq : 2 * (b * b) < a * a := by simpa only [mul_assoc] using hSq
  have hSqp : 2 * (bp * bp) < ap * ap := by simpa only [mul_assoc] using hSqp
  have hFirstSum : 0 < a + ap := by
    calc
      0 = 0 + 0 := (zero_add 0).symm
      _ < a + ap := add_lt_add ha hap
  have hSecondSum : b + bp < 0 := by
    calc
      b + bp < 0 + 0 := add_lt_add hb hbp
      _ = 0 := zero_add 0
  have hbbp : 0 < b * bp := mul_pos_of_neg_of_neg hb hbp
  have hCrossPos : 0 < 2 * (b * bp) := mul_pos (by norm_num) hbbp
  have hCrossNonneg : 0 ≤ 2 * (b * bp) := le_of_lt hCrossPos
  have haap : 0 < a * ap := mul_pos ha hap
  have hProductNonneg : 0 ≤ a * ap := le_of_lt haap
  have hbpSquare : 0 < bp * bp := mul_pos_of_neg_of_neg hbp hbp
  have hWeightedBpSquare : 0 < 2 * (bp * bp) := mul_pos (by norm_num) hbpSquare
  have haSquare : 0 < a * a := mul_pos ha ha
  have hProductSquare :
      (2 * (b * bp)) * (2 * (b * bp)) < (a * ap) * (a * ap) := by
    calc
      (2 * (b * bp)) * (2 * (b * bp)) =
          (2 * (b * b)) * (2 * (bp * bp)) := by ring
      _ < (a * a) * (2 * (bp * bp)) :=
        mul_lt_mul_of_pos_right hSq hWeightedBpSquare
      _ < (a * a) * (ap * ap) := mul_lt_mul_of_pos_left hSqp haSquare
      _ = (a * ap) * (a * ap) := by ring
  have hCross : 2 * (b * bp) < a * ap :=
    rational_square_lt_implies_lt_necSuf
      (zero := (0 : A)) (mul := (· * ·)) (le := (· ≤ ·)) (lt := (· < ·))
      (p := 2 * (b * bp)) (q := a * ap) hCrossNonneg hProductNonneg hProductSquare
      (fun hq hqp => mul_le_mul_of_nonneg_right hqp hq)
      (fun hp hqp => mul_le_mul_of_nonneg_left hqp hp)
      le_trans lt_of_lt_of_le (lt_irrefl _) lt_of_not_ge
  have hCrossTwice : 2 * (2 * (b * bp)) < 2 * (a * ap) :=
    mul_lt_mul_of_pos_left hCross (by norm_num)
  have hSumSq : 2 * ((b + bp) * (b + bp)) < (a + ap) * (a + ap) := by
    calc
      2 * ((b + bp) * (b + bp)) =
          2 * (b * b) + 2 * (2 * (b * bp)) + 2 * (bp * bp) := by ring
      _ < a * a + 2 * (2 * (b * bp)) + 2 * (bp * bp) := by
        simpa only [add_comm, add_left_comm, add_assoc] using
          (add_lt_add_right (add_lt_add_right hSq (2 * (2 * (b * bp)))) (2 * (bp * bp)))
      _ < a * a + 2 * (a * ap) + 2 * (bp * bp) := by
        simpa only [add_comm, add_left_comm, add_assoc] using
          (add_lt_add_right (add_lt_add_left hCrossTwice (a * a)) (2 * (bp * bp)))
      _ < a * a + 2 * (a * ap) + ap * ap := by
        simpa only [add_comm, add_left_comm, add_assoc] using
          (add_lt_add_left hSqp (a * a + 2 * (a * ap)))
      _ = (a + ap) * (a + ap) := by ring
  refine ⟨hFirstSum, hSecondSum, ?_⟩
  simpa only [mul_assoc] using hSumSq

end Ising2DLambda.NecSuf.FisherZero
