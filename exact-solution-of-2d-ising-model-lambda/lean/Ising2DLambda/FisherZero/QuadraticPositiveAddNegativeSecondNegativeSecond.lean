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
  change quadraticCoefficientPositive (quadraticRepresentation s (quadraticAddElement s xi eta))
  rw [quadraticRepresentation_add s hs xi eta]
  apply Or.inr
  apply Or.inl
  let a := (quadraticRepresentation s xi).1
  let b := (quadraticRepresentation s xi).2
  let a' := (quadraticRepresentation s eta).1
  let b' := (quadraticRepresentation s eta).2
  have ha : 0 < a := by simpa [a] using hxi.1
  have hb : b < 0 := by simpa [b] using hxi.2.1
  have hSq : 2 * b * b < a * a := by simpa [a, b] using hxi.2.2
  have ha' : 0 < a' := by simpa [a'] using heta.1
  have hb' : b' < 0 := by simpa [b'] using heta.2.1
  have hSq' : 2 * b' * b' < a' * a' := by simpa [a', b'] using heta.2.2
  have hbb' : 0 < b * b' := mul_pos_of_neg_of_neg hb hb'
  have hCrossNonneg : 0 ≤ 2 * (b * b') := by positivity
  have haa' : 0 < a * a' := mul_pos ha ha'
  have hb'Square : 0 < 2 * b' * b' := by
    have h : 0 < b' * b' := mul_pos_of_neg_of_neg hb' hb'
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
        exact mul_lt_mul_of_pos_left hSq' haSquare
      _ = (a * a') * (a * a') := by ring
  have hCross : 2 * (b * b') < a * a' :=
    rationalSquareLtImpliesLt (2 * (b * b')) (a * a')
      hCrossNonneg (le_of_lt haa') hProductSquare
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
      (add_lt_add_left hSq' (a * a + 2 * (a * a')))
  refine ⟨add_pos ha ha', add_neg hb hb', ?_⟩
  change 2 * (b + b') * (b + b') < (a + a') * (a + a')
  calc
    2 * (b + b') * (b + b') =
        2 * b * b + 2 * (2 * (b * b')) + 2 * b' * b' := by ring
    _ < a * a + 2 * (2 * (b * b')) + 2 * b' * b' := by
      simpa [add_assoc] using hFirstAdd
    _ < a * a + 2 * (a * a') + 2 * b' * b' := hCrossAdd
    _ < a * a + 2 * (a * a') + a' * a' := hSecondAdd
    _ = (a + a') * (a + a') := by ring

end Ising2DLambda.FisherZero
