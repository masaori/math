import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- A finite ray sum vanishes beyond the last possible crossing. -/
theorem finiteRay_zero_right {α : Type*} [DecidableEq α]
    (edges : Finset α) (column : α → ℤ) (weight : α → ZMod 2)
    (c M : ℤ) (hmax : ∀ e ∈ edges, column e ≤ M) (hc : M ≤ c) :
    (∑ e ∈ edges, if c < column e then weight e else 0) = 0 := by
  apply Finset.sum_eq_zero
  intro e he
  have hnot : ¬ c < column e := by have := hmax e he; omega
  simp [hnot]

end Ising2DLambda.NecSuf.KacWard
