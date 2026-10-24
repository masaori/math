import Ising2DLambda.AlgebraicEigenvalue.MatchingPairReconstructedOrbit
import Ising2DLambda.AlgebraicEigenvalue.EvenOrbitColoring
import Ising2DLambda.AlgebraicEigenvalue.AlternatingNeighborMatchings

namespace Ising2DLambda.AlgebraicEigenvalue
variable {J : Type*} [Fintype J] [LinearOrder J]
open Classical

noncomputable def recoveredFirstInvolution (σ : Equiv.Perm J)
    (heven : ∀ i, Even (finitePermutationOrbitLength σ i)) : FixedPointFreeInvolution J :=
  ⟨alternatingNeighbor σ (finitePermutationEvenColor σ),
    alternatingNeighbor_involution σ (finitePermutationEvenColor σ)
      (finitePermutationEvenColor_alternates σ heven)⟩

noncomputable def recoveredSecondInvolution (σ : Equiv.Perm J)
    (heven : ∀ i, Even (finitePermutationOrbitLength σ i)) : FixedPointFreeInvolution J :=
  ⟨alternatingNeighbor σ.symm (finitePermutationEvenColor σ),
    alternatingNeighbor_involution σ.symm (finitePermutationEvenColor σ)
      (alternatingNeighbor_inverse_color σ (finitePermutationEvenColor σ)
        (finitePermutationEvenColor_alternates σ heven))⟩

omit [LinearOrder J] in
private theorem orbit_subset_of_closed (π : Equiv.Perm J) (S : Set J) (i : J)
    (hi : i ∈ S) (hf : ∀ j ∈ S, π j ∈ S)
    (hb : ∀ j ∈ S, π.symm j ∈ S) : finitePermutationOrbit π i ⊆ S := by
  intro j hj
  obtain ⟨n, hn | hn⟩ := hj
  · subst j
    induction n with
    | zero => exact hi
    | succ n ih =>
      rw [finiteMapIterate, Function.iterate_succ_apply']
      exact hf _ ih
  · subst j
    induction n with
    | zero => exact hi
    | succ n ih =>
      rw [finiteMapIterate, Function.iterate_succ_apply']
      exact hb _ ih

theorem recoveredMatchingPair_component_eq_orbit (σ : Equiv.Perm J)
    (heven : ∀ i, Even (finitePermutationOrbitLength σ i)) (i : J) :
    matchingPairComponent (recoveredFirstInvolution σ heven)
      (recoveredSecondInvolution σ heven) i = finitePermutationOrbit σ i := by
  let τ := recoveredFirstInvolution σ heven
  let υ := recoveredSecondInvolution σ heven
  let C : Set J := finitePermutationEvenColor σ
  let B := matchingPairComponent τ υ i
  let S := finitePermutationOrbit σ i
  let p := matchingPairStep τ υ
  have hτ (j : J) : τ.val j = if j ∈ C then σ j else σ.symm j := by
    simp [τ, C, recoveredFirstInvolution, alternatingNeighbor]
  have hυ (j : J) : υ.val j = if j ∈ C then σ.symm j else σ j := by
    simp [υ, C, recoveredSecondInvolution, alternatingNeighbor]
  have hSself : i ∈ S := finitePermutationOrbit_self_mem σ i
  have hSσ (j : J) (hj : j ∈ S) : σ j ∈ S :=
    (finitePermutationOrbit_invariant σ i j).mpr hj
  have hSσinv (j : J) (hj : j ∈ S) : σ.symm j ∈ S := by
    have h : j ∈ finitePermutationOrbit σ.symm i := by
      rw [finitePermutationOrbit_inverse]
      exact hj
    have h' := (finitePermutationOrbit_invariant σ.symm i j).mpr h
    rw [finitePermutationOrbit_inverse] at h'
    exact h'
  have hSτ (j : J) (hj : j ∈ S) : τ.val j ∈ S := by
    rw [hτ]
    split_ifs <;> [exact hSσ j hj; exact hSσinv j hj]
  have hSυ (j : J) (hj : j ∈ S) : υ.val j ∈ S := by
    rw [hυ]
    split_ifs <;> [exact hSσinv j hj; exact hSσ j hj]
  have hSp (j : J) (hj : j ∈ S) : p j ∈ S :=
    hSυ _ (hSτ j hj)
  have hSpinv (j : J) (hj : j ∈ S) : p.symm j ∈ S := by
    change τ.val (υ.val j) ∈ S
    exact hSτ _ (hSυ j hj)
  have hBsubsetS : B ⊆ S := by
    intro j hj
    rcases hj with h | h
    · exact orbit_subset_of_closed p S i hSself hSp hSpinv h
    · exact orbit_subset_of_closed p S (τ.val i) (hSτ i hSself) hSp hSpinv h
  have hBself : i ∈ B := Or.inl (finitePermutationOrbit_self_mem p i)
  have hBτ (j : J) (hj : j ∈ B) : τ.val j ∈ B := by
    have hbase := matchingPairComponent_basepoint τ υ i j hj
    have hmate : τ.val j ∈ matchingPairComponent τ υ j :=
      Or.inr (finitePermutationOrbit_self_mem p (τ.val j))
    rw [hbase] at hmate
    exact hmate
  have hBp (j : J) (hj : j ∈ B) : p j ∈ B := by
    rcases hj with h | h
    · exact Or.inl ((finitePermutationOrbit_invariant p i j).mpr h)
    · exact Or.inr ((finitePermutationOrbit_invariant p (τ.val i) j).mpr h)
  have hBυ (j : J) (hj : j ∈ B) : υ.val j ∈ B := by
    have hp := hBp (τ.val j) (hBτ j hj)
    change υ.val (τ.val (τ.val j)) ∈ B at hp
    rw [τ.property.2 j] at hp
    exact hp
  have hBσ (j : J) (hj : j ∈ B) : σ j ∈ B := by
    by_cases hc : j ∈ C
    · have ht := hBτ j hj
      rw [hτ, if_pos hc] at ht
      exact ht
    · have hu := hBυ j hj
      rw [hυ, if_neg hc] at hu
      exact hu
  have hBσinv (j : J) (hj : j ∈ B) : σ.symm j ∈ B := by
    by_cases hc : j ∈ C
    · have hu := hBυ j hj
      rw [hυ, if_pos hc] at hu
      exact hu
    · have ht := hBτ j hj
      rw [hτ, if_neg hc] at ht
      exact ht
  have hSsubsetB : S ⊆ B := orbit_subset_of_closed σ B i hBself hBσ hBσinv
  exact Set.Subset.antisymm hBsubsetS hSsubsetB

end Ising2DLambda.AlgebraicEigenvalue
