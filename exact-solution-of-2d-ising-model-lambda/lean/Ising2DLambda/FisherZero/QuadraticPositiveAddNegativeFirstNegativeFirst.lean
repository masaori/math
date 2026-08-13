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
  change quadraticCoefficientPositive (quadraticRepresentation s (quadraticAddElement s xi eta))
  rw [quadraticRepresentation_add s hs xi eta]
  apply Or.inr
  apply Or.inr
  let a := (quadraticRepresentation s xi).1
  let b := (quadraticRepresentation s xi).2
  let a' := (quadraticRepresentation s eta).1
  let b' := (quadraticRepresentation s eta).2
  have ha : a < 0 := by simpa [a] using hxi.1
  have hb : 0 < b := by simpa [b] using hxi.2.1
  have hSq : a * a < 2 * b * b := by simpa [a, b] using hxi.2.2
  have ha' : a' < 0 := by simpa [a'] using heta.1
  have hb' : 0 < b' := by simpa [b'] using heta.2.1
  have hSq' : a' * a' < 2 * b' * b' := by simpa [a', b'] using heta.2.2
  have haa' : 0 < a * a' := mul_pos_of_neg_of_neg ha ha'
  have hCrossNonneg : 0 ≤ a * a' := le_of_lt haa'
  have hbb' : 0 < b * b' := mul_pos hb hb'
  have hRightNonneg : 0 ≤ 2 * (b * b') := by positivity
  have ha'Square : 0 < a' * a' := mul_pos_of_neg_of_neg ha' ha'
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
        exact mul_lt_mul_of_pos_left hSq' hbSquare
      _ = (2 * (b * b')) * (2 * (b * b')) := by ring
  have hCross : a * a' < 2 * (b * b') :=
    rationalSquareLtImpliesLt (a * a') (2 * (b * b'))
      hCrossNonneg hRightNonneg hProductSquare
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
      (add_lt_add_left hSq' (2 * b * b + 2 * (2 * (b * b'))))
  refine ⟨add_neg ha ha', add_pos hb hb', ?_⟩
  change (a + a') * (a + a') < 2 * (b + b') * (b + b')
  calc
    (a + a') * (a + a') =
        a * a + 2 * (a * a') + a' * a' := by ring
    _ < 2 * b * b + 2 * (a * a') + a' * a' := by
      simpa [add_assoc] using hFirstAdd
    _ < 2 * b * b + 2 * (2 * (b * b')) + a' * a' := hCrossAdd
    _ < 2 * b * b + 2 * (2 * (b * b')) + 2 * b' * b' := hSecondAdd
    _ = 2 * (b + b') * (b + b') := by ring

end Ising2DLambda.FisherZero
