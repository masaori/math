import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairPermutation
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairComponent
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PermutationOrbitBasepoint

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue
variable {J : Type*}
open Classical

private theorem orbit_subset_of_closed (π : Equiv.Perm J) (S : Set J) (i : J)
    (hi : i ∈ S) (hf : ∀ j ∈ S, π j ∈ S)
    (hb : ∀ j ∈ S, π.symm j ∈ S) : permutationOrbit π i ⊆ S := by
  intro j hj
  obtain ⟨n, hn | hn⟩ := hj
  · subst j
    induction n with
    | zero => exact hi
    | succ n ih =>
      rw [Function.iterate_succ_apply']
      exact hf _ ih
  · subst j
    induction n with
    | zero => exact hi
    | succ n ih =>
      rw [Function.iterate_succ_apply']
      exact hb _ ih

/-- 二歩の同定には、二つの相手写像の色反転だけを要する。 -/
theorem matchingPairSuccessor_two_steps (τ υ : J → J) (C : J → Prop)
    (hτ : Function.Involutive τ) (hυ : Function.Involutive υ)
    (hτcolor : ∀ j, C (τ j) ↔ ¬ C j) (hυcolor : ∀ j, C (υ j) ↔ ¬ C j) (j : J) :
    matchingPairPermutation τ υ C hτ hυ hτcolor hυcolor
      (matchingPairPermutation τ υ C hτ hυ hτcolor hυcolor j) =
      if C j then involutionPairStep τ υ hτ hυ j
      else (involutionPairStep τ υ hτ hυ).symm j := by
  by_cases hj : C j
  · have htau : ¬ C (τ j) := fun h => (hτcolor j).mp h hj
    simp [hj, htau, matchingPairPermutation, matchingPairSuccessor,
      involutionPairStep]
  · have hupsilon : C (υ j) := (hυcolor j).mpr hj
    simp [hj, hupsilon, matchingPairPermutation, matchingPairSuccessor,
      involutionPairStep]

theorem matchingPairPredecessor_two_steps (τ υ : J → J) (C : J → Prop)
    (hτ : Function.Involutive τ) (hυ : Function.Involutive υ)
    (hτcolor : ∀ j, C (τ j) ↔ ¬ C j) (hυcolor : ∀ j, C (υ j) ↔ ¬ C j) (j : J) :
    (matchingPairPermutation τ υ C hτ hυ hτcolor hυcolor).symm
      ((matchingPairPermutation τ υ C hτ hυ hτcolor hυcolor).symm j) =
      if C j then (involutionPairStep τ υ hτ hυ).symm j
      else involutionPairStep τ υ hτ hυ j := by
  by_cases hj : C j
  · have hupsilon : ¬ C (υ j) := fun h => (hυcolor j).mp h hj
    simp [hj, hupsilon, matchingPairPermutation, matchingPairPredecessor,
      involutionPairStep]
  · have htau : C (τ j) := (hτcolor j).mpr hj
    simp [hj, htau, matchingPairPermutation, matchingPairPredecessor,
      involutionPairStep]

/-- 有限性、線型順序、最小元、不動点の不在は不要。 -/
theorem matchingPairPermutation_orbit_eq_component (τ υ : J → J) (C : J → Prop)
    (hτ : Function.Involutive τ) (hυ : Function.Involutive υ)
    (hτcolor : ∀ j, C (τ j) ↔ ¬ C j) (hυcolor : ∀ j, C (υ j) ↔ ¬ C j) (i : J) :
    permutationOrbit (matchingPairPermutation τ υ C hτ hυ hτcolor hυcolor) i =
      matchingPairComponent τ υ hτ hυ i := by
  let σ := matchingPairPermutation τ υ C hτ hυ hτcolor hυcolor
  let p := involutionPairStep τ υ hτ hυ
  let B := matchingPairComponent τ υ hτ hυ i
  let S := permutationOrbit σ i
  have hBself : i ∈ B := Or.inl (permutationOrbit_self_mem_necSuf p i)
  have hBτ (j : J) (hj : j ∈ B) : τ j ∈ B := by
    have hbase := matchingPairComponent_basepoint τ υ hτ hυ i j hj
    have hmate : τ j ∈ matchingPairComponent τ υ hτ hυ j :=
      Or.inr (permutationOrbit_self_mem_necSuf p (τ j))
    rw [hbase] at hmate
    exact hmate
  have hBp (j : J) (hj : j ∈ B) : p j ∈ B := by
    rcases hj with h | h
    · exact Or.inl ((permutationOrbit_invariant_necSuf p i j).mpr h)
    · exact Or.inr ((permutationOrbit_invariant_necSuf p (τ i) j).mpr h)
  have hBυ (j : J) (hj : j ∈ B) : υ j ∈ B := by
    have hp := hBp (τ j) (hBτ j hj)
    change υ (τ (τ j)) ∈ B at hp
    rw [hτ j] at hp
    exact hp
  have hBσ (j : J) (hj : j ∈ B) : σ j ∈ B := by
    by_cases hC : C j
    · simpa [σ, matchingPairPermutation, matchingPairSuccessor, hC] using hBτ j hj
    · simpa [σ, matchingPairPermutation, matchingPairSuccessor, hC] using hBυ j hj
  have hBσinv (j : J) (hj : j ∈ B) : σ.symm j ∈ B := by
    by_cases hC : C j
    · simpa [σ, matchingPairPermutation, matchingPairPredecessor, hC] using hBυ j hj
    · simpa [σ, matchingPairPermutation, matchingPairPredecessor, hC] using hBτ j hj
  have hleft : S ⊆ B := orbit_subset_of_closed σ B i hBself hBσ hBσinv
  have hSself : i ∈ S := permutationOrbit_self_mem_necSuf σ i
  have hSσ (j : J) (hj : j ∈ S) : σ j ∈ S :=
    (permutationOrbit_invariant_necSuf σ i j).mpr hj
  have hSσinv (j : J) (hj : j ∈ S) : σ.symm j ∈ S := by
    have h : j ∈ permutationOrbit σ.symm i := by
      rw [permutationOrbit_inverse]
      exact hj
    have h' := (permutationOrbit_invariant_necSuf σ.symm i j).mpr h
    rw [permutationOrbit_inverse] at h'
    exact h'
  have hSp (j : J) (hj : j ∈ S) : p j ∈ S := by
    by_cases hC : C j
    · have htwo := matchingPairSuccessor_two_steps τ υ C hτ hυ hτcolor hυcolor j
      rw [if_pos hC] at htwo
      rw [← htwo]
      exact hSσ _ (hSσ _ hj)
    · have htwo := matchingPairPredecessor_two_steps τ υ C hτ hυ hτcolor hυcolor j
      rw [if_neg hC] at htwo
      rw [← htwo]
      exact hSσinv _ (hSσinv _ hj)
  have hSpinv (j : J) (hj : j ∈ S) : p.symm j ∈ S := by
    by_cases hC : C j
    · have htwo := matchingPairPredecessor_two_steps τ υ C hτ hυ hτcolor hυcolor j
      rw [if_pos hC] at htwo
      rw [← htwo]
      exact hSσinv _ (hSσinv _ hj)
    · have htwo := matchingPairSuccessor_two_steps τ υ C hτ hυ hτcolor hυcolor j
      rw [if_neg hC] at htwo
      rw [← htwo]
      exact hSσ _ (hSσ _ hj)
  have hSτ : τ i ∈ S := by
    by_cases hC : C i
    · have h : σ i = τ i := by simp [σ, matchingPairPermutation, matchingPairSuccessor, hC]
      rw [← h]
      exact hSσ i hSself
    · have h : σ.symm i = τ i := by
        simp [σ, matchingPairPermutation, matchingPairPredecessor, hC]
      rw [← h]
      exact hSσinv i hSself
  have hright : B ⊆ S := by
    intro j hj
    rcases hj with h | h
    · exact orbit_subset_of_closed p S i hSself hSp hSpinv h
    · exact orbit_subset_of_closed p S (τ i) hSτ hSp hSpinv h
  exact Set.Subset.antisymm hleft hright

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
