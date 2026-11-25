/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.ReferenceLongMatching
import Ising2DLambda.NecSuf.KacWard.ReferenceLongMatching

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

theorem referenceLongMatching_from_necSuf (L : ℕ) :
    IsPerfectMatching (referenceLongPairs L) := by
  exact Ising2DLambda.NecSuf.KacWard.reversalPairs_isPerfectMatching
    (reversal (L := L)) (reversal_ne (L := L)) (reversal_involutive (L := L))

end Ising2DLambda.KacWard
