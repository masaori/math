import Ising2DLambda.KacWard.TaggedSymmetricDifferenceDegree
import Ising2DLambda.NecSuf.KacWard.TaggedDifferenceActiveVertices

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open scoped symmDiff

theorem concreteTaggedDifference_eq_necSuf {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) :
    concreteTaggedDifference D t =
      Ising2DLambda.NecSuf.KacWard.taggedEdges D (shortUnderlyingPairs t) ∆
        Ising2DLambda.NecSuf.KacWard.taggedEdges
          (⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩ :
            PerfectMatching (OrientedEdge L)) ∅ := by
  classical
  ext q
  simp [concreteTaggedDifference, concreteTaggedPairs,
    concreteReferenceTaggedPairs, Ising2DLambda.NecSuf.KacWard.taggedEdges]

theorem concreteTaggedActiveVertices_eq_necSuf {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) :
    concreteTaggedActiveVertices D t =
      Ising2DLambda.NecSuf.KacWard.activeVertices D
        (⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩ :
          PerfectMatching (OrientedEdge L)) (shortUnderlyingPairs t) := by
  classical
  ext e
  rw [Ising2DLambda.NecSuf.KacWard.mem_activeVertices_iff_incident]
  exact ⟨fun ⟨q, hq, he⟩ => ⟨q, concreteTaggedDifference_eq_necSuf D t ▸ hq, he⟩,
    fun ⟨q, hq, he⟩ => ⟨q, (concreteTaggedDifference_eq_necSuf D t).symm ▸ hq, he⟩⟩

end Ising2DLambda.KacWard
