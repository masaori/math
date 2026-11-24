import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairPermutation

namespace Ising2DLambda.NecSuf.KacWard

open Ising2DLambda.NecSuf.AlgebraicEigenvalue

variable {J : Type*}

/-- Each involution pair is traversed by the successor permutation in one of its two orientations. -/
theorem alternatingComponent_pair_step_necSuf (τ υ : J → J) (C : J → Prop)
    (hτ : Function.Involutive τ) (hυ : Function.Involutive υ)
    (hτcolor : ∀ j, C (τ j) ↔ ¬ C j)
    (hυcolor : ∀ j, C (υ j) ↔ ¬ C j) (i : J) :
    let σ := matchingPairPermutation τ υ C hτ hυ hτcolor hυcolor
    (σ i = τ i ∨ σ (τ i) = i) ∧
    (σ i = υ i ∨ σ (υ i) = i) := by
  classical
  dsimp
  constructor
  · by_cases hi : C i
    · left
      simp [matchingPairPermutation, matchingPairSuccessor, hi]
    · right
      have hm : C (τ i) := (hτcolor i).mpr hi
      simp [matchingPairPermutation, matchingPairSuccessor, hm, hτ i]
  · by_cases hi : C i
    · right
      have hm : ¬ C (υ i) := by
        intro h
        exact ((hυcolor i).mp h) hi
      simp [matchingPairPermutation, matchingPairSuccessor, hm, hυ i]
    · left
      simp [matchingPairPermutation, matchingPairSuccessor, hi]

end Ising2DLambda.NecSuf.KacWard
