import Ising2DLambda.FisherZero.QuadraticAddition
import Ising2DLambda.NecSuf.FisherZero.QuadraticAddition

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem quadraticAdd_mem_from_necSuf
    (s : Qbar) (xi eta : QuadraticFieldElement s) :
    (xi : Qbar) + (eta : Qbar) ∈ quadraticFieldSet s := by
  let a := (quadraticRepresentation s xi).1
  let b := (quadraticRepresentation s xi).2
  let a' := (quadraticRepresentation s eta).1
  let b' := (quadraticRepresentation s eta).2
  rw [quadraticRepresentation_spec s xi, quadraticRepresentation_spec s eta]
  apply Ising2DLambda.NecSuf.FisherZero.add_mem_necSuf
      (addA := fun x y : ℚ => x + y)
      (addK := fun x y : Qbar => x + y)
      (combine := fun a b : ℚ => algebraMap ℚ Qbar a + algebraMap ℚ Qbar b * s)
      a b a' b'
  calc
    (algebraMap ℚ Qbar a + algebraMap ℚ Qbar b * s) +
        (algebraMap ℚ Qbar a' + algebraMap ℚ Qbar b' * s) = algebraMap ℚ Qbar a +
          (algebraMap ℚ Qbar b * s +
            (algebraMap ℚ Qbar a' + algebraMap ℚ Qbar b' * s)) := by
      rw [add_assoc]
    _ = algebraMap ℚ Qbar a +
          ((algebraMap ℚ Qbar b * s + algebraMap ℚ Qbar a') +
            algebraMap ℚ Qbar b' * s) := by
      rw [add_assoc]
    _ = algebraMap ℚ Qbar a +
          ((algebraMap ℚ Qbar a' + algebraMap ℚ Qbar b * s) +
            algebraMap ℚ Qbar b' * s) := by
      rw [add_comm (algebraMap ℚ Qbar b * s)]
    _ = algebraMap ℚ Qbar a +
          (algebraMap ℚ Qbar a' +
            (algebraMap ℚ Qbar b * s + algebraMap ℚ Qbar b' * s)) := by
      rw [add_assoc]
    _ = (algebraMap ℚ Qbar a + algebraMap ℚ Qbar a') +
          (algebraMap ℚ Qbar b * s + algebraMap ℚ Qbar b' * s) := by
      rw [add_assoc]
    _ = (algebraMap ℚ Qbar a + algebraMap ℚ Qbar a') +
          (algebraMap ℚ Qbar b + algebraMap ℚ Qbar b') * s := by
      rw [add_mul]
    _ = algebraMap ℚ Qbar (a + a') +
          (algebraMap ℚ Qbar b + algebraMap ℚ Qbar b') * s := by
      rw [map_add (algebraMap ℚ Qbar) a a']
    _ = algebraMap ℚ Qbar (a + a') + algebraMap ℚ Qbar (b + b') * s := by
      rw [map_add (algebraMap ℚ Qbar) b b']

theorem quadraticRepresentation_add_from_necSuf
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi eta : QuadraticFieldElement s) :
    quadraticRepresentation s (quadraticAddElement s xi eta) =
      ((quadraticRepresentation s xi).1 + (quadraticRepresentation s eta).1,
        (quadraticRepresentation s xi).2 + (quadraticRepresentation s eta).2) := by
  let a := (quadraticRepresentation s xi).1
  let b := (quadraticRepresentation s xi).2
  let a' := (quadraticRepresentation s eta).1
  let b' := (quadraticRepresentation s eta).2
  apply Ising2DLambda.NecSuf.FisherZero.add_representation_necSuf
      (addA := fun x y : ℚ => x + y)
      (addK := fun x y : QuadraticFieldElement s => quadraticAddElement s x y)
      (value := fun x : QuadraticFieldElement s => (x : Qbar))
      (combine := fun a b : ℚ => algebraMap ℚ Qbar a + algebraMap ℚ Qbar b * s)
      (rep := quadraticRepresentation s)
  · intro x a b hx
    exact quadraticRepresentation_eq s hs x a b hx
  · change (xi : Qbar) + (eta : Qbar) =
      algebraMap ℚ Qbar (a + a') + algebraMap ℚ Qbar (b + b') * s
    calc
      (xi : Qbar) + (eta : Qbar) =
          (algebraMap ℚ Qbar a + algebraMap ℚ Qbar b * s) +
            (algebraMap ℚ Qbar a' + algebraMap ℚ Qbar b' * s) := by
        rw [quadraticRepresentation_spec s xi, quadraticRepresentation_spec s eta]
        rfl
      _ = algebraMap ℚ Qbar a +
            (algebraMap ℚ Qbar b * s +
              (algebraMap ℚ Qbar a' + algebraMap ℚ Qbar b' * s)) := by
        rw [add_assoc]
      _ = algebraMap ℚ Qbar a +
            ((algebraMap ℚ Qbar b * s + algebraMap ℚ Qbar a') +
              algebraMap ℚ Qbar b' * s) := by
        rw [add_assoc]
      _ = algebraMap ℚ Qbar a +
            ((algebraMap ℚ Qbar a' + algebraMap ℚ Qbar b * s) +
              algebraMap ℚ Qbar b' * s) := by
        rw [add_comm (algebraMap ℚ Qbar b * s)]
      _ = algebraMap ℚ Qbar a +
            (algebraMap ℚ Qbar a' +
              (algebraMap ℚ Qbar b * s + algebraMap ℚ Qbar b' * s)) := by
        rw [add_assoc]
      _ = (algebraMap ℚ Qbar a + algebraMap ℚ Qbar a') +
            (algebraMap ℚ Qbar b * s + algebraMap ℚ Qbar b' * s) := by
        rw [add_assoc]
      _ = (algebraMap ℚ Qbar a + algebraMap ℚ Qbar a') +
            (algebraMap ℚ Qbar b + algebraMap ℚ Qbar b') * s := by
        rw [add_mul]
      _ = algebraMap ℚ Qbar (a + a') +
            (algebraMap ℚ Qbar b + algebraMap ℚ Qbar b') * s := by
        rw [map_add (algebraMap ℚ Qbar) a a']
      _ = algebraMap ℚ Qbar (a + a') + algebraMap ℚ Qbar (b + b') * s := by
        rw [map_add (algebraMap ℚ Qbar) b b']

end Ising2DLambda.FisherZero
