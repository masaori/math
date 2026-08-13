import Ising2DLambda.FisherZero.QuadraticPositiveMulNonnegativeNegativeFirst
import Ising2DLambda.NecSuf.FisherZero.QuadraticPositiveMulNonnegativeNegativeFirst

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
  change quadraticCoefficientPositive
    (quadraticRepresentation s (quadraticMulElement s hs xi eta))
  rw [quadraticRepresentation_mul s hs xi eta]
  let a := (quadraticRepresentation s xi).1
  let b := (quadraticRepresentation s xi).2
  let c := -(quadraticRepresentation s eta).1
  let bp := (quadraticRepresentation s eta).2
  have hSq : c * c < 2 * (bp * bp) := by
    simpa [c, bp, mul_assoc] using heta.2.2
  have hUnequal : a * a ≠ 2 * (b * b) := by
    by_cases hb0 : b = 0
    · intro hEq
      have ha0 : a = 0 := by nlinarith [sq_nonneg a]
      exact hxi.2.2 (Prod.ext ha0 hb0)
    · exact rationalSquareNeDoubleSquare a b hb0
  have hResult :=
    Ising2DLambda.NecSuf.FisherZero.positive_mul_nonnegative_negativeFirst_necSuf
      a b c bp hxi.1 hxi.2.1 heta.2.1 hSq hUnequal
  simpa [quadraticCoefficientPositive, a, b, c, bp, sub_eq_add_neg,
    add_assoc, add_left_comm, add_comm,
    mul_assoc, mul_left_comm, mul_comm] using hResult

end Ising2DLambda.FisherZero
