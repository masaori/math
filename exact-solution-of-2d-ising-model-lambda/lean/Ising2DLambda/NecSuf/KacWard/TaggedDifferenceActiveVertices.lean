import Ising2DLambda.NecSuf.KacWard.TaggedSymmetricDifferenceDegree

namespace Ising2DLambda.NecSuf.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open scoped symmDiff

variable {J : Type*} [Fintype J]

/-- A point is active exactly when its two labelled incident pairs differ. -/
noncomputable def activeVertices (D R : PerfectMatching J) (T : Set (Set J)) : Set J :=
  {i | taggedPairAt D T i ≠ taggedPairAt R ∅ i}

theorem mem_activeVertices_iff_incident (D R : PerfectMatching J)
    (T : Set (Set J)) (i : J) :
    i ∈ activeVertices D R T ↔
      ∃ q ∈ taggedEdges D T ∆ taggedEdges R ∅, i ∈ q.1 := by
  classical
  constructor
  · intro hi
    let d := taggedPairAt D T i
    exact ⟨d, (taggedDifference_incident_iff D R T i d).mpr
      ⟨hi, Or.inl rfl⟩⟩
  · rintro ⟨q, hq, hi⟩
    exact ((taggedDifference_incident_iff D R T i q).mp ⟨hq, hi⟩).1

/-- The two matchings only need unique labelled incident pairs. Membership of
    either retained pair makes its other endpoint active, even for parallel
    pairs with distinct labels. -/
theorem activeVertices_mates (D R : PerfectMatching J) (T : Set (Set J))
    (i : J) (hi : i ∈ activeVertices D R T) :
    perfectMatchingMate D i ∈ activeVertices D R T ∧
      perfectMatchingMate R i ∈ activeVertices D R T := by
  classical
  let A := taggedEdges D T ∆ taggedEdges R ∅
  let d := taggedPairAt D T i
  let r := taggedPairAt R ∅ i
  have hactive : d ≠ r := hi
  -- The two labelled pairs at the point both survive the symmetric difference.
  have hd : d ∈ A :=
    (taggedDifference_incident_iff D R T i d).mpr
      ⟨hactive, Or.inl rfl⟩ |>.1
  have hr : r ∈ A :=
    (taggedDifference_incident_iff D R T i r).mpr
      ⟨hactive, Or.inr rfl⟩ |>.1
  constructor
  -- Each mate belongs to its surviving pair, so it is active by incidence.
  · have hj : perfectMatchingMate D i ∈ d.1 := by
      simp [d, taggedPairAt]
    exact ((taggedDifference_incident_iff D R T
      (perfectMatchingMate D i) d).mp ⟨hd, hj⟩).1
  · have hj : perfectMatchingMate R i ∈ r.1 := by
      simp [r, taggedPairAt]
    exact ((taggedDifference_incident_iff D R T
      (perfectMatchingMate R i) r).mp ⟨hr, hj⟩).1

end Ising2DLambda.NecSuf.KacWard
