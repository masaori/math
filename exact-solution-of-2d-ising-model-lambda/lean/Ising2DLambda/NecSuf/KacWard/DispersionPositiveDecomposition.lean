import Ising2DLambda.NecSuf.KacWard.DispersionPolynomial

namespace Ising2DLambda.NecSuf.KacWard

open Polynomial

/-- The calculation uses only ring operations after the inverses are fixed. -/
theorem dispersion_positive_decomposition {R : Type*} [Field R]
    (varpi varsigma : R) :
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

end Ising2DLambda.NecSuf.KacWard
