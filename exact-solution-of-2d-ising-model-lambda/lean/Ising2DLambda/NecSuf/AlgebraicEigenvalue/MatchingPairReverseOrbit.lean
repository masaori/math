import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairComponent
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PermutationOrbitInvariant

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue
variable {J : Type*}

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

/-- 有限性・順序・不動点の不在は、軌道の両包含に要らない。 -/
theorem recoveredMatchingPair_component_eq_orbit
    (σ : Equiv.Perm J) (C : Set J) (τ υ : J → J)
    (hτ : Function.Involutive τ) (hυ : Function.Involutive υ)
    (hτfirst : ∀ j, j ∈ C → τ j = σ j)
    (hτsecond : ∀ j, j ∉ C → τ j = σ.symm j)
    (hυfirst : ∀ j, j ∈ C → υ j = σ.symm j)
    (hυsecond : ∀ j, j ∉ C → υ j = σ j)
    (i : J) :
    matchingPairComponent τ υ hτ hυ i = permutationOrbit σ i := by
  classical
  let B := matchingPairComponent τ υ hτ hυ i
  let S := permutationOrbit σ i
  let p := involutionPairStep τ υ hτ hυ
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
  have hSτ (j : J) (hj : j ∈ S) : τ j ∈ S := by
    by_cases hc : j ∈ C
    · rw [hτfirst j hc]; exact hSσ j hj
    · rw [hτsecond j hc]; exact hSσinv j hj
  have hSυ (j : J) (hj : j ∈ S) : υ j ∈ S := by
    by_cases hc : j ∈ C
    · rw [hυfirst j hc]; exact hSσinv j hj
    · rw [hυsecond j hc]; exact hSσ j hj
  have hSp (j : J) (hj : j ∈ S) : p j ∈ S := hSυ _ (hSτ j hj)
  have hSpinv (j : J) (hj : j ∈ S) : p.symm j ∈ S := by
    change τ (υ j) ∈ S
    exact hSτ _ (hSυ j hj)
  have hBsubsetS : B ⊆ S := by
    intro j hj
    rcases hj with h | h
    · exact orbit_subset_of_closed p S i hSself hSp hSpinv h
    · exact orbit_subset_of_closed p S (τ i) (hSτ i hSself) hSp hSpinv h
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
    by_cases hc : j ∈ C
    · have ht := hBτ j hj
      rw [hτfirst j hc] at ht
      exact ht
    · have hu := hBυ j hj
      rw [hυsecond j hc] at hu
      exact hu
  have hBσinv (j : J) (hj : j ∈ B) : σ.symm j ∈ B := by
    by_cases hc : j ∈ C
    · have hu := hBυ j hj
      rw [hυfirst j hc] at hu
      exact hu
    · have ht := hBτ j hj
      rw [hτsecond j hc] at ht
      exact ht
  have hSsubsetB : S ⊆ B := orbit_subset_of_closed σ B i hBself hBσ hBσinv
  exact Set.Subset.antisymm hBsubsetS hSsubsetB

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
