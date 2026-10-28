import Ising2DLambda.NecSuf.KacWard.DispersionPolynomial

namespace Ising2DLambda.NecSuf.KacWard

open Polynomial

/-- Only characteristic zero and the ring operations are needed for the four factors. -/
theorem dispersion_special_mode_squares {R : Type*} [Field R] [CharZero R] :
    dispersionPolynomial (1 : R) 1 = (1 - 2 * X - X ^ 2) ^ 2 ∧
    dispersionPolynomial (1 : R) (-1) = (1 + X ^ 2) ^ 2 ∧
    dispersionPolynomial (-1 : R) 1 = (1 + X ^ 2) ^ 2 ∧
    dispersionPolynomial (-1 : R) (-1) = (1 + 2 * X - X ^ 2) ^ 2 := by
  constructor
  · simp [dispersionPolynomial]
    ring
  constructor
  · simp [dispersionPolynomial]
  constructor
  · simp [dispersionPolynomial]
  · simp [dispersionPolynomial]
    ring

end Ising2DLambda.NecSuf.KacWard
