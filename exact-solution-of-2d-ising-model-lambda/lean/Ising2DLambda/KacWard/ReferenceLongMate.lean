import Ising2DLambda.KacWard.TaggedShortPairSuccessor

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

end Ising2DLambda.KacWard
