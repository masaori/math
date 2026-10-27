import Ising2DLambda.KacWard.TaggedComplementActiveVertices
import Ising2DLambda.KacWard.TaggedActiveByLabelsFromNecSuf

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- The abstract activity predicate specializes to the concrete complement. -/
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
