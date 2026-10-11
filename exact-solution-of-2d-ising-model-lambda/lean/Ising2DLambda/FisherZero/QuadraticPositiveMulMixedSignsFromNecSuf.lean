import Ising2DLambda.FisherZero.QuadraticMultiplicationFromNecSuf
import Ising2DLambda.NecSuf.FisherZero.QuadraticPositiveMulMixedSigns

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem quadraticPositive_mul_of_mixedSigns_from_necSuf
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi eta : QuadraticFieldElement s)
    (hxi : 0 < (quadraticRepresentation s xi).1 ∧
      (quadraticRepresentation s xi).2 < 0 ∧
      2 * (quadraticRepresentation s xi).2 * (quadraticRepresentation s xi).2 <
        (quadraticRepresentation s xi).1 * (quadraticRepresentation s xi).1)
    (heta : (quadraticRepresentation s eta).1 < 0 ∧
      0 < (quadraticRepresentation s eta).2 ∧
      (quadraticRepresentation s eta).1 * (quadraticRepresentation s eta).1 <
        2 * (quadraticRepresentation s eta).2 * (quadraticRepresentation s eta).2) :
    quadraticMulElement s hs xi eta ∈ quadraticPositiveCone s := by
  change quadraticCoefficientPositive
    (quadraticRepresentation s (quadraticMulElement s hs xi eta))
  rw [quadraticRepresentation_mul_from_necSuf s hs xi eta]
  apply Or.inr
  apply Or.inr
  let a := (quadraticRepresentation s xi).1
  let b := (quadraticRepresentation s xi).2
  let ap := (quadraticRepresentation s eta).1
  let bp := (quadraticRepresentation s eta).2
  let u := -b
  let cp := -ap
  have ha : 0 < a := hxi.1
  have hb : b < 0 := hxi.2.1
  have hap : ap < 0 := heta.1
  have hbp : 0 < bp := heta.2.1
  have hu : 0 < u := neg_pos.mpr hb
  have hcp : 0 < cp := neg_pos.mpr hap
  have hbEq : b = -u := (neg_neg b).symm
  have hapEq : ap = -cp := (neg_neg ap).symm
  have hSq : 2 * (u * u) < a * a := by
    calc
      2 * (u * u) = 2 * ((-b) * (-b)) := rfl
      _ = 2 * (b * b) := by rw [neg_mul_neg]
      _ = (2 * b) * b := (mul_assoc _ _ _).symm
      _ < a * a := hxi.2.2
  have hSqp : cp * cp < 2 * (bp * bp) := by
    calc
      cp * cp = (-ap) * (-ap) := rfl
      _ = ap * ap := neg_mul_neg _ _
      _ < (2 * bp) * bp := heta.2.2
      _ = 2 * (bp * bp) := mul_assoc _ _ _
  have hResult :=
    Ising2DLambda.NecSuf.FisherZero.positive_mul_mixedSigns_necSuf
      a u cp bp ha hu hSq hcp hbp hSqp
  let A := a * ap + 2 * (b * bp)
  let B := a * bp + b * ap
  let C := a * cp + 2 * (u * bp)
  have hA : A = -C := by
    calc
      A = a * ap + 2 * (b * bp) := rfl
      _ = a * (-cp) + 2 * ((-u) * bp) := by rw [hbEq, hapEq]
      _ = -(a * cp) + 2 * ((-u) * bp) := by rw [mul_neg]
      _ = -(a * cp) + 2 * (-(u * bp)) := by rw [neg_mul]
      _ = -(a * cp) + -(2 * (u * bp)) := by rw [mul_neg 2 (u * bp)]
      _ = -(a * cp + 2 * (u * bp)) := by rw [neg_add]
      _ = -C := rfl
  have hB : B = a * bp + u * cp := by
    calc
      B = a * bp + b * ap := rfl
      _ = a * bp + (-u) * (-cp) := by rw [hbEq, hapEq]
      _ = a * bp + u * cp := by rw [neg_mul_neg]
  have hANeg : A < 0 := by
    calc
      A = -C := hA
      _ < 0 := hResult.1
  have hBPos : 0 < B := by
    calc
      0 < a * bp + u * cp := hResult.2.1
      _ = B := hB.symm
  have hFinal : A * A < 2 * (B * B) := by
    calc
      A * A = (-C) * (-C) := by rw [hA]
      _ < 2 * ((a * bp + u * cp) * (a * bp + u * cp)) := hResult.2.2
      _ = 2 * (B * B) := by rw [hB]
  have hOutputCompare : A * A < (2 * B) * B := by
    calc
      A * A < 2 * (B * B) := hFinal
      _ = (2 * B) * B := (mul_assoc _ _ _).symm
  exact ⟨hANeg, hBPos, hOutputCompare⟩

end Ising2DLambda.FisherZero
