import Mathlib.LinearAlgebra.Matrix.Determinant.Basic

namespace Ising2DLambda.NecSuf.KacWard

theorem fiberDirectionDeterminant {J D R : Type*} [Fintype J] [Fintype D]
    [DecidableEq J] [DecidableEq D] [CommRing R]
    (e : J ≃ D) (A : Matrix J J R) (B : Matrix D D R)
    (h : ∀ d d', A (e.symm d) (e.symm d') = B d d') :
    A.det = B.det := by
  have hMatrix : Matrix.reindex e e A = B := by
    apply Matrix.ext
    intro d d'
    exact h d d'
  rw [← Matrix.det_reindex_self e A, hMatrix]

end Ising2DLambda.NecSuf.KacWard
