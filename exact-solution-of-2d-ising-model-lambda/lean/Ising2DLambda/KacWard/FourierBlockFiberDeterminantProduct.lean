import Ising2DLambda.KacWard.FourierModePairIndex
import Ising2DLambda.KacWard.FourierBlockFiberDeterminantBridge
import Ising2DLambda.KacWard.FourierSimilarityPreservesDeterminant

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/- claim_fourier_block_fiber_determinant_product: the determinant identification
   and off-fiber zero entries are the two hypotheses of the block product. -/
theorem fourier_block_fiber_determinant_product {L : ℕ} [NeZero L]
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
  exact fourier_block_fiber_determinant_bridge
    (kacWardDeterminant (kacWardTransitionMatrix L z s)) T
    (fourierModeBlockIndex s κ) hD hoff

end Ising2DLambda.KacWard
