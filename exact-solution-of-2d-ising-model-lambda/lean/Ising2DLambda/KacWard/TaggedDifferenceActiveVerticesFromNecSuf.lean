/- 具体版の活動点が必要十分版の活動点の特殊化であることと、二つの相手が活動点に留まることの導出。 -/
import Ising2DLambda.KacWard.TaggedDifferenceActiveVertices
import Ising2DLambda.KacWard.TaggedSymmetricDifferenceDegreeFromNecSuf
import Ising2DLambda.NecSuf.KacWard.TaggedDifferenceActiveVertices

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open scoped symmDiff

theorem concreteTaggedActiveVertices_eq_activeVertices {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) :
    concreteTaggedActiveVertices D t =
      Ising2DLambda.NecSuf.KacWard.activeVertices D
        ⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩
        (shortUnderlyingPairs t) := by
  classical
  let R : PerfectMatching (OrientedEdge L) :=
    ⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩
  have hEq : concreteTaggedDifference D t =
      Ising2DLambda.NecSuf.KacWard.taggedEdges D (shortUnderlyingPairs t) ∆
        Ising2DLambda.NecSuf.KacWard.taggedEdges R ∅ := by
    ext q
    simp [concreteTaggedDifference, concreteTaggedPairs,
      concreteReferenceTaggedPairs, Ising2DLambda.NecSuf.KacWard.taggedEdges, R]
  ext i
  simp only [concreteTaggedActiveVertices, Set.mem_setOf_eq,
    Ising2DLambda.NecSuf.KacWard.activeVertices]
  constructor
  · rintro ⟨q, hq, hi⟩
    exact ((taggedDifference_incident_iff_from_necSuf D t i q).mp ⟨hEq ▸ hq, hi⟩).1
  · intro hi
    let q := Ising2DLambda.NecSuf.KacWard.taggedPairAt D (shortUnderlyingPairs t) i
    have h := (taggedDifference_incident_iff_from_necSuf D t i q).mpr ⟨hi, Or.inl rfl⟩
    exact ⟨q, hEq.symm ▸ h.1, h.2⟩

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
  rw [← concreteTaggedActiveVertices_eq_activeVertices] at hi ⊢
  exact taggedDifference_active_mates D t i hi

end Ising2DLambda.KacWard
