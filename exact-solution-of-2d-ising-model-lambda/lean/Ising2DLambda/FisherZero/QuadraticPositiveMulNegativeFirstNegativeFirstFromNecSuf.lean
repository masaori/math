import Ising2DLambda.FisherZero.QuadraticMultiplicationFromNecSuf
import Ising2DLambda.NecSuf.FisherZero.QuadraticPositiveMulNegativeFirstNegativeFirst

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 必要十分版を有理係数の二次体へ特殊化した導出。 -/
theorem quadraticPositive_mul_of_negativeFirst_negativeFirst_from_necSuf
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
  let c := -a
  let cp := -ap
  have ha : a < 0 := hxi.1
  have hap : ap < 0 := heta.1
  have hb : 0 < b := hxi.2.1
  have hbp : 0 < bp := heta.2.1
  have hc : 0 < c := neg_pos.mpr ha
  have hcp : 0 < cp := neg_pos.mpr hap
  have hSq : c * c < 2 * (b * b) := by
    calc
      c * c = (-a) * (-a) := rfl
      _ = a * a := neg_mul_neg _ _
      _ < (2 * b) * b := hxi.2.2
      _ = 2 * (b * b) := mul_assoc _ _ _
  have hSqp : cp * cp < 2 * (bp * bp) := by
    calc
      cp * cp = (-ap) * (-ap) := rfl
      _ = ap * ap := neg_mul_neg _ _
      _ < (2 * bp) * bp := heta.2.2
      _ = 2 * (bp * bp) := mul_assoc _ _ _
  have hResult :=
    Ising2DLambda.NecSuf.FisherZero.positive_mul_negativeFirst_negativeFirst_necSuf
      c b cp bp hc hb hSq hcp hbp hSqp
  have hA : c * cp + 2 * (b * bp) = a * ap + 2 * (b * bp) := by
    calc
      c * cp + 2 * (b * bp) = ((-a) * (-ap)) + 2 * (b * bp) := rfl
      _ = a * ap + 2 * (b * bp) := by rw [neg_mul_neg]
  have hB : -(c * bp + b * cp) = a * bp + b * ap := by
    calc
      -(c * bp + b * cp) = -((-a) * bp + b * (-ap)) := rfl
      _ = -(-(a * bp) + b * (-ap)) := by rw [neg_mul]
      _ = -(-(a * bp) + -(b * ap)) := by rw [mul_neg]
      _ = -(-(a * bp + b * ap)) := by rw [← neg_add]
      _ = a * bp + b * ap := neg_neg _
  rw [hA, hB] at hResult
  have hOutputCompare : (2 * (a * bp + b * ap)) * (a * bp + b * ap) <
      (a * ap + 2 * (b * bp)) * (a * ap + 2 * (b * bp)) := by
    calc
      (2 * (a * bp + b * ap)) * (a * bp + b * ap) =
          2 * ((a * bp + b * ap) * (a * bp + b * ap)) := mul_assoc _ _ _
      _ < (a * ap + 2 * (b * bp)) * (a * ap + 2 * (b * bp)) := hResult.2.2
  exact ⟨hResult.1, hResult.2.1, hOutputCompare⟩

end Ising2DLambda.FisherZero
