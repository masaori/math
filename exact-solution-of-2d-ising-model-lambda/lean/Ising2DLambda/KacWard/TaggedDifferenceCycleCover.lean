import Ising2DLambda.KacWard.TaggedDifferenceAlternatingCycle
import Ising2DLambda.NecSuf.KacWard.TaggedDifferenceCycleCover

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
  obtain ⟨hself, hdisj, hmates⟩ :=
    Ising2DLambda.NecSuf.KacWard.alternatingCycle_cover τ υ
  refine ⟨hself, hdisj, ?_⟩
  intro q hq i hi j hj hne
  have hqi := (Ising2DLambda.NecSuf.KacWard.taggedDifference_incident_iff
    D R T i q).mp ⟨hq, hi⟩
  have hqj := (Ising2DLambda.NecSuf.KacWard.taggedDifference_incident_iff
    D R T j q).mp ⟨hq, hj⟩
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
        exact (Ising2DLambda.NecSuf.KacWard.alternatingCycle_pair_step τ υ ii).1
    · have hjpair : j ∈ (Ising2DLambda.NecSuf.KacWard.taggedPairAt R ∅ i).1 := by
        rw [← hr]
        exact hj
      rcases (by simpa [Ising2DLambda.NecSuf.KacWard.taggedPairAt] using hjpair :
        j = i ∨ j = perfectMatchingMate R i) with h | h
      · exact False.elim (hne h.symm)
      · have hsub : jj = υ.val ii := Subtype.ext h
        rw [hsub]
        exact (Ising2DLambda.NecSuf.KacWard.alternatingCycle_pair_step τ υ ii).2

end Ising2DLambda.KacWard
