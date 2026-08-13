import Ising2DLambda.FisherZero.QuadraticPositiveAddNonnegativeNegativeFirst
import Ising2DLambda.NecSuf.FisherZero.QuadraticPositiveAddNonnegativeNegativeFirst

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem quadraticPositive_add_of_nonnegative_negativeFirst_from_necSuf
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi eta : QuadraticFieldElement s)
    (hxi : 0 ≤ (quadraticRepresentation s xi).1 ∧
      0 ≤ (quadraticRepresentation s xi).2 ∧
      quadraticRepresentation s xi ≠ (0, 0))
    (heta : (quadraticRepresentation s eta).1 < 0 ∧
      0 < (quadraticRepresentation s eta).2 ∧
      (quadraticRepresentation s eta).1 * (quadraticRepresentation s eta).1 <
        2 * (quadraticRepresentation s eta).2 * (quadraticRepresentation s eta).2) :
    quadraticAddElement s xi eta ∈ quadraticPositiveCone s := by
  change quadraticCoefficientPositive (quadraticRepresentation s (quadraticAddElement s xi eta))
  rw [quadraticRepresentation_add s hs xi eta]
  have h := Ising2DLambda.NecSuf.FisherZero.positive_add_nonnegative_negativeFirst_necSuf
    (quadraticRepresentation s xi).1 (quadraticRepresentation s xi).2
    (quadraticRepresentation s eta).1 (quadraticRepresentation s eta).2
    hxi.1 hxi.2.1 heta.1 heta.2.1 heta.2.2
  rcases h with hfirst | hthird
  · exact Or.inl hfirst
  · exact Or.inr (Or.inr hthird)

end Ising2DLambda.FisherZero
