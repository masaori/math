import Ising2DLambda.KacWard.TaggedDifferenceAlternatingCycle

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open scoped symmDiff
attribute [local instance] Classical.propDecidable

/-- The cycles of the actual tagged symmetric difference partition its active
    oriented edges, and each retained tagged pair stays in one cycle. -/
theorem taggedActive_cycleCover {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) :
    let A := concreteTaggedActiveVertices D t
    (∀ i : {i : OrientedEdge L // i ∈ A}, i ∈ concreteAlternatingComponent D t i) ∧
    (∀ i j : {i : OrientedEdge L // i ∈ A},
      concreteAlternatingComponent D t i = concreteAlternatingComponent D t j ∨
        Disjoint (concreteAlternatingComponent D t i)
          (concreteAlternatingComponent D t j)) ∧
    (∀ q ∈ concreteTaggedDifference D t,
      ∀ i ∈ q.1, ∀ j ∈ q.1, i ≠ j →
        ∃ (ii jj : {k : OrientedEdge L // k ∈ A}),
          ii.1 = i ∧ jj.1 = j ∧ jj ∈ concreteAlternatingComponent D t ii ∧
            (concreteAlternatingSuccessor D t ii = jj ∨
              concreteAlternatingSuccessor D t jj = ii)) := by
  dsimp
  let R : PerfectMatching (OrientedEdge L) :=
    ⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩
  let A := concreteTaggedActiveVertices D t
  let τ := concreteShortInvolution D t
  let υ := concreteLongInvolution D t
  have hself (i : {i : OrientedEdge L // i ∈ A}) :
      i ∈ matchingPairComponent τ υ i :=
    Or.inl (finitePermutationOrbit_self_mem (matchingPairStep τ υ) i)
  have hdisj (i j : {i : OrientedEdge L // i ∈ A}) :
      matchingPairComponent τ υ i = matchingPairComponent τ υ j ∨
        Disjoint (matchingPairComponent τ υ i) (matchingPairComponent τ υ j) := by
    by_cases h : matchingPairComponent τ υ i ∩ matchingPairComponent τ υ j = ∅
    · exact Or.inr (Set.disjoint_iff_inter_eq_empty.mpr h)
    · left
      obtain ⟨k, hki, hkj⟩ :
          (matchingPairComponent τ υ i ∩ matchingPairComponent τ υ j).Nonempty :=
        Set.nonempty_iff_ne_empty.mpr h
      exact (matchingPairComponent_basepoint τ υ i k hki).symm.trans
        (matchingPairComponent_basepoint τ υ j k hkj)
  have hmates (i : {i : OrientedEdge L // i ∈ A}) :
      τ.val i ∈ matchingPairComponent τ υ i ∧
        υ.val i ∈ matchingPairComponent τ υ i := by
    constructor
    · exact Or.inr (finitePermutationOrbit_self_mem (matchingPairStep τ υ) (τ.val i))
    · have hτ : τ.val i ∈ finitePermutationOrbit (matchingPairStep τ υ) (τ.val i) :=
        finitePermutationOrbit_self_mem _ _
      have hp := (finitePermutationOrbit_invariant (matchingPairStep τ υ)
        (τ.val i) (τ.val i)).mpr hτ
      change υ.val (τ.val (τ.val i)) ∈
        finitePermutationOrbit (matchingPairStep τ υ) (τ.val i) at hp
      rw [τ.property.2 i] at hp
      exact Or.inr hp
  refine ⟨hself, hdisj, ?_⟩
  intro q hq i hi j hj hne
  have hpair :
      (j = i ∨ j = perfectMatchingMate D i) ∨
        (j = i ∨ j = perfectMatchingMate R i) := by
    rcases Set.mem_symmDiff.mp hq with ⟨hD, _⟩ | ⟨hR, _⟩
    · obtain ⟨p, hp, hqeq⟩ := hD
      have hip : i ∈ p := by rw [hqeq] at hi; exact hi
      have hjp : j ∈ p := by rw [hqeq] at hj; exact hj
      have hp0 : ({i, perfectMatchingMate D i} : Set (OrientedEdge L)) ∈ D.val :=
        (perfectMatchingMate_spec D i).2
      have heq : p = ({i, perfectMatchingMate D i} : Set (OrientedEdge L)) :=
        (D.property.2 i).unique ⟨hp, hip⟩ ⟨hp0, by simp⟩
      left
      simpa [heq] using hjp
    · obtain ⟨p, hp, hqeq⟩ := hR
      have hip : i ∈ p := by rw [hqeq] at hi; exact hi
      have hjp : j ∈ p := by rw [hqeq] at hj; exact hj
      have hp0 : ({i, perfectMatchingMate R i} : Set (OrientedEdge L)) ∈ R.val :=
        (perfectMatchingMate_spec R i).2
      have heq : p = ({i, perfectMatchingMate R i} : Set (OrientedEdge L)) :=
        (R.property.2 i).unique ⟨hp, hip⟩ ⟨hp0, by simp⟩
      right
      simpa [heq] using hjp
  let ii : {k : OrientedEdge L // k ∈ A} := ⟨i, ⟨q, hq, hi⟩⟩
  let jj : {k : OrientedEdge L // k ∈ A} := ⟨j, ⟨q, hq, hj⟩⟩
  refine ⟨ii, jj, rfl, rfl, ?_, ?_⟩
  · rcases hpair with hd | hr
    · rcases hd with h | h
      · have hsub : jj = ii := Subtype.ext h
        rw [hsub]
        exact hself ii
      · have hsub : jj = τ.val ii := Subtype.ext h
        rw [hsub]
        exact (hmates ii).1
    · rcases hr with h | h
      · have hsub : jj = ii := Subtype.ext h
        rw [hsub]
        exact hself ii
      · have hsub : jj = υ.val ii := Subtype.ext h
        rw [hsub]
        exact (hmates ii).2
  · rcases hpair with hd | hr
    · rcases hd with h | h
      · exact False.elim (hne h.symm)
      · have hsub : jj = τ.val ii := Subtype.ext h
        rw [hsub]
        by_cases hc : ii ∈ matchingPairColor τ υ
        · left
          change (if ii ∈ matchingPairColor τ υ then τ.val ii else υ.val ii) = τ.val ii
          rw [if_pos hc]
        · right
          have hm : τ.val ii ∈ matchingPairColor τ υ :=
            (matchingPairColor_alternates τ υ ii).mpr hc
          change (if τ.val ii ∈ matchingPairColor τ υ then
            τ.val (τ.val ii) else υ.val (τ.val ii)) = ii
          rw [if_pos hm, τ.property.2 ii]
    · rcases hr with h | h
      · exact False.elim (hne h.symm)
      · have hsub : jj = υ.val ii := Subtype.ext h
        rw [hsub]
        by_cases hc : ii ∈ matchingPairColor τ υ
        · right
          have hm : υ.val ii ∉ matchingPairColor τ υ := by
            intro h
            exact ((matchingPairSecondColor_alternates τ υ ii).mp h) hc
          change (if υ.val ii ∈ matchingPairColor τ υ then
            τ.val (υ.val ii) else υ.val (υ.val ii)) = ii
          rw [if_neg hm, υ.property.2 ii]
        · left
          change (if ii ∈ matchingPairColor τ υ then τ.val ii else υ.val ii) = υ.val ii
          rw [if_neg hc]

end Ising2DLambda.KacWard
