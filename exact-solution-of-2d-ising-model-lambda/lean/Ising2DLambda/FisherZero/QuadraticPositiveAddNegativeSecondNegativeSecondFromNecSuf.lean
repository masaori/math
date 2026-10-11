import Ising2DLambda.FisherZero.QuadraticPositiveAddNegativeSecondNegativeSecond
import Ising2DLambda.NecSuf.FisherZero.QuadraticPositiveAddNegativeSecondNegativeSecond

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem quadraticPositive_add_of_negativeSecond_negativeSecond_from_necSuf
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
  have hRep := quadraticRepresentation_add s hs xi eta
  have hCoefficients :=
    Ising2DLambda.NecSuf.FisherZero.positive_add_negativeSecond_negativeSecond_necSuf
      (quadraticRepresentation s xi).1 (quadraticRepresentation s xi).2
      (quadraticRepresentation s eta).1 (quadraticRepresentation s eta).2
      hxi.1 hxi.2.1 hxi.2.2 heta.1 heta.2.1 heta.2.2
  change quadraticCoefficientPositive (quadraticRepresentation s (quadraticAddElement s xi eta))
  rw [hRep]
  exact Or.inr (Or.inl hCoefficients)

end Ising2DLambda.FisherZero
