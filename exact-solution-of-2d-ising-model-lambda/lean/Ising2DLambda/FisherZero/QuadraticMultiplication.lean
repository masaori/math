/-
「二次体の積の表示」の具体版。
本文と同じ三つの補助等式と十四段の等式列で積の表示を作る。
-/
import Ising2DLambda.FisherZero.QuadraticPositiveCone

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `xi * eta` を `Q_s` の元として持ち上げる。 -/
noncomputable def quadraticMulElement
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi eta : QuadraticFieldElement s) : QuadraticFieldElement s := by
  refine ⟨(xi : Qbar) * (eta : Qbar),
    (quadraticRepresentation s xi).1 * (quadraticRepresentation s eta).1 +
      2 * ((quadraticRepresentation s xi).2 * (quadraticRepresentation s eta).2),
    (quadraticRepresentation s xi).1 * (quadraticRepresentation s eta).2 +
      (quadraticRepresentation s xi).2 * (quadraticRepresentation s eta).1, ?_⟩
  rw [quadraticRepresentation_spec s xi, quadraticRepresentation_spec s eta]
  push_cast
  let A : Qbar := algebraMap ℚ Qbar (quadraticRepresentation s xi).1
  let B : Qbar := algebraMap ℚ Qbar (quadraticRepresentation s xi).2
  let A' : Qbar := algebraMap ℚ Qbar (quadraticRepresentation s eta).1
  let B' : Qbar := algebraMap ℚ Qbar (quadraticRepresentation s eta).2
  change (A + B * s) * (A' + B' * s) =
    A * A' + algebraMap ℚ Qbar 2 * (B * B') + (A * B' + B * A') * s
  have h₁ : A * (B' * s) = (A * B') * s := by rw [mul_assoc]
  have h₂ : (B * s) * A' = (B * A') * s := by
    calc
      (B * s) * A' = B * (s * A') := by rw [mul_assoc]
      _ = B * (A' * s) := by rw [mul_comm s A']
      _ = (B * A') * s := by rw [mul_assoc]
  have h₃ : (B * s) * (B' * s) = algebraMap ℚ Qbar 2 * (B * B') := by
    calc
      (B * s) * (B' * s) = ((B * s) * B') * s := by rw [← mul_assoc]
      _ = (B * (s * B')) * s := by rw [mul_assoc B s B']
      _ = (B * (B' * s)) * s := by rw [mul_comm s B']
      _ = ((B * B') * s) * s := by rw [← mul_assoc B B' s]
      _ = (B * B') * (s * s) := by rw [mul_assoc]
      _ = (B * B') * algebraMap ℚ Qbar 2 := by rw [hs]
      _ = algebraMap ℚ Qbar 2 * (B * B') := by rw [mul_comm]
  calc
    (A + B * s) * (A' + B' * s) =
        A * (A' + B' * s) + (B * s) * (A' + B' * s) := by rw [add_mul]
    _ = (A * A' + A * (B' * s)) + (B * s) * (A' + B' * s) := by rw [mul_add]
    _ = (A * A' + A * (B' * s)) + ((B * s) * A' + (B * s) * (B' * s)) := by rw [mul_add]
    _ = (A * A' + (A * B') * s) + ((B * s) * A' + (B * s) * (B' * s)) := by rw [h₁]
    _ = (A * A' + (A * B') * s) + ((B * A') * s + (B * s) * (B' * s)) := by rw [h₂]
    _ = (A * A' + (A * B') * s) + ((B * A') * s + algebraMap ℚ Qbar 2 * (B * B')) := by rw [h₃]
    _ = (A * A' + (A * B') * s) + (algebraMap ℚ Qbar 2 * (B * B') + (B * A') * s) := by rw [add_comm ((B * A') * s)]
    _ = A * A' + ((A * B') * s + (algebraMap ℚ Qbar 2 * (B * B') + (B * A') * s)) := by rw [add_assoc]
    _ = A * A' + (((A * B') * s + algebraMap ℚ Qbar 2 * (B * B')) + (B * A') * s) := by rw [add_assoc]
    _ = A * A' + ((algebraMap ℚ Qbar 2 * (B * B') + (A * B') * s) + (B * A') * s) := by rw [add_comm ((A * B') * s)]
    _ = A * A' + (algebraMap ℚ Qbar 2 * (B * B') + ((A * B') * s + (B * A') * s)) := by rw [add_assoc]
    _ = (A * A' + algebraMap ℚ Qbar 2 * (B * B')) + ((A * B') * s + (B * A') * s) := by rw [add_assoc]
    _ = (A * A' + algebraMap ℚ Qbar 2 * (B * B')) + (A * B' + B * A') * s := by rw [add_mul]

/-- `claim_quadratic_multiplication_mem` の具体版。 -/
theorem quadraticMul_mem
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi eta : QuadraticFieldElement s) :
    (xi : Qbar) * (eta : Qbar) ∈ quadraticFieldSet s :=
  by simpa [quadraticMulElement] using (quadraticMulElement s hs xi eta).property

/-- `claim_quadratic_multiplication_representation` の具体版。 -/
theorem quadraticRepresentation_mul
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi eta : QuadraticFieldElement s) :
    quadraticRepresentation s (quadraticMulElement s hs xi eta) =
      ((quadraticRepresentation s xi).1 * (quadraticRepresentation s eta).1 +
          2 * ((quadraticRepresentation s xi).2 * (quadraticRepresentation s eta).2),
        (quadraticRepresentation s xi).1 * (quadraticRepresentation s eta).2 +
          (quadraticRepresentation s xi).2 * (quadraticRepresentation s eta).1) := by
  apply quadraticRepresentation_eq s hs
  simp only [quadraticMulElement]
  rw [quadraticRepresentation_spec s xi, quadraticRepresentation_spec s eta]
  push_cast
  ring_nf
  rw [show s ^ 2 = algebraMap ℚ Qbar 2 by simpa [pow_two] using hs]
  ring

end Ising2DLambda.FisherZero
