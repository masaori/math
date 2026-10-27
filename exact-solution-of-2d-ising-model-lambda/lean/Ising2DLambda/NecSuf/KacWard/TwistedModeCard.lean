import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- A nonzero scalar transports the cardinality of a finite mode set. -/
theorem scalarModeImage_ncard_necSuf {R : Type*} [Field R]
    (S : Set R) (ξ : R) (hξ : ξ ≠ 0) (n : ℕ) (hcard : S.ncard = n) :
    ((fun y : R => ξ * y) '' S).ncard = n := by
  calc
    ((fun y : R => ξ * y) '' S).ncard = S.ncard :=
      Set.ncard_image_of_injective S (fun _ _ h => mul_left_cancel₀ hξ h)
    _ = n := hcard

end Ising2DLambda.NecSuf.KacWard
