import Mathlib.Tactic.Ring
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace Ising2DLambda.NecSuf.KacWard

/-- An additive edge evaluation cancels on four cyclic sides when opposite sides agree. -/
theorem fourSideBoundaryEvaluation_zero {E : Type*} (weight : E → ℤ)
    (top right bottom left : E)
    (hHorizontal : weight top = weight bottom)
    (hVertical : weight right = weight left) :
    weight top + weight right - weight bottom - weight left = 0 := by
  rw [hHorizontal, hVertical]
  ring

/-- A finite sum of individually vanishing cell-boundary evaluations vanishes. -/
theorem finiteBoundaryEvaluation_zero {C : Type*} (S : Finset C)
    (cellEvaluation : C → ℤ) (h : ∀ c ∈ S, cellEvaluation c = 0) :
    ∑ c ∈ S, cellEvaluation c = 0 := by
  simp [Finset.sum_eq_zero h]

end Ising2DLambda.NecSuf.KacWard
