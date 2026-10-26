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
    let R : PerfectMatching (OrientedEdge L) :=
      ⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩
    let A := Ising2DLambda.NecSuf.KacWard.activeVertices D R (shortUnderlyingPairs t)
    let τ := shortInvolution D t
    let υ := longInvolution D t
    (∀ i : {i : OrientedEdge L // i ∈ A}, i ∈ matchingPairComponent τ υ i) ∧
    (∀ i j : {i : OrientedEdge L // i ∈ A},
      matchingPairComponent τ υ i = matchingPairComponent τ υ j ∨
        Disjoint (matchingPairComponent τ υ i) (matchingPairComponent τ υ j)) ∧
    (∀ q ∈ (Ising2DLambda.NecSuf.KacWard.taggedEdges D (shortUnderlyingPairs t) ∆
      Ising2DLambda.NecSuf.KacWard.taggedEdges R ∅),
      ∀ i ∈ q.1, ∀ j ∈ q.1, i ≠ j →
        ∃ (ii jj : {k : OrientedEdge L // k ∈ A}),
          ii.1 = i ∧ jj.1 = j ∧ jj ∈ matchingPairComponent τ υ ii ∧
            (matchingPairPermutation τ υ ii = jj ∨
              matchingPairPermutation τ υ jj = ii)) := by
  dsimp
  let R : PerfectMatching (OrientedEdge L) :=
    ⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩
  let T := shortUnderlyingPairs t
  let A := Ising2DLambda.NecSuf.KacWard.activeVertices D R T
  let τ := shortInvolution D t
  let υ := longInvolution D t
  let σ := matchingPairPermutation τ υ
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
  have hqi := (taggedDifference_incident_iff D t i q).mp ⟨hq, hi⟩
  have hqj := (taggedDifference_incident_iff D t j q).mp ⟨hq, hj⟩
  let ii : {k : OrientedEdge L // k ∈ A} := ⟨i, hqi.1⟩
  let jj : {k : OrientedEdge L // k ∈ A} := ⟨j, hqj.1⟩
  refine ⟨ii, jj, rfl, rfl, ?_, ?_⟩
  · rcases hqi.2 with hd | hr
    · have hjpair : j ∈ (Ising2DLambda.NecSuf.KacWard.taggedPairAt D T i).1 := by
        rw [← hd]
        exact hj
      rcases (by simpa [Ising2DLambda.NecSuf.KacWard.taggedPairAt] using hjpair :
        j = i ∨ j = perfectMatchingMate D i) with h | h
      · have hsub : jj = ii := Subtype.ext h
        rw [hsub]
        exact hself ii
      · have hsub : jj = τ.val ii := Subtype.ext h
        rw [hsub]
        exact (hmates ii).1
    · have hjpair : j ∈ (Ising2DLambda.NecSuf.KacWard.taggedPairAt R ∅ i).1 := by
        rw [← hr]
        exact hj
      rcases (by simpa [Ising2DLambda.NecSuf.KacWard.taggedPairAt] using hjpair :
        j = i ∨ j = perfectMatchingMate R i) with h | h
      · have hsub : jj = ii := Subtype.ext h
        rw [hsub]
        exact hself ii
      · have hsub : jj = υ.val ii := Subtype.ext h
        rw [hsub]
        exact (hmates ii).2
  · rcases hqi.2 with hd | hr
    · have hjpair : j ∈ (Ising2DLambda.NecSuf.KacWard.taggedPairAt D T i).1 := by
        rw [← hd]
        exact hj
      rcases (by simpa [Ising2DLambda.NecSuf.KacWard.taggedPairAt] using hjpair :
        j = i ∨ j = perfectMatchingMate D i) with h | h
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
    · have hjpair : j ∈ (Ising2DLambda.NecSuf.KacWard.taggedPairAt R ∅ i).1 := by
        rw [← hr]
        exact hj
      rcases (by simpa [Ising2DLambda.NecSuf.KacWard.taggedPairAt] using hjpair :
        j = i ∨ j = perfectMatchingMate R i) with h | h
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
