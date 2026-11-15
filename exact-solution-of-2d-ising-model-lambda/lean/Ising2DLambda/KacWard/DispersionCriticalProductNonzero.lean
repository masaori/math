import Ising2DLambda.KacWard.DispersionCriticalNonzero
import Ising2DLambda.KacWard.DispersionModeProduct
import Ising2DLambda.KacWard.DeterminantSignedEvenSubgraphSquare

namespace Ising2DLambda.KacWard

open Polynomial
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero

/-- The actual nontrivial twisted signed polynomial is nonzero at the critical point. -/
theorem signedEvenSubgraph_critical_nonzero (data : RealClosedSubfieldData) (L : ℕ) [NeZero L]
    (hL : 1 ≤ L) (z : Qbar) (hz : z ^ (4 : ℕ) = -1)
    (s : SpinStructure) (hs : s ≠ (false, false))
    (x : Qbar) (hx : x ^ 2 + 2 * x - 1 = 0)
    (hx0 : x ≠ 0) (hx1 : x ^ 2 ≠ 1) :
    ((signedEvenSubgraphPolynomial L (spinComponentFin s.1)
      (spinComponentFin s.2)).map (Int.castRingHom Qbar)).eval x ≠ 0 := by
  have hfactor : ∀ m : FourierModePair L s,
      (dispersionPolynomial m.1.1 m.1.2).eval x ≠ 0 := by
    intro m
    exact dispersion_critical_nonzero data L hL s hs m.1.1 m.1.2
      m.2.1 m.2.2 x hx hx0 hx1
  have hproduct := congrArg (Polynomial.eval x) (dispersion_mode_product (L := L) z hz s)
  have hsquare := congrArg (Polynomial.eval x)
    (kacWardDeterminant_eq_signedEvenSubgraphPolynomial_sq (L := L) z hz s)
  simp only [eval_prod, eval_pow] at hproduct hsquare
  intro hzero
  have hnonzero : (∏ m : FourierModePair L s,
      (dispersionPolynomial m.1.1 m.1.2).eval x) ≠ 0 := by
    apply Finset.prod_ne_zero_iff.mpr
    intro m _
    exact hfactor m
  apply hnonzero
  rw [← hproduct, hsquare, hzero]
  ring

end Ising2DLambda.KacWard
