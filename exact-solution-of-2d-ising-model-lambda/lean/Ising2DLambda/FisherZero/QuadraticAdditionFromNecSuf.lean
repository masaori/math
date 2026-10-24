import Ising2DLambda.FisherZero.QuadraticAddition
import Ising2DLambda.NecSuf.FisherZero.QuadraticAddition

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem quadraticAdd_mem_from_necSuf
    (s : Qbar) (xi eta : QuadraticFieldElement s) :
    (xi : Qbar) + (eta : Qbar) ∈ quadraticFieldSet s := by
  exact Ising2DLambda.NecSuf.FisherZero.add_mem_necSuf
    (algebraMap ℚ Qbar) (fun u => u * s)
    (fun u v w => add_assoc u v w)
    (fun b a => add_comm _ _)
    (fun b d => add_mul _ _ _)
    (fun a c => map_add (algebraMap ℚ Qbar) a c)
    (xi : Qbar) (eta : Qbar)
    (quadraticRepresentation s xi).1 (quadraticRepresentation s xi).2
    (quadraticRepresentation s eta).1 (quadraticRepresentation s eta).2
    (quadraticRepresentation_spec s xi) (quadraticRepresentation_spec s eta)

theorem quadraticRepresentation_add_from_necSuf
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi eta : QuadraticFieldElement s) :
    quadraticRepresentation s (quadraticAddElement s xi eta) =
      ((quadraticRepresentation s xi).1 + (quadraticRepresentation s eta).1,
        (quadraticRepresentation s xi).2 + (quadraticRepresentation s eta).2) := by
  exact Ising2DLambda.NecSuf.FisherZero.add_representation_necSuf
    (quadraticAddElement s) (fun x : QuadraticFieldElement s => (x : Qbar))
    (quadraticRepresentation s) (algebraMap ℚ Qbar) (fun u => u * s)
    (fun u v w => add_assoc u v w)
    (fun b a => add_comm _ _)
    (fun b d => add_mul _ _ _)
    (fun a c => map_add (algebraMap ℚ Qbar) a c)
    (fun _ _ => rfl)
    (quadraticRepresentation_spec s)
    (fun x a b hx => quadraticRepresentation_eq s hs x a b hx) xi eta

end Ising2DLambda.FisherZero
