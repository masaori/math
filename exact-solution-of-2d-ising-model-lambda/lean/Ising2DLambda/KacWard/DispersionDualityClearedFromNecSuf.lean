import Ising2DLambda.KacWard.DispersionDualityCleared
import Ising2DLambda.NecSuf.KacWard.DispersionDualityCleared

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue Polynomial

theorem dispersionPolynomial_duality_cleared_from_necSuf (varpi varsigma : Qbar) :
    ((1 + (X : QbarPoly)) ^ 2 + (1 - X) ^ 2) ^ 2 -
      (1 - X) * ((1 + X) ^ 2 - (1 - X) ^ 2) * (1 + X) *
        (C varpi + C varpi⁻¹ + C varsigma + C varsigma⁻¹) =
      4 * dispersionPolynomial varpi varsigma := by
  unfold dispersionPolynomial
  exact Ising2DLambda.NecSuf.KacWard.dispersion_duality_cleared
    (X : QbarPoly) (C varpi + C varpi⁻¹ + C varsigma + C varsigma⁻¹)

end Ising2DLambda.KacWard
