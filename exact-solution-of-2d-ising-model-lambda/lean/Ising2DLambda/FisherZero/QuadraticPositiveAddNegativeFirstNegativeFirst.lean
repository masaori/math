/-
「負の第一係数条件どうしの和」の具体版。
本文と同じく、二条件の積から交差項の平方を比較し、既存の平方比較補題で
交差項そのものの大小を取り出してから和の平方を展開する。
-/
import Ising2DLambda.FisherZero.QuadraticAddition
import Ising2DLambda.FisherZero.RationalSquareLtImpliesLt

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

set_option maxHeartbeats 800000 in
theorem quadraticPositive_add_of_negativeFirst_negativeFirst
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi eta : QuadraticFieldElement s)
    (hxi : (quadraticRepresentation s xi).1 < 0 ∧
      0 < (quadraticRepresentation s xi).2 ∧
      (quadraticRepresentation s xi).1 * (quadraticRepresentation s xi).1 <
        2 * (quadraticRepresentation s xi).2 * (quadraticRepresentation s xi).2)
    (heta : (quadraticRepresentation s eta).1 < 0 ∧
      0 < (quadraticRepresentation s eta).2 ∧
      (quadraticRepresentation s eta).1 * (quadraticRepresentation s eta).1 <
        2 * (quadraticRepresentation s eta).2 * (quadraticRepresentation s eta).2) :
    quadraticAddElement s xi eta ∈ quadraticPositiveCone s := by
  let a := (quadraticRepresentation s xi).1
  let b := (quadraticRepresentation s xi).2
  let ap := (quadraticRepresentation s eta).1
  let bp := (quadraticRepresentation s eta).2
  have ha : a < 0 := hxi.1
  have hb : 0 < b := hxi.2.1
  have hSq : a * a < 2 * (b * b) := by simpa only [mul_assoc] using hxi.2.2
  have hap : ap < 0 := heta.1
  have hbp : 0 < bp := heta.2.1
  have hSqp : ap * ap < 2 * (bp * bp) := by simpa only [mul_assoc] using heta.2.2
  -- 本文「和の表示」。
  have hRep : quadraticRepresentation s (quadraticAddElement s xi eta) =
      (a + ap, b + bp) := quadraticRepresentation_add s hs xi eta
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
    rationalSquareLtImpliesLt (a * ap) (2 * (b * bp))
      hProductNonneg hCrossNonneg hProductSquare
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
  -- 本文「正錐の第三条件から所属」。
  change quadraticCoefficientPositive (quadraticRepresentation s (quadraticAddElement s xi eta))
  rw [hRep]
  apply Or.inr
  apply Or.inr
  refine ⟨hFirstSum, hSecondSum, ?_⟩
  simpa only [mul_assoc] using hSumSq

end Ising2DLambda.FisherZero
