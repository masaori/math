import Ising2DLambda.AlgebraicEigenvalue.BlockDiagonalDeterminantProduct

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- For Qbar polynomial matrices, only the finite block map, vanishing off
    distinct fibers, and the determinant identification are used. -/
theorem fourier_block_fiber_determinant_bridge
    {J K : Type*} [Fintype J] [LinearOrder J] [Fintype K] [LinearOrder K]
    (D : Polynomial Qbar) (T : Matrix J J (Polynomial Qbar)) (block : J → K)
    (hD : D = Matrix.det T)
    (hoff : ∀ i j, block i ≠ block j → T i j = 0) :
    D = ∏ k : K,
      Matrix.det (fun i j : {v : J // block v = k} => T i.1 j.1) := by
  calc
    D = Matrix.det T := hD
    _ = ∏ k : K,
        Matrix.det (fun i j : {v : J // block v = k} => T i.1 j.1) :=
      blockDiagonal_det_eq_prod_fiber_dets block T hoff

end Ising2DLambda.KacWard
