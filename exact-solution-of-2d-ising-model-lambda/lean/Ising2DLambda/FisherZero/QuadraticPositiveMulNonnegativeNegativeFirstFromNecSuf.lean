import Ising2DLambda.FisherZero.QuadraticPositiveMulNonnegativeNegativeFirst
import Ising2DLambda.NecSuf.FisherZero.QuadraticPositiveMulNonnegativeNegativeFirst
import Ising2DLambda.FisherZero.QuadraticMultiplicationFromNecSuf
import Ising2DLambda.FisherZero.RationalSquareNeDoubleSquareFromNecSuf

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 必要十分版を有理係数の二次体へ特殊化した導出。 -/
theorem quadraticPositive_mul_of_nonnegative_negativeFirst_from_necSuf
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi eta : QuadraticFieldElement s)
    (hxi : 0 ≤ (quadraticRepresentation s xi).1 ∧
      0 ≤ (quadraticRepresentation s xi).2 ∧
      quadraticRepresentation s xi ≠ (0, 0))
    (heta : (quadraticRepresentation s eta).1 < 0 ∧
      0 < (quadraticRepresentation s eta).2 ∧
      (quadraticRepresentation s eta).1 * (quadraticRepresentation s eta).1 <
        2 * (quadraticRepresentation s eta).2 * (quadraticRepresentation s eta).2) :
    quadraticMulElement s hs xi eta ∈ quadraticPositiveCone s := by
  let a := (quadraticRepresentation s xi).1
  let b := (quadraticRepresentation s xi).2
  let ap := (quadraticRepresentation s eta).1
  let bp := (quadraticRepresentation s eta).2
  let c := -ap
  have hcNeg : -c = ap := neg_neg ap
  obtain ⟨ha, hb, hNe⟩ := hxi
  obtain ⟨hap, hbp, hSqRaw⟩ := heta
  have hSq : c * c < 2 * (bp * bp) := by
    calc
      c * c = (-ap) * (-ap) := rfl
      _ = ap * ap := neg_mul_neg _ _
      _ < 2 * bp * bp := hSqRaw
      _ = 2 * (bp * bp) := by simp only [mul_assoc]
  have hA : a * ap + 2 * (b * bp) = 2 * (b * bp) - a * c := by
    calc
      a * ap + 2 * (b * bp) = a * (-c) + 2 * (b * bp) := by rw [← hcNeg]
      _ = -(a * c) + 2 * (b * bp) := by rw [mul_neg]
      _ = 2 * (b * bp) + -(a * c) := add_comm _ _
      _ = 2 * (b * bp) - a * c := (sub_eq_add_neg _ _).symm
  have hB : a * bp + b * ap = a * bp - b * c := by
    calc
      a * bp + b * ap = a * bp + b * (-c) := by rw [← hcNeg]
      _ = a * bp + -(b * c) := by rw [mul_neg]
      _ = a * bp - b * c := (sub_eq_add_neg _ _).symm
  have hResult :=
    Ising2DLambda.NecSuf.FisherZero.positive_mul_nonnegative_negativeFirst_necSuf
      a b c bp ha hb hbp hSq hNe
      (rationalSquareNeDoubleSquare_from_necSuf a b)
  change quadraticCoefficientPositive
    (quadraticRepresentation s (quadraticMulElement s hs xi eta))
  rw [quadraticRepresentation_mul_from_necSuf s hs xi eta]
  change quadraticCoefficientPositive (a * ap + 2 * (b * bp), a * bp + b * ap)
  rw [hA, hB]
  simpa only [quadraticCoefficientPositive, mul_assoc] using hResult

end Ising2DLambda.FisherZero
