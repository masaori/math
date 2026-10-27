import Ising2DLambda.KacWard.TaggedMatchingEvenComplement
import Ising2DLambda.KacWard.TaggedSymmetricDifferenceActiveVertices
import Ising2DLambda.KacWard.TaggedDifferenceActiveVertices
import Ising2DLambda.KacWard.TaggedComplementActiveVerticesConcrete
import Ising2DLambda.KacWard.TaggedSymmetricDifferenceConcreteFromNecSuf
import Ising2DLambda.KacWard.ReferenceLongMate

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
attribute [local instance] Classical.propDecidable

/-- The concrete labelled-pair comparison is the activity predicate used in
    the tagged symmetric difference. -/
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

/-- An unoriented edge is in the complement exactly when each of its orientations
    is active in the tagged symmetric difference. -/
theorem taggedComplement_iff_active_from_necSuf {L : ℕ} (z : Qbar) (s : SpinStructure)
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0)
    (e : OrientedEdge L) :
    e.1 ∈ taggedComplementEdges D t ↔
      e ∈ Ising2DLambda.NecSuf.KacWard.activeVertices D
        (⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩ :
          PerfectMatching (OrientedEdge L))
        (shortUnderlyingPairs t) := by
  rw [← taggedActiveByLabels_eq_activeVertices D t]
  exact taggedComplement_iff_active_concrete z s D t ht hterm e

end Ising2DLambda.KacWard
