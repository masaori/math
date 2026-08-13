/-
「三分律の準備（零元の特徴づけ・加法逆元の表示）」の具体版。
本文と同じ表示の鎖を使い、台集合への所属と表示の等式を別々に示す。
-/
import Ising2DLambda.FisherZero.QuadraticPositiveCone

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_quadratic_zero_mem` の具体版。 -/
theorem quadraticZero_mem (s : Qbar) : (0 : Qbar) ∈ quadraticFieldSet s := by
  refine ⟨0, 0, ?_⟩
  calc
    (0 : Qbar) = 0 + 0 := by rw [add_zero]
    _ = algebraMap ℚ Qbar 0 + algebraMap ℚ Qbar 0 * s := by simp

/-- 零元を `Q_s` の元として持ち上げる。 -/
noncomputable def quadraticZeroElement (s : Qbar) : QuadraticFieldElement s :=
  ⟨0, quadraticZero_mem s⟩

/-- `claim_quadratic_zero_representation` の具体版。 -/
theorem quadraticRepresentation_eq_zero_iff
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi : QuadraticFieldElement s) :
    (xi : Qbar) = 0 ↔ quadraticRepresentation s xi = (0, 0) := by
  constructor
  · intro hxi
    apply quadraticRepresentation_eq s hs xi 0 0
    calc
      (xi : Qbar) = 0 := hxi
      _ = algebraMap ℚ Qbar 0 + algebraMap ℚ Qbar 0 * s := by simp
  · intro hrep
    calc
      (xi : Qbar) = algebraMap ℚ Qbar (quadraticRepresentation s xi).1 +
          algebraMap ℚ Qbar (quadraticRepresentation s xi).2 * s :=
        quadraticRepresentation_spec s xi
      _ = algebraMap ℚ Qbar 0 + algebraMap ℚ Qbar 0 * s := by rw [hrep]
      _ = 0 := by simp

/-- `-xi` を `Q_s` の元として持ち上げる。 -/
noncomputable def quadraticNegElement (s : Qbar) (xi : QuadraticFieldElement s) :
    QuadraticFieldElement s := by
  let a := (quadraticRepresentation s xi).1
  let b := (quadraticRepresentation s xi).2
  refine ⟨-(xi : Qbar), -a, -b, ?_⟩
  calc
    -(xi : Qbar) = -(algebraMap ℚ Qbar a + algebraMap ℚ Qbar b * s) := by
      rw [quadraticRepresentation_spec s xi]
    _ = (-algebraMap ℚ Qbar a) + (-(algebraMap ℚ Qbar b * s)) := by rw [neg_add]
    _ = algebraMap ℚ Qbar (-a) + algebraMap ℚ Qbar (-b) * s := by
      rw [map_neg, map_neg, neg_mul]

/-- `claim_quadratic_negation_mem` の具体版。 -/
theorem quadraticNeg_mem (s : Qbar) (xi : QuadraticFieldElement s) :
    -(xi : Qbar) ∈ quadraticFieldSet s :=
  (quadraticNegElement s xi).property

/-- `claim_quadratic_negation_representation` の具体版。 -/
theorem quadraticRepresentation_neg
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi : QuadraticFieldElement s) :
    quadraticRepresentation s (quadraticNegElement s xi) =
      (-(quadraticRepresentation s xi).1, -(quadraticRepresentation s xi).2) := by
  apply quadraticRepresentation_eq s hs
      (quadraticNegElement s xi)
      (-(quadraticRepresentation s xi).1) (-(quadraticRepresentation s xi).2)
  change -(xi : Qbar) =
    algebraMap ℚ Qbar (-(quadraticRepresentation s xi).1) +
      algebraMap ℚ Qbar (-(quadraticRepresentation s xi).2) * s
  calc
    -(xi : Qbar) =
        -(algebraMap ℚ Qbar (quadraticRepresentation s xi).1 +
          algebraMap ℚ Qbar (quadraticRepresentation s xi).2 * s) := by
      rw [quadraticRepresentation_spec s xi]
    _ = (-algebraMap ℚ Qbar (quadraticRepresentation s xi).1) +
          (-(algebraMap ℚ Qbar (quadraticRepresentation s xi).2 * s)) := by rw [neg_add]
    _ = algebraMap ℚ Qbar (-(quadraticRepresentation s xi).1) +
          algebraMap ℚ Qbar (-(quadraticRepresentation s xi).2) * s := by
      rw [map_neg, map_neg, neg_mul]

end Ising2DLambda.FisherZero
