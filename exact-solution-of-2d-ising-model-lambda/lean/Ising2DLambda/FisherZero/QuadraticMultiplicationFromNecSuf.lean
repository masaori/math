import Ising2DLambda.FisherZero.QuadraticMultiplication
import Ising2DLambda.NecSuf.FisherZero.QuadraticMultiplication

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 閉性の計算の必要十分版へ、ℚ と Qbar の演算則と包含準同型を供給する。 -/
theorem quadraticMul_value_from_necSuf
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi eta : QuadraticFieldElement s) :
    (xi : Qbar) * (eta : Qbar) =
      algebraMap ℚ Qbar ((quadraticRepresentation s xi).1 * (quadraticRepresentation s eta).1 +
        2 * ((quadraticRepresentation s xi).2 * (quadraticRepresentation s eta).2)) +
      algebraMap ℚ Qbar ((quadraticRepresentation s xi).1 * (quadraticRepresentation s eta).2 +
        (quadraticRepresentation s xi).2 * (quadraticRepresentation s eta).1) * s := by
  exact Ising2DLambda.NecSuf.FisherZero.quadratic_mul_value_necSuf
    (algebraMap ℚ Qbar) (map_add (algebraMap ℚ Qbar)) (map_mul (algebraMap ℚ Qbar))
    add_assoc add_comm mul_assoc mul_comm add_mul mul_add
    2 (quadraticRepresentation s xi).1 (quadraticRepresentation s xi).2
    (quadraticRepresentation s eta).1 (quadraticRepresentation s eta).2
    s (xi : Qbar) (eta : Qbar) hs
    (quadraticRepresentation_spec s xi) (quadraticRepresentation_spec s eta)

theorem quadraticMul_mem_from_necSuf
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi eta : QuadraticFieldElement s) :
    (xi : Qbar) * (eta : Qbar) ∈ quadraticFieldSet s := by
  have hvalue := quadraticMul_value_from_necSuf s hs xi eta
  rw [quadraticRepresentation_spec s xi, quadraticRepresentation_spec s eta] at hvalue ⊢
  apply Ising2DLambda.NecSuf.FisherZero.mul_mem_necSuf
      (mulK := fun x y : Qbar => x * y)
      (combine := fun a b : ℚ => algebraMap ℚ Qbar a + algebraMap ℚ Qbar b * s)
      (quadraticRepresentation s xi).1 (quadraticRepresentation s xi).2
      (quadraticRepresentation s eta).1 (quadraticRepresentation s eta).2
      ((quadraticRepresentation s xi).1 * (quadraticRepresentation s eta).1 +
        2 * ((quadraticRepresentation s xi).2 * (quadraticRepresentation s eta).2))
      ((quadraticRepresentation s xi).1 * (quadraticRepresentation s eta).2 +
        (quadraticRepresentation s xi).2 * (quadraticRepresentation s eta).1)
  exact hvalue

theorem quadraticRepresentation_mul_from_necSuf
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi eta : QuadraticFieldElement s) :
    quadraticRepresentation s (quadraticMulElement s hs xi eta) =
      ((quadraticRepresentation s xi).1 * (quadraticRepresentation s eta).1 +
          2 * ((quadraticRepresentation s xi).2 * (quadraticRepresentation s eta).2),
        (quadraticRepresentation s xi).1 * (quadraticRepresentation s eta).2 +
          (quadraticRepresentation s xi).2 * (quadraticRepresentation s eta).1) := by
  apply Ising2DLambda.NecSuf.FisherZero.mul_representation_necSuf
      (mulK := fun x y : QuadraticFieldElement s => quadraticMulElement s hs x y)
      (value := fun x : QuadraticFieldElement s => (x : Qbar))
      (combine := fun a b : ℚ => algebraMap ℚ Qbar a + algebraMap ℚ Qbar b * s)
      (rep := quadraticRepresentation s)
  · intro x a b hx
    exact quadraticRepresentation_eq s hs x a b hx
  · change (xi : Qbar) * (eta : Qbar) = _
    rw [quadraticRepresentation_spec s xi, quadraticRepresentation_spec s eta]
    simp only [map_add, map_mul]
    change
      (algebraMap ℚ Qbar (quadraticRepresentation s xi).1 +
          algebraMap ℚ Qbar (quadraticRepresentation s xi).2 * s) *
        (algebraMap ℚ Qbar (quadraticRepresentation s eta).1 +
          algebraMap ℚ Qbar (quadraticRepresentation s eta).2 * s) =
        algebraMap ℚ Qbar (quadraticRepresentation s xi).1 *
            algebraMap ℚ Qbar (quadraticRepresentation s eta).1 +
          algebraMap ℚ Qbar 2 *
            (algebraMap ℚ Qbar (quadraticRepresentation s xi).2 *
              algebraMap ℚ Qbar (quadraticRepresentation s eta).2) +
          (algebraMap ℚ Qbar (quadraticRepresentation s xi).1 *
              algebraMap ℚ Qbar (quadraticRepresentation s eta).2 +
            algebraMap ℚ Qbar (quadraticRepresentation s xi).2 *
              algebraMap ℚ Qbar (quadraticRepresentation s eta).1) * s
    ring_nf
    rw [show s ^ 2 = algebraMap ℚ Qbar 2 by simpa [pow_two] using hs]
    ring_nf

end Ising2DLambda.FisherZero
