import Ising2DLambda.KacWard.ModeSmallMatrixRemainingTerms

namespace Ising2DLambda.KacWard

open Polynomial
open Ising2DLambda.AlgebraicEigenvalue

/-- The concrete algebraic rearrangement of the nine admissible permutation terms.
The first equality in the text expands the product and cancels the two mode
inverses; the second equality refactors the polynomial. -/
theorem modeSmallMatrix_signed_sum_algebra
    (varpi varsigma : Qbar) (hp : varpi ≠ 0) (hs : varsigma ≠ 0) :
    let d0 : QbarPoly := 1 - X * C varpi
    let d1 : QbarPoly := 1 - X * C varsigma
    let d2 : QbarPoly := 1 - X * C varpi⁻¹
    let d3 : QbarPoly := 1 - X * C varsigma⁻¹
    d0*d1*d2*d3 - X^2 *
      (C varpi⁻¹*C varsigma⁻¹*d0*d1 + C varpi⁻¹*C varsigma*d0*d3 +
       C varpi*C varsigma*d2*d3 + C varpi*C varsigma⁻¹*d1*d2) + 4*X^4 =
      (1+X^2)^2-X*(1-X^2)*(C varpi+C varpi⁻¹+C varsigma+C varsigma⁻¹) := by
  dsimp
  -- The human proof uses that both modes are nonzero roots of unity.
  have hpsp : varpi * varsigma * varpi⁻¹ = varsigma := by
    field_simp [hp]
  have hspis : varsigma * varpi⁻¹ * varsigma⁻¹ = varpi⁻¹ := by
    field_simp [hp, hs]
  calc
    -- Expand the signed sum and collect coefficients of each power of X.
    _ = 1 - X*(C varpi+C varpi⁻¹+C varsigma+C varsigma⁻¹) +
        2*X^2 + X^3*(C varpi+C varpi⁻¹+C varsigma+C varsigma⁻¹) + X^4 := by
          ring_nf
          simp [← map_mul, hp, hs, hpsp, hspis]
          ring
    -- Factor the four resulting polynomial coefficients.
    _ = (1+X^2)^2-X*(1-X^2)*(C varpi+C varpi⁻¹+C varsigma+C varsigma⁻¹) := by ring

end Ising2DLambda.KacWard
