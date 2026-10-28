import Ising2DLambda.KacWard.DispersionSpecialModeSquares
import Ising2DLambda.KacWard.DispersionPolynomialFromNecSuf
import Ising2DLambda.NecSuf.KacWard.DispersionSpecialModeSquares

namespace Ising2DLambda.KacWard

open Polynomial
open Ising2DLambda.AlgebraicEigenvalue

theorem dispersion_special_mode_squares_from_necSuf :
    dispersionPolynomial 1 1 = (1 - 2 * X - X ^ 2) ^ 2 ∧
    dispersionPolynomial 1 (-1) = (1 + X ^ 2) ^ 2 ∧
    dispersionPolynomial (-1) 1 = (1 + X ^ 2) ^ 2 ∧
    dispersionPolynomial (-1) (-1) = (1 + 2 * X - X ^ 2) ^ 2 := by
  simp only [dispersionPolynomial_from_necSuf]
  exact Ising2DLambda.NecSuf.KacWard.dispersion_special_mode_squares

end Ising2DLambda.KacWard
