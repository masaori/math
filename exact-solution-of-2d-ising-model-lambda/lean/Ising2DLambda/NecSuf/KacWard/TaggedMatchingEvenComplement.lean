import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

open Finset

/-- A finite partition into pairs has even total weight when every pair has even weight. -/
theorem even_of_pair_contributions {J : Type*} [Fintype J]
    {P : Type*} (pairs : Finset P) (first second : P → J) (weight : J → ℕ)
    (hpartition : (∑ j : J, weight j) =
      ∑ p ∈ pairs, (weight (first p) + weight (second p)))
    (hpair : ∀ p ∈ pairs, Even (weight (first p) + weight (second p))) :
    Even (∑ j : J, weight j) := by
  rw [hpartition]
  exact Finset.even_sum _ hpair

end Ising2DLambda.NecSuf.KacWard
