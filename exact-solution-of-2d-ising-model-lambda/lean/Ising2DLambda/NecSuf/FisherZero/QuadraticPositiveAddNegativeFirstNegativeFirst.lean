/-
「負の第一係数条件どうしの和」の必要十分版。
二次体と有理数の除法を外し、係数の符号・交差項の平方比較・和の平方比較を同じ順で行う。
可換環の法則は平方展開と項の並べ替え、順序と乗法の両立は正の因子による狭義比較、
全順序は既存の平方比較補題の最後の一歩に用いる。
-/
import Ising2DLambda.NecSuf.FisherZero.RationalSquareLtImpliesLt

namespace Ising2DLambda.NecSuf.FisherZero

set_option maxHeartbeats 800000 in
theorem positive_add_negativeFirst_negativeFirst_necSuf
    {A : Type} [CommRing A] [LinearOrder A] [IsStrictOrderedRing A]
    (a b ap bp : A)
    (ha : a < 0) (hb : 0 < b) (hSq : a * a < 2 * b * b)
    (hap : ap < 0) (hbp : 0 < bp) (hSqp : ap * ap < 2 * bp * bp) :
    a + ap < 0 ∧ 0 < b + bp ∧
      (a + ap) * (a + ap) < 2 * (b + bp) * (b + bp) := by
  have hSq : a * a < 2 * (b * b) := by simpa only [mul_assoc] using hSq
  have hSqp : ap * ap < 2 * (bp * bp) := by simpa only [mul_assoc] using hSqp
  -- 本文「第一係数・第二係数の符号」の四行。
  have hFirstSum : a + ap < 0 := by
    calc
      a + ap < 0 + 0 := add_lt_add ha hap
      _ = 0 := zero_add 0
  have hSecondSum : 0 < b + bp := by
    calc
      0 = 0 + 0 := (zero_add 0).symm
      _ < b + bp := add_lt_add hb hbp
  -- 本文「交差項と乗法因子の符号」の八行。
  have haap : 0 < a * ap := mul_pos_of_neg_of_neg ha hap
  have hProductNonneg : 0 ≤ a * ap := le_of_lt haap
  have hbbp : 0 < b * bp := mul_pos hb hbp
  have hCrossPos : 0 < 2 * (b * bp) := mul_pos (by norm_num) hbbp
  have hCrossNonneg : 0 ≤ 2 * (b * bp) := le_of_lt hCrossPos
  have hapSquare : 0 < ap * ap := mul_pos_of_neg_of_neg hap hap
  have hbSquare : 0 < b * b := mul_pos hb hb
  have hWeightedBSquare : 0 < 2 * (b * b) := mul_pos (by norm_num) hbSquare
  -- 本文「交差項の平方比較」の四行。
  have hProductSquare :
      (a * ap) * (a * ap) < (2 * (b * bp)) * (2 * (b * bp)) := by
    calc
      (a * ap) * (a * ap) = (a * a) * (ap * ap) := by ring
      _ < (2 * (b * b)) * (ap * ap) :=
        mul_lt_mul_of_pos_right hSq hapSquare
      _ < (2 * (b * b)) * (2 * (bp * bp)) :=
        mul_lt_mul_of_pos_left hSqp hWeightedBSquare
      _ = (2 * (b * bp)) * (2 * (b * bp)) := by ring
  -- 本文「平方比較補題の適用」と「正の二倍」。
  have hCross : a * ap < 2 * (b * bp) :=
    rational_square_lt_implies_lt_necSuf
      (zero := (0 : A)) (mul := (· * ·)) (le := (· ≤ ·)) (lt := (· < ·))
      (p := a * ap) (q := 2 * (b * bp)) hProductNonneg hCrossNonneg hProductSquare
      (fun hq hqp => mul_le_mul_of_nonneg_right hqp hq)
      (fun hp hqp => mul_le_mul_of_nonneg_left hqp hp)
      le_trans lt_of_lt_of_le (lt_irrefl _) lt_of_not_ge
  have hCrossTwice : 2 * (a * ap) < 2 * (2 * (b * bp)) :=
    mul_lt_mul_of_pos_left hCross (by norm_num)
  -- 本文「和の平方比較」の五行。
  have hSumSq : (a + ap) * (a + ap) < 2 * ((b + bp) * (b + bp)) := by
    calc
      (a + ap) * (a + ap) = a * a + 2 * (a * ap) + ap * ap := by ring
      _ < 2 * (b * b) + 2 * (a * ap) + ap * ap := by
        simpa only [add_comm, add_left_comm, add_assoc] using
          (add_lt_add_right (add_lt_add_right hSq (2 * (a * ap))) (ap * ap))
      _ < 2 * (b * b) + 2 * (2 * (b * bp)) + ap * ap := by
        simpa only [add_comm, add_left_comm, add_assoc] using
          (add_lt_add_right (add_lt_add_left hCrossTwice (2 * (b * b))) (ap * ap))
      _ < 2 * (b * b) + 2 * (2 * (b * bp)) + 2 * (bp * bp) := by
        simpa only [add_comm, add_left_comm, add_assoc] using
          (add_lt_add_left hSqp (2 * (b * b) + 2 * (2 * (b * bp))))
      _ = 2 * ((b + bp) * (b + bp)) := by ring
  refine ⟨hFirstSum, hSecondSum, ?_⟩
  simpa only [mul_assoc] using hSumSq

end Ising2DLambda.NecSuf.FisherZero
