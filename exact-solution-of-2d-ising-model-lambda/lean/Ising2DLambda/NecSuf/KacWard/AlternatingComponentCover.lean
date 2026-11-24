import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairComponent

namespace Ising2DLambda.NecSuf.KacWard

open Ising2DLambda.NecSuf.AlgebraicEigenvalue

variable {J : Type*}

/-- 二つの対合から作る交互成分は全点を覆い、二成分は一致するか交わらない。 -/
theorem alternatingComponent_cover_necSuf (τ υ : J → J)
    (hτ : Function.Involutive τ) (hυ : Function.Involutive υ) :
    (∀ i : J, i ∈ matchingPairComponent τ υ hτ hυ i) ∧
    (∀ i j : J, matchingPairComponent τ υ hτ hυ i =
        matchingPairComponent τ υ hτ hυ j ∨
      Disjoint (matchingPairComponent τ υ hτ hυ i)
        (matchingPairComponent τ υ hτ hυ j)) ∧
    (∀ i : J, τ i ∈ matchingPairComponent τ υ hτ hυ i ∧
      υ i ∈ matchingPairComponent τ υ hτ hυ i) := by
  let p := involutionPairStep τ υ hτ hυ
  constructor
  · intro i
    exact Or.inl (permutationOrbit_self_mem_necSuf p i)
  constructor
  · intro i j
    by_cases h : matchingPairComponent τ υ hτ hυ i ∩
        matchingPairComponent τ υ hτ hυ j = ∅
    · exact Or.inr (Set.disjoint_iff_inter_eq_empty.mpr h)
    · left
      have hw : (matchingPairComponent τ υ hτ hυ i ∩
          matchingPairComponent τ υ hτ hυ j).Nonempty :=
        Set.nonempty_iff_ne_empty.mpr h
      obtain ⟨k, hki, hkj⟩ := hw
      calc
        matchingPairComponent τ υ hτ hυ i =
            matchingPairComponent τ υ hτ hυ k :=
          (matchingPairComponent_basepoint τ υ hτ hυ i k hki).symm
        _ = matchingPairComponent τ υ hτ hυ j :=
          matchingPairComponent_basepoint τ υ hτ hυ j k hkj
  · intro i
    constructor
    · exact Or.inr (permutationOrbit_self_mem_necSuf p (τ i))
    · have hmate : τ i ∈ permutationOrbit p (τ i) :=
        permutationOrbit_self_mem_necSuf p (τ i)
      have hp : p (τ i) ∈ permutationOrbit p (τ i) :=
        (permutationOrbit_invariant_necSuf p (τ i) (τ i)).mpr hmate
      change υ (τ (τ i)) ∈ permutationOrbit p (τ i) at hp
      rw [hτ i] at hp
      exact Or.inr hp

end Ising2DLambda.NecSuf.KacWard
