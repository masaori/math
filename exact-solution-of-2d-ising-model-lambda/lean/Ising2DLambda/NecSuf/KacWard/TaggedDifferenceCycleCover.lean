import Ising2DLambda.NecSuf.KacWard.TaggedDifferenceAlternatingCycle

namespace Ising2DLambda.NecSuf.KacWard

open Ising2DLambda.AlgebraicEigenvalue

variable {J : Type*} [Fintype J]

/-- Components of the two labelled mate involutions partition the active points. -/
theorem alternatingCycle_cover (τ υ : FixedPointFreeInvolution J) :
    (∀ i : J, i ∈ matchingPairComponent τ υ i) ∧
    (∀ i j : J, matchingPairComponent τ υ i = matchingPairComponent τ υ j ∨
      Disjoint (matchingPairComponent τ υ i) (matchingPairComponent τ υ j)) ∧
    (∀ i : J, τ.val i ∈ matchingPairComponent τ υ i ∧
      υ.val i ∈ matchingPairComponent τ υ i) := by
  let p := matchingPairStep τ υ
  constructor
  · intro i
    exact Or.inl (finitePermutationOrbit_self_mem p i)
  constructor
  · intro i j
    by_cases h : matchingPairComponent τ υ i ∩ matchingPairComponent τ υ j = ∅
    · exact Or.inr (Set.disjoint_iff_inter_eq_empty.mpr h)
    · left
      have hw : (matchingPairComponent τ υ i ∩ matchingPairComponent τ υ j).Nonempty :=
        Set.nonempty_iff_ne_empty.mpr h
      obtain ⟨k, hki, hkj⟩ := hw
      calc
        matchingPairComponent τ υ i = matchingPairComponent τ υ k :=
          (matchingPairComponent_basepoint τ υ i k hki).symm
        _ = matchingPairComponent τ υ j :=
          matchingPairComponent_basepoint τ υ j k hkj
  · intro i
    constructor
    · exact Or.inr (finitePermutationOrbit_self_mem p (τ.val i))
    · have hτ : τ.val i ∈ finitePermutationOrbit p (τ.val i) :=
        finitePermutationOrbit_self_mem p (τ.val i)
      have hp : p (τ.val i) ∈ finitePermutationOrbit p (τ.val i) :=
        (finitePermutationOrbit_invariant p (τ.val i) (τ.val i)).mpr hτ
      change υ.val (τ.val (τ.val i)) ∈ finitePermutationOrbit p (τ.val i) at hp
      rw [τ.property.2 i] at hp
      exact Or.inr hp

/-- Each pair of either colour occurs as a successor step in its component. -/
theorem alternatingCycle_pair_step [LinearOrder J]
    (τ υ : FixedPointFreeInvolution J) (i : J) :
    (matchingPairPermutation τ υ i = τ.val i ∨
      matchingPairPermutation τ υ (τ.val i) = i) ∧
    (matchingPairPermutation τ υ i = υ.val i ∨
      matchingPairPermutation τ υ (υ.val i) = i) := by
  classical
  constructor
  · by_cases hi : i ∈ matchingPairColor τ υ
    · left
      simp [matchingPairPermutation, matchingPairSuccessor, hi]
    · right
      have hm : τ.val i ∈ matchingPairColor τ υ :=
        (matchingPairColor_alternates τ υ i).mpr hi
      simp [matchingPairPermutation, matchingPairSuccessor, hm, τ.property.2 i]
  · by_cases hi : i ∈ matchingPairColor τ υ
    · right
      have hm : υ.val i ∉ matchingPairColor τ υ := by
        intro h
        exact ((matchingPairSecondColor_alternates τ υ i).mp h) hi
      simp [matchingPairPermutation, matchingPairSuccessor, hm, υ.property.2 i]
    · left
      simp [matchingPairPermutation, matchingPairSuccessor, hi]

end Ising2DLambda.NecSuf.KacWard
