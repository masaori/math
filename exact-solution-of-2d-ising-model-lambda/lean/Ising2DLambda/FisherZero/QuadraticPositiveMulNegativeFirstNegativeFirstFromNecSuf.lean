import Ising2DLambda.FisherZero.QuadraticPositiveMulNegativeFirstNegativeFirst
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
  rw [quadraticRepresentation_mul s hs xi eta]
  apply Or.inr
  apply Or.inl
  let c := -(quadraticRepresentation s xi).1
  let b := (quadraticRepresentation s xi).2
  let cp := -(quadraticRepresentation s eta).1
  let bp := (quadraticRepresentation s eta).2
  have hResult :=
    Ising2DLambda.NecSuf.FisherZero.positive_mul_negativeFirst_negativeFirst_necSuf
      c b cp bp (by simpa [c] using neg_pos.mpr hxi.1) hxi.2.1
      (by simpa [c, b, mul_assoc] using hxi.2.2)
      (by simpa [cp] using neg_pos.mpr heta.1) heta.2.1
      (by simpa [cp, bp, mul_assoc] using heta.2.2)
  simpa [c, b, cp, bp, sub_eq_add_neg, add_assoc, add_left_comm, add_comm,
    mul_assoc, mul_left_comm, mul_comm] using hResult

end Ising2DLambda.FisherZero
