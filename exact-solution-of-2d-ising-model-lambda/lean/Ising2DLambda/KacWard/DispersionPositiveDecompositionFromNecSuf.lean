import Ising2DLambda.KacWard.DispersionPositiveDecomposition
import Ising2DLambda.KacWard.DispersionPolynomialFromNecSuf
import Ising2DLambda.NecSuf.KacWard.DispersionPositiveDecomposition

namespace Ising2DLambda.KacWard

open Polynomial
open Ising2DLambda.AlgebraicEigenvalue

theorem dispersion_positive_decomposition_from_necSuf (varpi varsigma : Qbar) :
    dispersionPolynomial varpi varsigma - (X ^ 2 + 2 * X - 1) ^ 2 =
      X * (1 - X ^ 2) *
        ((2 - C varpi - C varpi⁻¹) + (2 - C varsigma - C varsigma⁻¹)) := by
  rw [dispersionPolynomial_from_necSuf]
  exact Ising2DLambda.NecSuf.KacWard.dispersion_positive_decomposition varpi varsigma

end Ising2DLambda.KacWard
