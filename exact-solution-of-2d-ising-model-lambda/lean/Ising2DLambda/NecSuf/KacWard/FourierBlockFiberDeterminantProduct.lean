import Mathlib.LinearAlgebra.Matrix.Determinant.Basic

namespace Ising2DLambda.NecSuf.KacWard

/- claim_fourier_block_fiber_determinant_product: only the determinant
   identification and the block product under off-fiber vanishing are used.
   Fourier modes, algebraic closure, and polynomial coefficients play no role. -/
theorem fourier_block_fiber_determinant_product_necSuf
    {J K R : Type*} [Fintype J] [Fintype K] [DecidableEq J] [DecidableEq K]
    [CommRing R]
    (D : R) (T : Matrix J J R) (block : J → K)
    (hD : D = Matrix.det T)
    (hoff : ∀ i j, block i ≠ block j → T i j = 0)
    (hblock : (∀ i j, block i ≠ block j → T i j = 0) →
      Matrix.det T = ∏ k : K,
        Matrix.det (fun i j : {v : J // block v = k} => T i.1 j.1)) :
    D = ∏ k : K,
      Matrix.det (fun i j : {v : J // block v = k} => T i.1 j.1) := by
  calc
    D = Matrix.det T := hD
    _ = ∏ k : K,
        Matrix.det (fun i j : {v : J // block v = k} => T i.1 j.1) := hblock hoff

end Ising2DLambda.NecSuf.KacWard
