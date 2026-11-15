import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- The denominator-cleared dispersion identity only uses commutative ring operations. -/
theorem dispersion_duality_cleared {R : Type*} [CommRing R] (x t : R) :
    ((1 + x) ^ 2 + (1 - x) ^ 2) ^ 2 -
      (1 - x) * ((1 + x) ^ 2 - (1 - x) ^ 2) * (1 + x) * t =
      4 * ((1 + x ^ 2) ^ 2 - x * (1 - x ^ 2) * t) := by
  ring

/-- Evaluating the cleared identity uses only field division and a nonzero denominator. -/
theorem dispersion_duality_factor {K : Type*} [Field K]
    (x t : K) (hx : 1 + x ≠ 0) :
    (1 + x) ^ 4 *
      ((1 + ((1 - x) / (1 + x)) ^ 2) ^ 2 -
        ((1 - x) / (1 + x)) *
          (1 - ((1 - x) / (1 + x)) ^ 2) * t) =
      4 * ((1 + x ^ 2) ^ 2 - x * (1 - x ^ 2) * t) := by
  field_simp
  ring

end Ising2DLambda.NecSuf.KacWard
