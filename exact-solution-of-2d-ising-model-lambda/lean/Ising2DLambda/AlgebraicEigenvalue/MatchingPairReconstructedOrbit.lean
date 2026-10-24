import Ising2DLambda.AlgebraicEigenvalue.MatchingPairPermutation
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairComponent
import Ising2DLambda.AlgebraicEigenvalue.FinitePermutationOrbitBasepoint

namespace Ising2DLambda.AlgebraicEigenvalue
variable {J : Type*} [Fintype J] [LinearOrder J]
open Classical

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

/-- 二歩の置換は、第一色では `p`、第二色では `p⁻¹` と一致する。 -/
theorem matchingPairSuccessor_two_steps (τ υ : FixedPointFreeInvolution J) (j : J) :
    (matchingPairPermutation τ υ) ((matchingPairPermutation τ υ) j) =
      if j ∈ matchingPairColor τ υ then matchingPairStep τ υ j
      else (matchingPairStep τ υ).symm j := by
  classical
  by_cases hj : j ∈ matchingPairColor τ υ
  · have htau : τ.val j ∉ matchingPairColor τ υ :=
      fun h => (matchingPairColor_alternates τ υ j).mp h hj
    simp [hj, htau, matchingPairPermutation, matchingPairSuccessor,
      matchingPairStep]
  · have hupsilon : υ.val j ∈ matchingPairColor τ υ :=
      (matchingPairSecondColor_alternates τ υ j).mpr hj
    simp [hj, hupsilon, matchingPairPermutation, matchingPairSuccessor,
      matchingPairStep]

/-- 逆二歩は、第一色では `p⁻¹`、第二色では `p` と一致する。 -/
theorem matchingPairPredecessor_two_steps (τ υ : FixedPointFreeInvolution J) (j : J) :
    (matchingPairPermutation τ υ).symm ((matchingPairPermutation τ υ).symm j) =
      if j ∈ matchingPairColor τ υ then (matchingPairStep τ υ).symm j
      else matchingPairStep τ υ j := by
  classical
  by_cases hj : j ∈ matchingPairColor τ υ
  · have hupsilon : υ.val j ∉ matchingPairColor τ υ :=
      fun h => (matchingPairSecondColor_alternates τ υ j).mp h hj
    simp [hj, hupsilon, matchingPairPermutation, matchingPairPredecessor,
      matchingPairStep]
  · have htau : τ.val j ∈ matchingPairColor τ υ :=
      (matchingPairColor_alternates τ υ j).mpr hj
    simp [hj, htau, matchingPairPermutation, matchingPairPredecessor,
      matchingPairStep]

/-- 二歩軌道の合併と、二色を交互にたどる置換の軌道の両包含。 -/
theorem matchingPairPermutation_orbit_eq_component (τ υ : FixedPointFreeInvolution J) (i : J) :
    finitePermutationOrbit (matchingPairPermutation τ υ) i = matchingPairComponent τ υ i := by
  classical
  let σ := matchingPairPermutation τ υ
  let p := matchingPairStep τ υ
  let B := matchingPairComponent τ υ i
  let S := finitePermutationOrbit σ i
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
    have hτ := hBτ j hj
    have hp := hBp (τ.val j) hτ
    change υ.val (τ.val (τ.val j)) ∈ B at hp
    rw [τ.property.2 j] at hp
    exact hp
  have hBσ (j : J) (hj : j ∈ B) : σ j ∈ B := by
    by_cases hC : j ∈ matchingPairColor τ υ
    · simpa [σ, matchingPairPermutation, matchingPairSuccessor, hC] using hBτ j hj
    · simpa [σ, matchingPairPermutation, matchingPairSuccessor, hC] using hBυ j hj
  have hBσinv (j : J) (hj : j ∈ B) : σ.symm j ∈ B := by
    by_cases hC : j ∈ matchingPairColor τ υ
    · simpa [σ, matchingPairPermutation, matchingPairPredecessor, hC] using hBυ j hj
    · simpa [σ, matchingPairPermutation, matchingPairPredecessor, hC] using hBτ j hj
  have hleft : S ⊆ B := orbit_subset_of_closed σ B i hBself hBσ hBσinv
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
  have hSp (j : J) (hj : j ∈ S) : p j ∈ S := by
    by_cases hC : j ∈ matchingPairColor τ υ
    · have htwo := matchingPairSuccessor_two_steps τ υ j
      rw [if_pos hC] at htwo
      rw [← htwo]
      exact hSσ _ (hSσ _ hj)
    · have htwo := matchingPairPredecessor_two_steps τ υ j
      rw [if_neg hC] at htwo
      rw [← htwo]
      exact hSσinv _ (hSσinv _ hj)
  have hSpinv (j : J) (hj : j ∈ S) : p.symm j ∈ S := by
    by_cases hC : j ∈ matchingPairColor τ υ
    · have htwo := matchingPairPredecessor_two_steps τ υ j
      rw [if_pos hC] at htwo
      rw [← htwo]
      exact hSσinv _ (hSσinv _ hj)
    · have htwo := matchingPairSuccessor_two_steps τ υ j
      rw [if_neg hC] at htwo
      rw [← htwo]
      exact hSσ _ (hSσ _ hj)
  have hSτ : τ.val i ∈ S := by
    by_cases hC : i ∈ matchingPairColor τ υ
    · have h : σ i = τ.val i := by simp [σ, matchingPairPermutation, matchingPairSuccessor, hC]
      rw [← h]
      exact hSσ i hSself
    · have h : σ.symm i = τ.val i := by
        simp [σ, matchingPairPermutation, matchingPairPredecessor, hC]
      rw [← h]
      exact hSσinv i hSself
  have hright : B ⊆ S := by
    intro j hj
    rcases hj with h | h
    · exact orbit_subset_of_closed p S i hSself hSp hSpinv h
    · exact orbit_subset_of_closed p S (τ.val i) hSτ hSp hSpinv h
  exact Set.Subset.antisymm hleft hright

end Ising2DLambda.AlgebraicEigenvalue
