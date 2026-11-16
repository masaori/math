import Ising2DLambda.KacWard.DeterminantSignedEvenSubgraphSquare
import Ising2DLambda.KacWard.DispersionModeProduct

namespace Ising2DLambda.RealEscape

open Ising2DLambda.KacWard
open Ising2DLambda.AlgebraicEigenvalue
open Polynomial

/-- At a rational point, the square of the signed polynomial value is the
finite product of the dispersion values for the actual twisted modes. -/
theorem signedEvenSubgraph_square_eq_dispersion_product {L : ℕ} [NeZero L]
    (z : Qbar) (hz : z ^ (4 : ℕ) = -1) (s : SpinStructure) (q : ℚ) :
    (((signedEvenSubgraphPolynomial L (spinComponentFin s.1)
      (spinComponentFin s.2)).map (Int.castRingHom Qbar)).eval (q : Qbar)) ^ 2 =
      ∏ m : FourierModePair L s,
        (dispersionPolynomial m.1.1 m.1.2).eval (q : Qbar) := by
  have hsquare := congrArg (Polynomial.eval (q : Qbar))
    (kacWardDeterminant_eq_signedEvenSubgraphPolynomial_sq (L := L) z hz s)
  have hproduct := congrArg (Polynomial.eval (q : Qbar))
    (dispersion_mode_product (L := L) z hz s)
  simpa only [eval_pow, eval_prod] using hsquare.symm.trans hproduct

end Ising2DLambda.RealEscape
