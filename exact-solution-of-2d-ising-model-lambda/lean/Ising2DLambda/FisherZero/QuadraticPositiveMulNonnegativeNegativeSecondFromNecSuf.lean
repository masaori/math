import Ising2DLambda.FisherZero.QuadraticPositiveMulNonnegativeNegativeSecond
import Ising2DLambda.NecSuf.FisherZero.QuadraticPositiveMulNonnegativeNegativeSecond
import Ising2DLambda.FisherZero.QuadraticMultiplicationFromNecSuf
import Ising2DLambda.FisherZero.RationalSquareNeDoubleSquareFromNecSuf

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 必要十分版を有理係数の二次体へ特殊化した導出。 -/
theorem quadraticPositive_mul_of_nonnegative_negativeSecond_from_necSuf
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
  let a : ℚ := (quadraticRepresentation s xi).1
  let b : ℚ := (quadraticRepresentation s xi).2
  let ap : ℚ := (quadraticRepresentation s eta).1
  let bp : ℚ := (quadraticRepresentation s eta).2
  let u : ℚ := -bp
  have ha : 0 ≤ a := hxi.1
  have hb : 0 ≤ b := hxi.2.1
  have hap : 0 < ap := heta.1
  have hbp : bp = -u := (neg_neg bp).symm
  have hSq : 2 * (u * u) < ap * ap := by
    calc
      2 * (u * u) = 2 * ((-bp) * (-bp)) := rfl
      _ = 2 * (bp * bp) := by rw [neg_mul_neg]
      _ = 2 * bp * bp := (mul_assoc _ _ _).symm
      _ < ap * ap := heta.2.2
  have hA : a * ap + 2 * (b * bp) = a * ap - 2 * (b * u) := by
    calc
      a * ap + 2 * (b * bp) = a * ap + 2 * (b * (-u)) := by rw [hbp]
      _ = a * ap + 2 * (-(b * u)) := by rw [mul_neg b u]
      _ = a * ap + (-(2 * (b * u))) := by rw [mul_neg]
      _ = a * ap - 2 * (b * u) := (sub_eq_add_neg _ _).symm
  have hB : a * bp + b * ap = b * ap - a * u := by
    calc
      a * bp + b * ap = a * (-u) + b * ap := by rw [hbp]
      _ = (-(a * u)) + b * ap := by rw [mul_neg]
      _ = b * ap + (-(a * u)) := add_comm _ _
      _ = b * ap - a * u := (sub_eq_add_neg _ _).symm
  have hResult :=
    Ising2DLambda.NecSuf.FisherZero.positive_mul_nonnegative_negativeSecond_necSuf
      a b ap u ha hb hap hSq hxi.2.2
      (rationalSquareNeDoubleSquare_from_necSuf a b)
  change quadraticCoefficientPositive
    (quadraticRepresentation s (quadraticMulElement s hs xi eta))
  rw [quadraticRepresentation_mul_from_necSuf s hs xi eta]
  change quadraticCoefficientPositive (a * ap + 2 * (b * bp), a * bp + b * ap)
  rw [hA, hB]
  simpa only [quadraticCoefficientPositive, mul_assoc] using hResult

end Ising2DLambda.FisherZero
