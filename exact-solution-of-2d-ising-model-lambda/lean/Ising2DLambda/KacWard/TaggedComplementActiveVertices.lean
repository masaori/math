import Ising2DLambda.KacWard.TaggedMatchingEvenComplement
import Ising2DLambda.KacWard.TaggedSymmetricDifferenceActiveVertices
import Ising2DLambda.KacWard.TaggedDifferenceActiveVertices
import Ising2DLambda.KacWard.TaggedComplementActiveVerticesConcrete
import Ising2DLambda.KacWard.TaggedSymmetricDifferenceConcreteFromNecSuf
import Ising2DLambda.KacWard.TaggedActiveByLabelsFromNecSuf

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
attribute [local instance] Classical.propDecidable

/-- The activity predicate obtained by comparing labelled pairs is exactly
    incidence with the concrete tagged symmetric difference. -/
theorem taggedActiveByLabels_eq_concreteTaggedActiveVertices {L : ℕ}
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
