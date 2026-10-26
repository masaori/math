import Ising2DLambda.KacWard.TaggedShortPairSuccessor
import Ising2DLambda.NecSuf.KacWard.ReferenceLongMate

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- The long mate of an active oriented edge is its reversal, including at side length one. -/
theorem referenceLongMate_eq_reversal {L : ℕ} (e : OrientedEdge L) :
    perfectMatchingMate
      (⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩ :
        PerfectMatching (OrientedEdge L)) e = reversal e := by
  apply perfectMatchingMate_eq_of_pair
  · exact reversal_ne e
  · exact ⟨e, rfl⟩

/-- The abstract involution calculation specializes to oriented-edge reversal. -/
theorem referenceLongMate_eq_reversal_from_necSuf {L : ℕ} (e : OrientedEdge L) :
    perfectMatchingMate
      (⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩ :
        PerfectMatching (OrientedEdge L)) e = reversal e := by
  exact Ising2DLambda.NecSuf.KacWard.referenceLongMate_eq_involution
    reversal (reversal_ne (L := L))
    (referenceLongMatching_isPerfectMatching L) e

end Ising2DLambda.KacWard
