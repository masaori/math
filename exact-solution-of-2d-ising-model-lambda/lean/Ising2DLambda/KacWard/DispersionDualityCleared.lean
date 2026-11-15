import Ising2DLambda.KacWard.DispersionPolynomial

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue Polynomial

/-- The actual dispersion factor after clearing the four denominators. -/
theorem dispersionPolynomial_duality_cleared (varpi varsigma : Qbar) :
    ((1 + (X : QbarPoly)) ^ 2 + (1 - X) ^ 2) ^ 2 -
      (1 - X) * ((1 + X) ^ 2 - (1 - X) ^ 2) * (1 + X) *
        (C varpi + C varpi⁻¹ + C varsigma + C varsigma⁻¹) =
      4 * dispersionPolynomial varpi varsigma := by
  unfold dispersionPolynomial
  ring

end Ising2DLambda.KacWard
