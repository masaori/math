import Ising2DLambda.KacWard.FourierModePairIndex
import Ising2DLambda.KacWard.FourierSimilarityPreservesDeterminant
import Ising2DLambda.AlgebraicEigenvalue.BlockDiagonalDeterminantProduct
import Ising2DLambda.NecSuf.KacWard.FourierBlockFiberDeterminantProduct

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/- claim_fourier_block_fiber_determinant_product: specialize the same two-step
   argument to the actual Fourier mode map and polynomial matrix. -/
theorem fourier_block_fiber_determinant_product_from_necSuf {L : ℕ} [NeZero L]
    (z : Qbar) (s : SpinStructure)
    (κ : OrientedEdge L ≃ {m // m ∈ fourierModeIndexSet L s}) :
    kacWardDeterminant (kacWardTransitionMatrix L z s) =
      ∏ m : FourierModePair L s,
        Matrix.det (fun i j :
          {e : OrientedEdge L // fourierModeBlockIndex s κ e = m} =>
            (1 - (Polynomial.X : QbarPoly) •
              (modeBlockMatrix z s κ).map Polynomial.C) i.1 j.1) := by
  classical
  let T : Matrix (OrientedEdge L) (OrientedEdge L) QbarPoly :=
    1 - (Polynomial.X : QbarPoly) •
      (modeBlockMatrix z s κ).map Polynomial.C
  have hD : kacWardDeterminant (kacWardTransitionMatrix L z s) = Matrix.det T :=
    fourier_similarity_preserves_determinant z s κ
  have hoff : ∀ i j : OrientedEdge L,
      fourierModeBlockIndex s κ i ≠ fourierModeBlockIndex s κ j → T i j = 0 := by
    intro i j hij
    exact fourierModeBlock_off_fiber_zero z s κ i j hij
  exact NecSuf.KacWard.fourier_block_fiber_determinant_product_necSuf
    (kacWardDeterminant (kacWardTransitionMatrix L z s)) T
    (fourierModeBlockIndex s κ) hD hoff
    (blockDiagonal_det_eq_prod_fiber_dets (fourierModeBlockIndex s κ) T)

end Ising2DLambda.KacWard
