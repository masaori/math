import Ising2DLambda.KacWard.ModeSmallMatrixDeterminantDispersion

namespace Ising2DLambda.KacWard

open Polynomial
open Ising2DLambda.AlgebraicEigenvalue

/-- The dispersion factor as a polynomial over algebraic numbers. -/
noncomputable def dispersionPolynomial (varpi varsigma : Qbar) : QbarPoly :=
  (1 + X ^ 2) ^ 2 - X * (1 - X ^ 2) *
    (C varpi + C varpi⁻¹ + C varsigma + C varsigma⁻¹)

end Ising2DLambda.KacWard
