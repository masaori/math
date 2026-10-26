import Ising2DLambda.KacWard.ReferenceLongMatching
import Ising2DLambda.KacWard.TaggedMatchingNonzeroSupport

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- The long labelled pair of a nonzero tagged term is a reversal pair. -/
theorem nonzeroLongPair_mem_referenceLongPairs {L : ℕ} (z : Qbar)
    (s : SpinStructure) (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0)
    (p : OrientedEdge L × OrientedEdge L)
    (hp : p ∈ matchingOrientedPairs D \ t) :
    ({p.1, p.2} : Set (OrientedEdge L)) ∈ referenceLongPairs L := by
  have hreverse := (taggedMatching_nonzero_term_support z s D t hterm).1 p hp
  change ∃ e : OrientedEdge L, ({p.1, p.2} : Set (OrientedEdge L)) =
    {e, reversal e}
  refine ⟨p.1, ?_⟩
  rw [hreverse]

end Ising2DLambda.KacWard
