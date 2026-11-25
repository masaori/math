/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.ReferenceLongMate
import Ising2DLambda.NecSuf.KacWard.ReferenceLongMate

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- The abstract involution calculation specializes to oriented-edge reversal. -/
theorem referenceLongMate_eq_reversal_from_necSuf {L : ℕ} (e : OrientedEdge L) :
    perfectMatchingMate
      (⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩ :
        PerfectMatching (OrientedEdge L)) e = reversal e := by
  exact Ising2DLambda.NecSuf.KacWard.referenceLongMate_eq_involution
    reversal (reversal_ne (L := L))
    (referenceLongMatching_isPerfectMatching L) e

end Ising2DLambda.KacWard
