import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairComponent
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairPermutation

namespace Ising2DLambda.NecSuf.KacWard

open Ising2DLambda.NecSuf.AlgebraicEigenvalue

variable {J : Type*}

/-- 二つの相手写像の成分は全点を被覆し、二成分は一致するか交わらない。 -/
theorem alternatingCycle_cover (τ υ : J → J)
    (hτ : Function.Involutive τ) (hυ : Function.Involutive υ) :
    (∀ i : J, i ∈ matchingPairComponent τ υ hτ hυ i) ∧
    (∀ i j : J, matchingPairComponent τ υ hτ hυ i = matchingPairComponent τ υ hτ hυ j ∨
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
        matchingPairComponent τ υ hτ hυ i = matchingPairComponent τ υ hτ hυ k :=
          (matchingPairComponent_basepoint τ υ hτ hυ i k hki).symm
        _ = matchingPairComponent τ υ hτ hυ j :=
          matchingPairComponent_basepoint τ υ hτ hυ j k hkj
  · intro i
    constructor
    · exact Or.inr (permutationOrbit_self_mem_necSuf p (τ i))
    · have hself : τ i ∈ permutationOrbit p (τ i) :=
        permutationOrbit_self_mem_necSuf p (τ i)
      have hstep : p (τ i) ∈ permutationOrbit p (τ i) :=
        (permutationOrbit_invariant_necSuf p (τ i) (τ i)).mpr hself
      change υ (τ (τ i)) ∈ permutationOrbit p (τ i) at hstep
      rw [hτ i] at hstep
      exact Or.inr hstep

/-- どちらの相手の対も、後続写像の一方向の一歩になる。 -/
theorem alternatingCycle_pair_step (τ υ : J → J) (C : J → Prop)
    (hτ : Function.Involutive τ) (hυ : Function.Involutive υ)
    (hτcolor : ∀ j, C (τ j) ↔ ¬ C j)
    (hυcolor : ∀ j, C (υ j) ↔ ¬ C j) (i : J) :
    (matchingPairSuccessor τ υ C i = τ i ∨
      matchingPairSuccessor τ υ C (τ i) = i) ∧
    (matchingPairSuccessor τ υ C i = υ i ∨
      matchingPairSuccessor τ υ C (υ i) = i) :=
  matchingPairSuccessor_mate_step_necSuf τ υ C hτ hυ hτcolor hυcolor i

end Ising2DLambda.NecSuf.KacWard
