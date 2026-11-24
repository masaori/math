import Ising2DLambda.NecSuf.KacWard.AlternatingComponentSuccessor
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PermutationOrbitInvariant

namespace Ising2DLambda.NecSuf.KacWard

open Ising2DLambda.NecSuf.AlgebraicEigenvalue

variable {J : Type*}

/-- 後続置換の軌道は、交互の二つの相手写像で閉じる。 -/
theorem alternatingComponent_orbit_mates_necSuf (τ υ : J → J) (C : J → Prop)
    (hτ : Function.Involutive τ) (hυ : Function.Involutive υ)
    (hτcolor : ∀ j, C (τ j) ↔ ¬ C j)
    (hυcolor : ∀ j, C (υ j) ↔ ¬ C j) (i j : J)
    (hj : j ∈ permutationOrbit
      (matchingPairPermutation τ υ C hτ hυ hτcolor hυcolor) i) :
    τ j ∈ permutationOrbit
      (matchingPairPermutation τ υ C hτ hυ hτcolor hυcolor) i ∧
    υ j ∈ permutationOrbit
      (matchingPairPermutation τ υ C hτ hυ hτcolor hυcolor) i := by
  let σ := matchingPairPermutation τ υ C hτ hυ hτcolor hυcolor
  have hpair := alternatingComponent_pair_step_necSuf τ υ C hτ hυ hτcolor hυcolor j
  change (σ j = τ j ∨ σ (τ j) = j) ∧
    (σ j = υ j ∨ σ (υ j) = j) at hpair
  constructor
  · rcases hpair.1 with hforward | hbackward
    · rw [← hforward]
      exact (permutationOrbit_invariant_necSuf σ i j).2 hj
    · exact (permutationOrbit_invariant_necSuf σ i (τ j)).1
        (by simpa only [hbackward] using hj)
  · rcases hpair.2 with hforward | hbackward
    · rw [← hforward]
      exact (permutationOrbit_invariant_necSuf σ i j).2 hj
    · exact (permutationOrbit_invariant_necSuf σ i (υ j)).1
        (by simpa only [hbackward] using hj)

end Ising2DLambda.NecSuf.KacWard
