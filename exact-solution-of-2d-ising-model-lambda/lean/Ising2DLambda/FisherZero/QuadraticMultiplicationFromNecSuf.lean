import Ising2DLambda.FisherZero.QuadraticMultiplication
import Ising2DLambda.NecSuf.FisherZero.QuadraticMultiplication

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem quadraticMul_mem_from_necSuf
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi eta : QuadraticFieldElement s) :
    (xi : Qbar) * (eta : Qbar) ∈ quadraticFieldSet s := by
  rw [quadraticRepresentation_spec s xi, quadraticRepresentation_spec s eta]
  apply Ising2DLambda.NecSuf.FisherZero.mul_mem_necSuf
      (mulK := fun x y : Qbar => x * y)
      (combine := fun a b : ℚ => algebraMap ℚ Qbar a + algebraMap ℚ Qbar b * s)
      (quadraticRepresentation s xi).1 (quadraticRepresentation s xi).2
      (quadraticRepresentation s eta).1 (quadraticRepresentation s eta).2
      ((quadraticRepresentation s xi).1 * (quadraticRepresentation s eta).1 +
        2 * ((quadraticRepresentation s xi).2 * (quadraticRepresentation s eta).2))
      ((quadraticRepresentation s xi).1 * (quadraticRepresentation s eta).2 +
        (quadraticRepresentation s xi).2 * (quadraticRepresentation s eta).1)
  simp only [map_add, map_mul]
  ring_nf
  rw [show s ^ 2 = algebraMap ℚ Qbar 2 by simpa [pow_two] using hs]
  ring_nf

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
