import Ising2DLambda.FisherZero.QuadraticMultiplicationFromNecSuf
import Ising2DLambda.NecSuf.FisherZero.QuadraticPositiveMulNonnegative

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem quadraticPositive_mul_of_nonnegativeCoefficients_from_necSuf
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi eta : QuadraticFieldElement s)
    (hxi : 0 ≤ (quadraticRepresentation s xi).1 ∧
      0 ≤ (quadraticRepresentation s xi).2 ∧
      quadraticRepresentation s xi ≠ (0, 0))
    (heta : 0 ≤ (quadraticRepresentation s eta).1 ∧
      0 ≤ (quadraticRepresentation s eta).2 ∧
      quadraticRepresentation s eta ≠ (0, 0)) :
    quadraticMulElement s hs xi eta ∈ quadraticPositiveCone s := by
  change quadraticCoefficientPositive
    (quadraticRepresentation s (quadraticMulElement s hs xi eta))
  rw [quadraticRepresentation_mul_from_necSuf s hs xi eta]
  apply Or.inl
  exact Ising2DLambda.NecSuf.FisherZero.positive_mul_nonnegative_necSuf
    0 2 (· + ·) (· * ·)
    (quadraticRepresentation s xi).1 (quadraticRepresentation s xi).2
    (quadraticRepresentation s eta).1 (quadraticRepresentation s eta).2
    hxi.1 hxi.2.1 heta.1 heta.2.1 hxi.2.2 heta.2.2 (by norm_num)
    add_zero zero_add
    (fun _ _ hx hy => add_nonneg hx hy)
    (fun _ _ hx hy => mul_nonneg hx hy)
    (fun _ _ hx hy => mul_pos hx hy)
    (fun x _ hy => _root_.add_le_add (le_refl x) hy)
    (fun _ y hx => _root_.add_le_add hx (le_refl y))

end Ising2DLambda.FisherZero
