import Ising2DLambda.KacWard.SignedEvenSubgraphDualityUpToSign
import Ising2DLambda.KacWard.SignedEvenSubgraphDualitySquaresFromNecSuf
import Ising2DLambda.NecSuf.KacWard.SignedEvenSubgraphDualityUpToSign

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- The domain argument specializes to the actual torus polynomials. -/
theorem signedEvenSubgraphDuality_up_to_sign_from_necSuf (L : ℕ) [NeZero L]
    (z : Qbar) (hz : z ^ 4 = -1) (s : SpinStructure) :
    signedEvenSubgraphDualityCleared L (spinComponentFin s.1)
        (spinComponentFin s.2) =
        2 ^ (L ^ 2) *
          (signedEvenSubgraphPolynomial L (spinComponentFin s.1)
            (spinComponentFin s.2)).map (Int.castRingHom Qbar) ∨
      signedEvenSubgraphDualityCleared L (spinComponentFin s.1)
        (spinComponentFin s.2) =
        -(2 ^ (L ^ 2) *
          (signedEvenSubgraphPolynomial L (spinComponentFin s.1)
            (spinComponentFin s.2)).map (Int.castRingHom Qbar)) := by
  exact Ising2DLambda.NecSuf.KacWard.duality_up_to_sign _ _
    (signedEvenSubgraphDuality_squares_from_necSuf L z hz s)

end Ising2DLambda.KacWard
