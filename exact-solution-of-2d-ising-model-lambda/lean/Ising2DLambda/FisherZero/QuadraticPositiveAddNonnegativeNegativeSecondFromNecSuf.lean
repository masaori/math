import Ising2DLambda.FisherZero.QuadraticPositiveAddNonnegativeNegativeSecond
import Ising2DLambda.FisherZero.QuadraticAdditionFromNecSuf
import Ising2DLambda.NecSuf.FisherZero.QuadraticPositiveAddNonnegativeNegativeSecond

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem quadraticPositive_add_of_nonnegative_negativeSecond_from_necSuf
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi eta : QuadraticFieldElement s)
    (hxi : 0 ≤ (quadraticRepresentation s xi).1 ∧
      0 ≤ (quadraticRepresentation s xi).2 ∧
      quadraticRepresentation s xi ≠ (0, 0))
    (heta : 0 < (quadraticRepresentation s eta).1 ∧
      (quadraticRepresentation s eta).2 < 0 ∧
      2 * (quadraticRepresentation s eta).2 * (quadraticRepresentation s eta).2 <
        (quadraticRepresentation s eta).1 * (quadraticRepresentation s eta).1) :
    quadraticAddElement s xi eta ∈ quadraticPositiveCone s := by
  change quadraticCoefficientPositive (quadraticRepresentation s (quadraticAddElement s xi eta))
  rw [quadraticRepresentation_add_from_necSuf s hs xi eta]
  have h := Ising2DLambda.NecSuf.FisherZero.positive_add_nonnegative_negativeSecond_necSuf
    (zero := (0 : ℚ)) (weight := 2) (add := (· + ·)) (mul := (· * ·))
    (le := (· ≤ ·)) (lt := (· < ·))
    (quadraticRepresentation s xi).1 (quadraticRepresentation s xi).2
    (quadraticRepresentation s eta).1 (quadraticRepresentation s eta).2
    hxi.1 hxi.2.1 heta.1 heta.2.1
    (by simpa only [mul_assoc] using heta.2.2)
    (by norm_num)
    (fun x => zero_add x)
    (fun _ _ hxy => le_of_lt hxy)
    (fun _ _ hxy => ne_of_lt hxy)
    (fun _ hx => lt_of_not_ge hx)
    (fun _ _ _ hxy hyz => le_trans hxy hyz)
    (fun _ _ _ hxy hyz => lt_of_le_of_lt hxy hyz)
    (fun _ _ _ hxy hyz => lt_of_lt_of_le hxy hyz)
    (fun _ _ hx hy => add_pos_of_nonneg_of_pos hx hy)
    (fun _ _ z hxy => _root_.add_le_add hxy (le_refl z))
    (fun _ _ _ hxy hz => mul_le_mul_of_nonneg_right hxy hz)
    (fun _ _ _ hxy hz => mul_le_mul_of_nonneg_left hxy hz)
    (fun _ _ _ hxy hz => mul_le_mul_of_nonpos_right hxy hz)
    (fun _ _ _ hxy hz => mul_le_mul_of_nonpos_left hxy hz)
  rcases h with hfirst | hsecond
  · exact Or.inl hfirst
  · apply Or.inr
    apply Or.inl
    simpa only [mul_assoc] using hsecond

end Ising2DLambda.FisherZero
