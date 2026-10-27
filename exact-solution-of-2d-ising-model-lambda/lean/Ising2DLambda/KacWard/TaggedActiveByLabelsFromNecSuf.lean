import Ising2DLambda.KacWard.TaggedComplementActiveVerticesConcrete
import Ising2DLambda.KacWard.ReferenceLongMate
import Ising2DLambda.KacWard.TaggedSymmetricDifferenceConcreteFromNecSuf
import Ising2DLambda.NecSuf.KacWard.TaggedDifferenceActiveVertices

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
attribute [local instance] Classical.propDecidable

/-- The concrete labelled-pair comparison specializes the abstract activity predicate. -/
theorem taggedActiveByLabels_eq_activeVertices {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) :
    taggedActiveByLabels D t =
      Ising2DLambda.NecSuf.KacWard.activeVertices D
        (⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩ :
          PerfectMatching (OrientedEdge L)) (shortUnderlyingPairs t) := by
  ext e
  simp only [taggedActiveByLabels, Ising2DLambda.NecSuf.KacWard.activeVertices,
    Ising2DLambda.NecSuf.KacWard.taggedPairAt, Set.mem_setOf_eq]
  rw [referenceLongMate_eq_reversal]
  simp

/-- The abstract activity predicate also gives the concrete tagged difference. -/
theorem taggedActiveByLabels_eq_concreteTaggedActiveVertices_from_necSuf {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) :
    taggedActiveByLabels D t = concreteTaggedActiveVertices D t := by
  calc
    taggedActiveByLabels D t =
        Ising2DLambda.NecSuf.KacWard.activeVertices D
          (⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩ :
            PerfectMatching (OrientedEdge L)) (shortUnderlyingPairs t) :=
      taggedActiveByLabels_eq_activeVertices D t
    _ = concreteTaggedActiveVertices D t :=
      (concreteTaggedActiveVertices_eq_necSuf D t).symm

end Ising2DLambda.KacWard
