import Ising2DLambda.KacWard.TaggedSymmetricDifferenceDegree

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open scoped symmDiff

/-- The alternating walk stays among actual oriented edges of the tagged
    symmetric difference. -/
theorem taggedDifference_active_mates {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (i : OrientedEdge L)
    (hi : i ∈ concreteTaggedActiveVertices D t) :
    perfectMatchingMate D i ∈ concreteTaggedActiveVertices D t ∧
    perfectMatchingMate
      (⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩ :
        PerfectMatching (OrientedEdge L)) i ∈
      concreteTaggedActiveVertices D t := by
  classical
  let R : PerfectMatching (OrientedEdge L) :=
    ⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩
  let d := concreteTaggedPairAt D t i
  let r := concreteTaggedPairAt R ∅ i
  obtain ⟨q, hq, hqi⟩ := hi
  have hactive : d ≠ r :=
    ((taggedDifference_incident_iff D t i q).mp ⟨hq, hqi⟩).1
  -- The short and long labelled pairs at the oriented edge both survive.
  have hd : d ∈ concreteTaggedDifference D t :=
    (taggedDifference_incident_iff D t i d).mpr
      ⟨hactive, Or.inl rfl⟩ |>.1
  have hr : r ∈ concreteTaggedDifference D t :=
    (taggedDifference_incident_iff D t i r).mpr
      ⟨hactive, Or.inr rfl⟩ |>.1
  constructor
  -- The other endpoint of each surviving pair is an active oriented edge.
  · have hj : perfectMatchingMate D i ∈ d.1 := by
      simp [d, concreteTaggedPairAt]
    exact ⟨d, hd, hj⟩
  · have hj : perfectMatchingMate R i ∈ r.1 := by
      simp [r, concreteTaggedPairAt]
    exact ⟨r, hr, hj⟩

end Ising2DLambda.KacWard
