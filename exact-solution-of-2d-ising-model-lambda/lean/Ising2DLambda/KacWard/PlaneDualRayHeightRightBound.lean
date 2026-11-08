import Ising2DLambda.KacWard.PlaneDualRayHeight
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- A ray starting beyond every selected edge has no crossings. -/
theorem planeDualRayHeight_zero_right (edges : Finset GridEdge) (r c M : ℤ)
    (hmax : ∀ e ∈ edges, e.2.2 ≤ M) (hc : M ≤ c) :
    planeDualRayHeight edges r c = 0 := by
  simp only [planeDualRayHeight]
  apply Finset.sum_eq_zero
  intro e he
  have hnot : ¬ c < e.2.2 := by have := hmax e he; omega
  simp [hnot]

end Ising2DLambda.KacWard
