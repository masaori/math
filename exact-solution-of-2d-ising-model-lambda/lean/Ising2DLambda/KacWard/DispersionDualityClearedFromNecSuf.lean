import Ising2DLambda.KacWard.DispersionDualityCleared
import Ising2DLambda.NecSuf.KacWard.DispersionDualityCleared
import Ising2DLambda.FisherZero.KwDualTransformDomain

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

theorem dispersionPolynomial_duality_factor_from_necSuf (varpi varsigma x : Qbar)
    (hx : 1 + x ≠ 0) :
    (1 + x) ^ 4 *
      (dispersionPolynomial varpi varsigma).eval
        (Ising2DLambda.FisherZero.kwDualTransform x) =
      4 * (dispersionPolynomial varpi varsigma).eval x := by
  simp only [dispersionPolynomial, Polynomial.eval_sub, Polynomial.eval_add,
    Polynomial.eval_mul, Polynomial.eval_pow, Polynomial.eval_one,
    Polynomial.eval_X, Polynomial.eval_C]
  unfold Ising2DLambda.FisherZero.kwDualTransform
  exact Ising2DLambda.NecSuf.KacWard.dispersion_duality_factor x
    (varpi + varpi⁻¹ + varsigma + varsigma⁻¹) hx

end Ising2DLambda.KacWard
