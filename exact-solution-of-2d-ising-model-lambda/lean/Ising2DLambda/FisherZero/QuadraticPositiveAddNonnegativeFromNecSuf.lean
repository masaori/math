import Ising2DLambda.FisherZero.QuadraticPositiveAddNonnegative
import Ising2DLambda.FisherZero.QuadraticAdditionFromNecSuf
import Ising2DLambda.NecSuf.FisherZero.QuadraticPositiveAddNonnegative

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem quadraticPositive_add_of_nonnegativeCoefficients_from_necSuf
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi eta : QuadraticFieldElement s)
    (hxi : 0 ≤ (quadraticRepresentation s xi).1 ∧
      0 ≤ (quadraticRepresentation s xi).2 ∧
      quadraticRepresentation s xi ≠ (0, 0))
    (heta : 0 ≤ (quadraticRepresentation s eta).1 ∧
      0 ≤ (quadraticRepresentation s eta).2 ∧
      quadraticRepresentation s eta ≠ (0, 0)) :
    quadraticAddElement s xi eta ∈ quadraticPositiveCone s := by
  change quadraticCoefficientPositive (quadraticRepresentation s (quadraticAddElement s xi eta))
  rw [quadraticRepresentation_add_from_necSuf s hs xi eta]
  apply Or.inl
  apply Ising2DLambda.NecSuf.FisherZero.positive_add_nonnegative_necSuf
      (zero := (0 : ℚ)) (add := (· + ·)) (le := (· ≤ ·))
      (quadraticRepresentation s xi).1 (quadraticRepresentation s xi).2
      (quadraticRepresentation s eta).1 (quadraticRepresentation s eta).2
      hxi.1 hxi.2.1 heta.1 heta.2.1 hxi.2.2
  · exact add_zero
  · intro x y hx hy
    exact add_nonneg hx hy
  · intro x y hy
    exact _root_.add_le_add (le_refl x) hy
  · intro x y hxy hyx
    exact le_antisymm hxy hyx

end Ising2DLambda.FisherZero
