import Ising2DLambda.NecSuf.KacWard.SelectedSupportCoefficientReconstruction

namespace Ising2DLambda.NecSuf.KacWard

/--
Two coefficient families supported at the same selected candidate are combined
by adding their orbit sums.  Only finite sums in an additive commutative monoid
are used.
-/
theorem two_support_coefficient_formula_necSuf
    {C A : Type} [Fintype C] [DecidableEq C] [AddCommMonoid A]
    (first second : C → A) (selected candidate : C)
    (hfirst : ∀ other, other ≠ selected → first other = 0)
    (hsecond : ∀ other, other ≠ selected → second other = 0) :
    first candidate + second candidate =
      if candidate = selected then
        (∑ other, first other) + ∑ other, second other
      else 0 := by
  rw [coefficient_eq_selected_sum first selected candidate hfirst,
    coefficient_eq_selected_sum second selected candidate hsecond]
  by_cases hcandidate : candidate = selected
  · simp [hcandidate]
  · simp [hcandidate]

end Ising2DLambda.NecSuf.KacWard
