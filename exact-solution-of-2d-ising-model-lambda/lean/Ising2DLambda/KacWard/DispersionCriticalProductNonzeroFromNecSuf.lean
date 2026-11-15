import Ising2DLambda.KacWard.DispersionCriticalProductNonzero
import Ising2DLambda.NecSuf.KacWard.DispersionCriticalProductNonzero

namespace Ising2DLambda.KacWard

open Polynomial
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero

/-- The finite-product lemma specializes to the actual twisted modes and signed polynomial. -/
theorem signedEvenSubgraph_critical_nonzero_from_necSuf
    (data : RealClosedSubfieldData) (L : ℕ) [NeZero L] (hL : 1 ≤ L)
    (z : Qbar) (hz : z ^ (4 : ℕ) = -1)
    (s : SpinStructure) (hs : s ≠ (false, false))
    (x : Qbar) (hx : x ^ 2 + 2 * x - 1 = 0)
    (hx0 : x ≠ 0) (hx1 : x ^ 2 ≠ 1) :
    ((signedEvenSubgraphPolynomial L (spinComponentFin s.1)
      (spinComponentFin s.2)).map (Int.castRingHom Qbar)).eval x ≠ 0 := by
  apply Ising2DLambda.NecSuf.KacWard.signed_value_nonzero_of_mode_product
    (((signedEvenSubgraphPolynomial L (spinComponentFin s.1)
      (spinComponentFin s.2)).map (Int.castRingHom Qbar)).eval x)
    ((kacWardDeterminant (kacWardTransitionMatrix L z s)).eval x)
    (fun m : FourierModePair L s => (dispersionPolynomial m.1.1 m.1.2).eval x)
  · simpa only [eval_pow] using congrArg (Polynomial.eval x)
      (kacWardDeterminant_eq_signedEvenSubgraphPolynomial_sq (L := L) z hz s)
  · simpa only [eval_prod] using congrArg (Polynomial.eval x)
      (dispersion_mode_product (L := L) z hz s)
  · intro m
    exact dispersion_critical_nonzero data L hL s hs m.1.1 m.1.2
      m.2.1 m.2.2 x hx hx0 hx1

end Ising2DLambda.KacWard
