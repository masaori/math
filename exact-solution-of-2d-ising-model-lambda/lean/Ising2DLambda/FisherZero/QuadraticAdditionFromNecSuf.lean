import Ising2DLambda.FisherZero.QuadraticAddition
import Ising2DLambda.NecSuf.FisherZero.QuadraticAddition

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem quadraticAdd_mem_from_necSuf
    (s : Qbar) (xi eta : QuadraticFieldElement s) :
    (xi : Qbar) + (eta : Qbar) ∈ quadraticFieldSet s := by
  rw [quadraticRepresentation_spec s xi, quadraticRepresentation_spec s eta]
  apply Ising2DLambda.NecSuf.FisherZero.add_mem_necSuf
      (addA := fun x y : ℚ => x + y)
      (addK := fun x y : Qbar => x + y)
      (combine := fun a b : ℚ => algebraMap ℚ Qbar a + algebraMap ℚ Qbar b * s)
      (quadraticRepresentation s xi).1 (quadraticRepresentation s xi).2
      (quadraticRepresentation s eta).1 (quadraticRepresentation s eta).2
  calc
    (algebraMap ℚ Qbar (quadraticRepresentation s xi).1 +
          algebraMap ℚ Qbar (quadraticRepresentation s xi).2 * s) +
        (algebraMap ℚ Qbar (quadraticRepresentation s eta).1 +
          algebraMap ℚ Qbar (quadraticRepresentation s eta).2 * s) =
        algebraMap ℚ Qbar ((quadraticRepresentation s xi).1 +
          (quadraticRepresentation s eta).1) +
          algebraMap ℚ Qbar ((quadraticRepresentation s xi).2 +
            (quadraticRepresentation s eta).2) * s := by
      rw [map_add, map_add, add_mul]
      abel

theorem quadraticRepresentation_add_from_necSuf
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi eta : QuadraticFieldElement s) :
    quadraticRepresentation s (quadraticAddElement s xi eta) =
      ((quadraticRepresentation s xi).1 + (quadraticRepresentation s eta).1,
        (quadraticRepresentation s xi).2 + (quadraticRepresentation s eta).2) := by
  apply Ising2DLambda.NecSuf.FisherZero.add_representation_necSuf
      (addA := fun x y : ℚ => x + y)
      (addK := fun x y : QuadraticFieldElement s => quadraticAddElement s x y)
      (value := fun x : QuadraticFieldElement s => (x : Qbar))
      (combine := fun a b : ℚ => algebraMap ℚ Qbar a + algebraMap ℚ Qbar b * s)
      (rep := quadraticRepresentation s)
  · intro x a b hx
    exact quadraticRepresentation_eq s hs x a b hx
  · change (xi : Qbar) + (eta : Qbar) =
      algebraMap ℚ Qbar ((quadraticRepresentation s xi).1 +
        (quadraticRepresentation s eta).1) +
        algebraMap ℚ Qbar ((quadraticRepresentation s xi).2 +
          (quadraticRepresentation s eta).2) * s
    rw [quadraticRepresentation_spec s xi, quadraticRepresentation_spec s eta]
    rw [map_add, map_add, add_mul]
    ac_rfl

end Ising2DLambda.FisherZero
