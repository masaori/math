import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PerfectMatching

namespace Ising2DLambda.NecSuf.KacWard

open Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- In a matching made of the two-point orbits of an involution, the mate is the involution. -/
theorem referenceLongMate_eq_involution {J : Type*} (τ : J → J)
    (hne : ∀ j, τ j ≠ j)
    (hmatching : IsPerfectMatching {p : Set J | ∃ j : J, p = {j, τ j}})
    (j : J) :
    perfectMatchingMate ⟨{p : Set J | ∃ k : J, p = {k, τ k}}, hmatching⟩ j = τ j := by
  apply perfectMatchingMate_eq_of_pair
  · exact hne j
  · exact ⟨j, rfl⟩

end Ising2DLambda.NecSuf.KacWard
