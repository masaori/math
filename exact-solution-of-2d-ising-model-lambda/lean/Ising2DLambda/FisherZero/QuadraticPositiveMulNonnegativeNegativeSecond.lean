/-
「非負係数条件と負の第二係数条件の積」の具体版。
本文と同じ二つの平方比較と、その内側の係数符号の場合分けを行う。
-/
import Ising2DLambda.FisherZero.QuadraticMultiplication
import Ising2DLambda.FisherZero.RationalSquareNeDoubleSquare
import Ising2DLambda.NecSuf.FisherZero.QuadraticPositiveMulNonnegativeNegativeSecond

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem quadraticPositive_mul_of_nonnegative_negativeSecond
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi eta : QuadraticFieldElement s)
    (hxi : 0 ≤ (quadraticRepresentation s xi).1 ∧
      0 ≤ (quadraticRepresentation s xi).2 ∧
      quadraticRepresentation s xi ≠ (0, 0))
    (heta : 0 < (quadraticRepresentation s eta).1 ∧
      (quadraticRepresentation s eta).2 < 0 ∧
      2 * (quadraticRepresentation s eta).2 * (quadraticRepresentation s eta).2 <
        (quadraticRepresentation s eta).1 * (quadraticRepresentation s eta).1) :
    quadraticMulElement s hs xi eta ∈ quadraticPositiveCone s := by
  change quadraticCoefficientPositive
    (quadraticRepresentation s (quadraticMulElement s hs xi eta))
  rw [quadraticRepresentation_mul s hs xi eta]
  let a := (quadraticRepresentation s xi).1
  let b := (quadraticRepresentation s xi).2
  let ap := (quadraticRepresentation s eta).1
  let u := -(quadraticRepresentation s eta).2
  have hSq : 2 * (u * u) < ap * ap := by
    simpa [u, ap, mul_assoc] using heta.2.2
  have hUnequal : a * a ≠ 2 * (b * b) := by
    by_cases hb0 : b = 0
    · intro hEq
      have ha0 : a = 0 := by nlinarith [sq_nonneg a]
      exact hxi.2.2 (Prod.ext ha0 hb0)
    · exact rationalSquareNeDoubleSquare a b hb0
  have hResult :=
    Ising2DLambda.NecSuf.FisherZero.positive_mul_nonnegative_negativeSecond_necSuf
      a b ap u hxi.1 hxi.2.1 heta.1 hSq hUnequal
  simpa [quadraticCoefficientPositive, a, b, ap, u, sub_eq_add_neg,
    add_assoc, add_left_comm, add_comm,
    mul_assoc, mul_left_comm, mul_comm] using hResult

end Ising2DLambda.FisherZero
