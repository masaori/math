import Ising2DLambda.KacWard.DispersionPolynomial

namespace Ising2DLambda.KacWard

open Polynomial
open Ising2DLambda.AlgebraicEigenvalue

/-- The positive decomposition is a polynomial identity over algebraic numbers. -/
theorem dispersion_positive_decomposition (varpi varsigma : Qbar) :
    dispersionPolynomial varpi varsigma - (X ^ 2 + 2 * X - 1) ^ 2 =
      X * (1 - X ^ 2) *
        ((2 - C varpi - C varpi⁻¹) + (2 - C varsigma - C varsigma⁻¹)) := by
  calc
    dispersionPolynomial varpi varsigma - (X ^ 2 + 2 * X - 1) ^ 2 =
        (1 + X ^ 2) ^ 2 - X * (1 - X ^ 2) *
          (C varpi + C varpi⁻¹ + C varsigma + C varsigma⁻¹) -
          (X ^ 2 + 2 * X - 1) ^ 2 := by rfl
    _ = 4 * X * (1 - X ^ 2) - X * (1 - X ^ 2) *
          (C varpi + C varpi⁻¹ + C varsigma + C varsigma⁻¹) := by ring
    _ = X * (1 - X ^ 2) *
          (4 - C varpi - C varpi⁻¹ - C varsigma - C varsigma⁻¹) := by ring
    _ = X * (1 - X ^ 2) *
          ((2 - C varpi - C varpi⁻¹) + (2 - C varsigma - C varsigma⁻¹)) := by ring

end Ising2DLambda.KacWard
