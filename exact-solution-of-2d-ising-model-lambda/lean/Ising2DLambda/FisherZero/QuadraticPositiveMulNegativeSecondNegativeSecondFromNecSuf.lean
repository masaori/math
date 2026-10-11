import Ising2DLambda.FisherZero.QuadraticPositiveMulNegativeSecondNegativeSecond
import Ising2DLambda.FisherZero.QuadraticMultiplicationFromNecSuf
import Ising2DLambda.NecSuf.FisherZero.QuadraticPositiveMulNegativeSecondNegativeSecond

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 必要十分版を有理係数の二次体へ特殊化した導出。 -/
theorem quadraticPositive_mul_of_negativeSecond_negativeSecond_from_necSuf
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
    quadraticMulElement s hs xi eta ∈ quadraticPositiveCone s := by
  change quadraticCoefficientPositive
    (quadraticRepresentation s (quadraticMulElement s hs xi eta))
  rw [quadraticRepresentation_mul_from_necSuf s hs xi eta]
  apply Or.inr
  apply Or.inl
  let a := (quadraticRepresentation s xi).1
  let b := (quadraticRepresentation s xi).2
  let ap := (quadraticRepresentation s eta).1
  let bp := (quadraticRepresentation s eta).2
  let u := -b
  let up := -bp
  have hu : 0 < u := neg_pos.mpr hxi.2.1
  have hup : 0 < up := neg_pos.mpr heta.2.1
  have hSq : 2 * (u * u) < a * a := by
    calc
      2 * (u * u) = 2 * ((-b) * (-b)) := rfl
      _ = 2 * (b * b) := by rw [neg_mul_neg]
      _ < a * a := by simpa only [a, b, mul_assoc] using hxi.2.2
  have hSqp : 2 * (up * up) < ap * ap := by
    calc
      2 * (up * up) = 2 * ((-bp) * (-bp)) := rfl
      _ = 2 * (bp * bp) := by rw [neg_mul_neg]
      _ < ap * ap := by simpa only [ap, bp, mul_assoc] using heta.2.2
  have hResult :=
    Ising2DLambda.NecSuf.FisherZero.positive_mul_negativeSecond_negativeSecond_necSuf
      a u ap up hxi.1 hu hSq heta.1 hup hSqp
  -- 本文の二つの係数表示を、特殊化で得た有理数の式へ戻す。
  have hA : a * ap + 2 * (u * up) = a * ap + 2 * (b * bp) := by
    calc
      a * ap + 2 * (u * up) = a * ap + 2 * ((-b) * (-bp)) := rfl
      _ = a * ap + 2 * (b * bp) := by rw [neg_mul_neg]
  have hB : -(a * up + u * ap) = a * bp + b * ap := by
    calc
      -(a * up + u * ap) = -(a * (-bp) + (-b) * ap) := rfl
      _ = -(-(a * bp) + (-b) * ap) := by rw [mul_neg]
      _ = -(-(a * bp) + -(b * ap)) := by rw [neg_mul]
      _ = -(-(a * bp + b * ap)) := by rw [← neg_add]
      _ = a * bp + b * ap := neg_neg _
  rw [hA, hB] at hResult
  simpa only [a, b, ap, bp, mul_assoc] using hResult

end Ising2DLambda.FisherZero
