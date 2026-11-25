/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.TransitionEntries
import Ising2DLambda.NecSuf.KacWard.TransitionEntries

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem transitionEntry_mem_mu8_from_necSuf {z s r : Qbar} (hz : z ^ 4 = -1)
    (hs2 : s ^ 2 = 1) (hr : r = 1 ∨ r = z ∨ r = z⁻¹) :
    (s * r) ^ 8 = 1 :=
  Ising2DLambda.NecSuf.KacWard.signed_phase_pow_eight hz hs2 hr

end Ising2DLambda.KacWard
