import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/--
If every coefficient away from one selected candidate is zero, then the
coefficient function is recovered from its finite sum and the selected
candidate.  Only a finite candidate type and an additive commutative monoid
with zero are used.
-/
theorem coefficient_eq_selected_sum
    {C A : Type} [Fintype C] [DecidableEq C] [AddCommMonoid A]
    (coefficient : C → A) (selected candidate : C)
    (hzero : ∀ other, other ≠ selected → coefficient other = 0) :
    coefficient candidate =
      if candidate = selected then ∑ other, coefficient other else 0 := by
  by_cases hcandidate : candidate = selected
  · subst candidate
    rw [if_pos rfl]
    symm
    exact Fintype.sum_eq_single selected (fun other hne ↦ hzero other hne)
  · rw [if_neg hcandidate]
    exact hzero candidate hcandidate

end Ising2DLambda.NecSuf.KacWard
