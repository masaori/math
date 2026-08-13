import Ising2DLambda.FisherZero.QuadraticZeroNegation
import Ising2DLambda.NecSuf.FisherZero.QuadraticZeroNegation

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem quadraticZero_mem_from_necSuf (s : Qbar) :
    (0 : Qbar) ∈ quadraticFieldSet s := by
  apply Ising2DLambda.NecSuf.FisherZero.zero_mem_necSuf
      (0 : ℚ) (0 : Qbar)
      (fun a b => algebraMap ℚ Qbar a + algebraMap ℚ Qbar b * s)
  simp

theorem quadraticRepresentation_eq_zero_iff_from_necSuf
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi : QuadraticFieldElement s) :
    (xi : Qbar) = 0 ↔ quadraticRepresentation s xi = (0, 0) := by
  apply Ising2DLambda.NecSuf.FisherZero.zero_representation_necSuf
      (value := fun eta : QuadraticFieldElement s => (eta : Qbar))
      (combine := fun a b : ℚ => algebraMap ℚ Qbar a + algebraMap ℚ Qbar b * s)
      (rep := quadraticRepresentation s)
      (zeroK := quadraticZeroElement s)
  · exact quadraticRepresentation_spec s
  · intro x a b hx
    exact quadraticRepresentation_eq s hs x a b hx
  · simp [quadraticZeroElement]

theorem quadraticNeg_mem_from_necSuf (s : Qbar) (xi : QuadraticFieldElement s) :
    -(xi : Qbar) ∈ quadraticFieldSet s := by
  apply Ising2DLambda.NecSuf.FisherZero.neg_mem_necSuf
      Neg.neg Neg.neg
      (fun c d : ℚ => algebraMap ℚ Qbar c + algebraMap ℚ Qbar d * s)
      (quadraticRepresentation s xi).1 (quadraticRepresentation s xi).2 (xi : Qbar)
  · exact quadraticRepresentation_spec s xi
  · calc
      -(xi : Qbar) =
          -(algebraMap ℚ Qbar (quadraticRepresentation s xi).1 +
            algebraMap ℚ Qbar (quadraticRepresentation s xi).2 * s) := by
        exact congrArg Neg.neg (quadraticRepresentation_spec s xi)
      _ = (-algebraMap ℚ Qbar (quadraticRepresentation s xi).1) +
          (-(algebraMap ℚ Qbar (quadraticRepresentation s xi).2 * s)) := by rw [neg_add]
      _ = algebraMap ℚ Qbar (-(quadraticRepresentation s xi).1) +
          algebraMap ℚ Qbar (-(quadraticRepresentation s xi).2) * s := by
        rw [map_neg, map_neg, neg_mul]

theorem quadraticRepresentation_neg_from_necSuf
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi : QuadraticFieldElement s) :
    quadraticRepresentation s (quadraticNegElement s xi) =
      (-(quadraticRepresentation s xi).1, -(quadraticRepresentation s xi).2) := by
  apply Ising2DLambda.NecSuf.FisherZero.neg_representation_necSuf
      Neg.neg (fun eta : QuadraticFieldElement s => quadraticNegElement s eta)
      (fun eta : QuadraticFieldElement s => (eta : Qbar))
      (fun a b : ℚ => algebraMap ℚ Qbar a + algebraMap ℚ Qbar b * s)
      (quadraticRepresentation s)
  · intro x a b hx
    exact quadraticRepresentation_eq s hs x a b hx
  · change -(xi : Qbar) =
      algebraMap ℚ Qbar (-(quadraticRepresentation s xi).1) +
        algebraMap ℚ Qbar (-(quadraticRepresentation s xi).2) * s
    calc
      -(xi : Qbar) =
          -(algebraMap ℚ Qbar (quadraticRepresentation s xi).1 +
            algebraMap ℚ Qbar (quadraticRepresentation s xi).2 * s) := by
        exact congrArg Neg.neg (quadraticRepresentation_spec s xi)
      _ = (-algebraMap ℚ Qbar (quadraticRepresentation s xi).1) +
          (-(algebraMap ℚ Qbar (quadraticRepresentation s xi).2 * s)) := by rw [neg_add]
      _ = algebraMap ℚ Qbar (-(quadraticRepresentation s xi).1) +
          algebraMap ℚ Qbar (-(quadraticRepresentation s xi).2) * s := by
        rw [map_neg, map_neg, neg_mul]

end Ising2DLambda.FisherZero
