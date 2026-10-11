/-
「負の第二係数条件どうしの和」の具体版。
本文と同じく、二条件の積から交差項の平方を比較し、既存の平方比較補題で
交差項そのものの大小を取り出してから和の平方を展開する。
-/
import Ising2DLambda.FisherZero.QuadraticAddition
import Ising2DLambda.FisherZero.RationalSquareLtImpliesLt

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

set_option maxHeartbeats 800000 in
theorem quadraticPositive_add_of_negativeSecond_negativeSecond
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi eta : QuadraticFieldElement s)
    (hxi : 0 < (quadraticRepresentation s xi).1 ∧
      (quadraticRepresentation s xi).2 < 0 ∧
      2 * (quadraticRepresentation s xi).2 * (quadraticRepresentation s xi).2 <
        (quadraticRepresentation s xi).1 * (quadraticRepresentation s xi).1)
    (heta : 0 < (quadraticRepresentation s eta).1 ∧
      (quadraticRepresentation s eta).2 < 0 ∧
      2 * (quadraticRepresentation s eta).2 * (quadraticRepresentation s eta).2 <
        (quadraticRepresentation s eta).1 * (quadraticRepresentation s eta).1) :
    quadraticAddElement s xi eta ∈ quadraticPositiveCone s := by
  let a := (quadraticRepresentation s xi).1
  let b := (quadraticRepresentation s xi).2
  let ap := (quadraticRepresentation s eta).1
  let bp := (quadraticRepresentation s eta).2
  have ha : 0 < a := hxi.1
  have hb : b < 0 := hxi.2.1
  have hSq : 2 * (b * b) < a * a := by simpa only [mul_assoc] using hxi.2.2
  have hap : 0 < ap := heta.1
  have hbp : bp < 0 := heta.2.1
  have hSqp : 2 * (bp * bp) < ap * ap := by simpa only [mul_assoc] using heta.2.2
  have hRep : quadraticRepresentation s (quadraticAddElement s xi eta) =
      (a + ap, b + bp) := quadraticRepresentation_add s hs xi eta
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
    rationalSquareLtImpliesLt (2 * (b * bp)) (a * ap)
      hCrossNonneg hProductNonneg hProductSquare
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
  change quadraticCoefficientPositive (quadraticRepresentation s (quadraticAddElement s xi eta))
  rw [hRep]
  apply Or.inr
  apply Or.inl
  refine ⟨hFirstSum, hSecondSum, ?_⟩
  simpa only [mul_assoc] using hSumSq

end Ising2DLambda.FisherZero
