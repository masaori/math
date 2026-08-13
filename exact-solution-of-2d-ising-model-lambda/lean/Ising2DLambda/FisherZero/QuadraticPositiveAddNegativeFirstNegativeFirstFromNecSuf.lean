import Ising2DLambda.FisherZero.QuadraticPositiveAddNegativeFirstNegativeFirst
import Ising2DLambda.NecSuf.FisherZero.QuadraticPositiveAddNegativeFirstNegativeFirst

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem quadraticPositive_add_of_negativeFirst_negativeFirst_from_necSuf
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
  exact Ising2DLambda.NecSuf.FisherZero.positive_add_negativeFirst_negativeFirst_necSuf
    (quadraticRepresentation s xi).1 (quadraticRepresentation s xi).2
    (quadraticRepresentation s eta).1 (quadraticRepresentation s eta).2
    hxi.1 hxi.2.1 hxi.2.2 heta.1 heta.2.1 heta.2.2

end Ising2DLambda.FisherZero
