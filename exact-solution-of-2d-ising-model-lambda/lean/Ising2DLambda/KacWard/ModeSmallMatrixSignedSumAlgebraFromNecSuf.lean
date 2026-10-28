import Ising2DLambda.KacWard.ModeSmallMatrixSignedSumAlgebra
import Ising2DLambda.NecSuf.KacWard.ModeSmallMatrixSignedSumAlgebra

namespace Ising2DLambda.KacWard

open Polynomial
open Ising2DLambda.AlgebraicEigenvalue

/-- The generic field calculation specializes to algebraic numbers. -/
theorem modeSmallMatrix_signed_sum_algebra_from_necSuf
    (varpi varsigma : Qbar) (hp : varpi ≠ 0) (hs : varsigma ≠ 0) :
    let d0 : QbarPoly := 1 - X * C varpi
    let d1 : QbarPoly := 1 - X * C varsigma
    let d2 : QbarPoly := 1 - X * C varpi⁻¹
    let d3 : QbarPoly := 1 - X * C varsigma⁻¹
    d0*d1*d2*d3 - X^2 *
      (C varpi⁻¹*C varsigma⁻¹*d0*d1 + C varpi⁻¹*C varsigma*d0*d3 +
       C varpi*C varsigma*d2*d3 + C varpi*C varsigma⁻¹*d1*d2) + 4*X^4 =
      (1+X^2)^2-X*(1-X^2)*(C varpi+C varpi⁻¹+C varsigma+C varsigma⁻¹) := by
  exact Ising2DLambda.NecSuf.KacWard.modeSmallMatrix_signed_sum_algebra
    varpi varsigma hp hs

end Ising2DLambda.KacWard
