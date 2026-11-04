import Mathlib.Tactic.Ring

namespace Ising2DLambda.NecSuf.KacWard

/-- An additive edge evaluation cancels on four cyclic sides when opposite sides agree. -/
theorem fourSideBoundaryEvaluation_zero {E : Type*} (weight : E → ℤ)
    (top right bottom left : E)
    (hHorizontal : weight top = weight bottom)
    (hVertical : weight right = weight left) :
    weight top + weight right - weight bottom - weight left = 0 := by
  rw [hHorizontal, hVertical]
  ring

end Ising2DLambda.NecSuf.KacWard
