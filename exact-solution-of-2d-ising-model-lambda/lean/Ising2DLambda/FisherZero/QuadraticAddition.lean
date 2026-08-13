/-
「二次体の和の表示」の具体版。
本文と同じ七段の等式列で和の表示を作り、台集合への所属と表示写像の値を別々に示す。
-/
import Ising2DLambda.FisherZero.QuadraticPositiveCone

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `xi + eta` を `Q_s` の元として持ち上げる。 -/
noncomputable def quadraticAddElement
    (s : Qbar) (xi eta : QuadraticFieldElement s) : QuadraticFieldElement s := by
  let a := (quadraticRepresentation s xi).1
  let b := (quadraticRepresentation s xi).2
  let a' := (quadraticRepresentation s eta).1
  let b' := (quadraticRepresentation s eta).2
  refine ⟨(xi : Qbar) + (eta : Qbar), a + a', b + b', ?_⟩
  calc
    (xi : Qbar) + (eta : Qbar) =
        (algebraMap ℚ Qbar a + algebraMap ℚ Qbar b * s) +
          (algebraMap ℚ Qbar a' + algebraMap ℚ Qbar b' * s) := by
      rw [quadraticRepresentation_spec s xi, quadraticRepresentation_spec s eta]
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
    _ = algebraMap ℚ Qbar (a + a') + algebraMap ℚ Qbar (b + b') * s := by
      rw [map_add, map_add, add_mul]

/-- `claim_quadratic_addition_mem` の具体版。 -/
theorem quadraticAdd_mem
    (s : Qbar) (xi eta : QuadraticFieldElement s) :
    (xi : Qbar) + (eta : Qbar) ∈ quadraticFieldSet s :=
  (quadraticAddElement s xi eta).property

/-- `claim_quadratic_addition_representation` の具体版。 -/
theorem quadraticRepresentation_add
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi eta : QuadraticFieldElement s) :
    quadraticRepresentation s (quadraticAddElement s xi eta) =
      ((quadraticRepresentation s xi).1 + (quadraticRepresentation s eta).1,
        (quadraticRepresentation s xi).2 + (quadraticRepresentation s eta).2) := by
  apply quadraticRepresentation_eq s hs
  change (xi : Qbar) + (eta : Qbar) =
    algebraMap ℚ Qbar ((quadraticRepresentation s xi).1 +
      (quadraticRepresentation s eta).1) +
      algebraMap ℚ Qbar ((quadraticRepresentation s xi).2 +
        (quadraticRepresentation s eta).2) * s
  rw [quadraticRepresentation_spec s xi, quadraticRepresentation_spec s eta]
  rw [map_add, map_add]
  ring

end Ising2DLambda.FisherZero
