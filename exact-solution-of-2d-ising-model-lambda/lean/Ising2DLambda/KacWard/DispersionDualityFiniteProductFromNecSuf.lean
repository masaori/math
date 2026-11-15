import Ising2DLambda.KacWard.DispersionDualityFiniteProduct
import Ising2DLambda.KacWard.DispersionDualityClearedFromNecSuf
import Ising2DLambda.KacWard.DispersionModeProductFromNecSuf
import Ising2DLambda.NecSuf.KacWard.DispersionDualityFiniteProduct

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- The concrete mode product follows by specializing the finite-product
argument to the actual dispersion factors. -/
theorem dispersion_mode_product_duality_factor_from_necSuf {L : ℕ} [NeZero L]
    (z x : Qbar) (hz4 : z ^ 4 = -1) (s : SpinStructure)
    (hx : 1 + x ≠ 0) :
    (1 + x) ^ (4 * Fintype.card (FourierModePair L s)) *
        (kacWardDeterminant (kacWardTransitionMatrix L z s)).eval
          (Ising2DLambda.FisherZero.kwDualTransform x) =
      4 ^ Fintype.card (FourierModePair L s) *
        (kacWardDeterminant (kacWardTransitionMatrix L z s)).eval x := by
  classical
  simp only [dispersion_mode_product_from_necSuf z hz4 s, Polynomial.eval_prod]
  exact Ising2DLambda.NecSuf.KacWard.dispersion_duality_finite_product
    x (fun m : FourierModePair L s =>
      (dispersionPolynomial m.1.1 m.1.2).eval
        (Ising2DLambda.FisherZero.kwDualTransform x))
    (fun m : FourierModePair L s => (dispersionPolynomial m.1.1 m.1.2).eval x)
    (fun m => dispersionPolynomial_duality_factor_from_necSuf m.1.1 m.1.2 x hx)

end Ising2DLambda.KacWard
