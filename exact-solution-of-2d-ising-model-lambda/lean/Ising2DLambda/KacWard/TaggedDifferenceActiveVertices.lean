import Ising2DLambda.KacWard.TaggedSymmetricDifferenceDegree
import Ising2DLambda.NecSuf.KacWard.TaggedDifferenceActiveVertices

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open scoped symmDiff

/-- The alternating walk stays among actual oriented edges of the tagged
    symmetric difference. -/
theorem taggedDifference_active_mates {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (i : OrientedEdge L)
    (hi : i ∈ Ising2DLambda.NecSuf.KacWard.activeVertices D
      ⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩
      (shortUnderlyingPairs t)) :
    perfectMatchingMate D i ∈ Ising2DLambda.NecSuf.KacWard.activeVertices D
      ⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩
      (shortUnderlyingPairs t) ∧
    perfectMatchingMate
      (⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩ :
        PerfectMatching (OrientedEdge L)) i ∈
      Ising2DLambda.NecSuf.KacWard.activeVertices D
        ⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩
        (shortUnderlyingPairs t) := by
  classical
  let R : PerfectMatching (OrientedEdge L) :=
    ⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩
  let A := Ising2DLambda.NecSuf.KacWard.taggedEdges D (shortUnderlyingPairs t) ∆
    Ising2DLambda.NecSuf.KacWard.taggedEdges R ∅
  let d := Ising2DLambda.NecSuf.KacWard.taggedPairAt D (shortUnderlyingPairs t) i
  let r := Ising2DLambda.NecSuf.KacWard.taggedPairAt R ∅ i
  have hactive : d ≠ r := hi
  -- The short and long labelled pairs at the oriented edge both survive.
  have hd : d ∈ A :=
    (taggedDifference_incident_iff D t i d).mpr
      ⟨hactive, Or.inl rfl⟩ |>.1
  have hr : r ∈ A :=
    (taggedDifference_incident_iff D t i r).mpr
      ⟨hactive, Or.inr rfl⟩ |>.1
  constructor
  -- The other endpoint of each surviving pair is an active oriented edge.
  · have hj : perfectMatchingMate D i ∈ d.1 := by
      simp [d, Ising2DLambda.NecSuf.KacWard.taggedPairAt]
    exact ((taggedDifference_incident_iff D t
      (perfectMatchingMate D i) d).mp ⟨hd, hj⟩).1
  · have hj : perfectMatchingMate R i ∈ r.1 := by
      simp [r, Ising2DLambda.NecSuf.KacWard.taggedPairAt]
    exact ((taggedDifference_incident_iff D t
      (perfectMatchingMate R i) r).mp ⟨hr, hj⟩).1

theorem taggedDifference_active_mates_from_necSuf {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (i : OrientedEdge L)
    (hi : i ∈ Ising2DLambda.NecSuf.KacWard.activeVertices D
      ⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩
      (shortUnderlyingPairs t)) :
    perfectMatchingMate D i ∈ Ising2DLambda.NecSuf.KacWard.activeVertices D
      ⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩
      (shortUnderlyingPairs t) ∧
    perfectMatchingMate
      (⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩ :
        PerfectMatching (OrientedEdge L)) i ∈
      Ising2DLambda.NecSuf.KacWard.activeVertices D
        ⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩
        (shortUnderlyingPairs t) := by
  exact Ising2DLambda.NecSuf.KacWard.activeVertices_mates D
    ⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩
    (shortUnderlyingPairs t) i hi

end Ising2DLambda.KacWard
