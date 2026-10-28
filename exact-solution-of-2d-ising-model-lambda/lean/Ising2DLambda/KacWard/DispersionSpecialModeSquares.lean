import Ising2DLambda.KacWard.DispersionPolynomial

namespace Ising2DLambda.KacWard

open Polynomial
open Ising2DLambda.AlgebraicEigenvalue

/-- The four fixed modes factor as squares in the algebraic polynomial ring. -/
theorem dispersion_special_mode_squares :
    dispersionPolynomial 1 1 = (1 - 2 * X - X ^ 2) ^ 2 ∧
    dispersionPolynomial 1 (-1) = (1 + X ^ 2) ^ 2 ∧
    dispersionPolynomial (-1) 1 = (1 + X ^ 2) ^ 2 ∧
    dispersionPolynomial (-1) (-1) = (1 + 2 * X - X ^ 2) ^ 2 := by
  constructor
  · calc
      dispersionPolynomial 1 1 =
          (1 + X ^ 2) ^ 2 - X * (1 - X ^ 2) * (1 + 1 + 1 + 1) := by
            simp [dispersionPolynomial]
      _ = (1 + X ^ 2) ^ 2 - 4 * X * (1 - X ^ 2) := by ring
      _ = (1 - 2 * X - X ^ 2) ^ 2 := by ring
  constructor
  · calc
      dispersionPolynomial 1 (-1) =
          (1 + X ^ 2) ^ 2 - X * (1 - X ^ 2) * (1 + 1 - 1 - 1) := by
            simp [dispersionPolynomial]
      _ = (1 + X ^ 2) ^ 2 := by ring
  constructor
  · calc
      dispersionPolynomial (-1) 1 =
          (1 + X ^ 2) ^ 2 - X * (1 - X ^ 2) * (-1 - 1 + 1 + 1) := by
            simp [dispersionPolynomial]
      _ = (1 + X ^ 2) ^ 2 := by ring
  · calc
      dispersionPolynomial (-1) (-1) =
          (1 + X ^ 2) ^ 2 - X * (1 - X ^ 2) * (-1 - 1 - 1 - 1) := by
            simp only [dispersionPolynomial, inv_neg, inv_one, map_neg, map_one]
            ring
      _ = (1 + X ^ 2) ^ 2 + 4 * X * (1 - X ^ 2) := by ring
      _ = (1 + 2 * X - X ^ 2) ^ 2 := by ring

end Ising2DLambda.KacWard
