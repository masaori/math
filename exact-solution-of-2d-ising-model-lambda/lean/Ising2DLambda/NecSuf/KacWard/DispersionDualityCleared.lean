import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- The denominator-cleared dispersion identity only uses commutative ring operations. -/
theorem dispersion_duality_cleared {R : Type*} [CommRing R] (x t : R) :
    ((1 + x) ^ 2 + (1 - x) ^ 2) ^ 2 -
      (1 - x) * ((1 + x) ^ 2 - (1 - x) ^ 2) * (1 + x) * t =
      4 * ((1 + x ^ 2) ^ 2 - x * (1 - x ^ 2) * t) := by
  ring

end Ising2DLambda.NecSuf.KacWard
