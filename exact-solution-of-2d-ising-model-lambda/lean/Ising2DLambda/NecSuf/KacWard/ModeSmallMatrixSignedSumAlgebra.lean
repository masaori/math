import Ising2DLambda.NecSuf.KacWard.ModeSmallMatrixRemainingTerms

namespace Ising2DLambda.NecSuf.KacWard

open Polynomial

/-- The identical coefficient calculation in an arbitrary field: only
commutative field inverses and polynomial distributivity are used. -/
theorem modeSmallMatrix_signed_sum_algebra {R : Type*} [Field R]
    (varpi varsigma : R) (hp : varpi ≠ 0) (hs : varsigma ≠ 0) :
    let d0 : Polynomial R := 1 - X * C varpi
    let d1 : Polynomial R := 1 - X * C varsigma
    let d2 : Polynomial R := 1 - X * C varpi⁻¹
    let d3 : Polynomial R := 1 - X * C varsigma⁻¹
    d0*d1*d2*d3 - X^2 *
      (C varpi⁻¹*C varsigma⁻¹*d0*d1 + C varpi⁻¹*C varsigma*d0*d3 +
       C varpi*C varsigma*d2*d3 + C varpi*C varsigma⁻¹*d1*d2) + 4*X^4 =
      (1+X^2)^2-X*(1-X^2)*(C varpi+C varpi⁻¹+C varsigma+C varsigma⁻¹) := by
  dsimp
  have hpsp : varpi * varsigma * varpi⁻¹ = varsigma := by
    field_simp [hp]
  have hspis : varsigma * varpi⁻¹ * varsigma⁻¹ = varpi⁻¹ := by
    field_simp [hp, hs]
  calc
    _ = 1 - X*(C varpi+C varpi⁻¹+C varsigma+C varsigma⁻¹) +
        2*X^2 + X^3*(C varpi+C varpi⁻¹+C varsigma+C varsigma⁻¹) + X^4 := by
          ring_nf
          simp [← map_mul, hp, hs, hpsp, hspis]
          ring
    _ = (1+X^2)^2-X*(1-X^2)*(C varpi+C varpi⁻¹+C varsigma+C varsigma⁻¹) := by ring

end Ising2DLambda.NecSuf.KacWard
