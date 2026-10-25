import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- A matching is determined by its mate map.  If the two mate maps agree on
    each branch of a partition, the matchings agree. -/
theorem matching_eq_of_branch_mates {J M : Type*} (mate : M → J → J)
    (mate_injective : Function.Injective mate)
    (selected : J → Prop) (constructed original : M)
    (selected_eq : ∀ j, selected j → mate constructed j = mate original j)
    (outside_eq : ∀ j, ¬ selected j → mate constructed j = mate original j) :
    constructed = original := by
  apply mate_injective
  funext j
  by_cases hj : selected j
  · exact selected_eq j hj
  · exact outside_eq j hj

end Ising2DLambda.NecSuf.KacWard
