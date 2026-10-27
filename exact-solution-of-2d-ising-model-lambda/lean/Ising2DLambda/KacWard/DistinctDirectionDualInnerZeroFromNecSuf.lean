import Ising2DLambda.KacWard.DistinctDirectionDualInnerZero
import Ising2DLambda.NecSuf.KacWard.DistinctDirectionDualInnerZero
import Ising2DLambda.KacWard.DualEndpointModeVectorFromNecSuf
import Ising2DLambda.KacWard.EndpointModeVectorFromNecSuf

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open BigOperators

theorem distinctDirection_dualInner_zero_from_necSuf {L : ℕ}
    (varpi varsigma varpi' varsigma' : Qbar) (δ δ' : ZMod 4)
    (hne : δ ≠ δ') :
    ∑ e : OrientedEdge L,
      dualEndpointModeVector L varpi varsigma δ e *
        endpointModeVector L varpi' varsigma' δ' e = 0 := by
  simpa only [dualEndpointModeVector_from_necSuf,
    endpointModeVector_from_necSuf] using
    Ising2DLambda.NecSuf.KacWard.distinctDirection_dualInner_zero_necSuf
      (fun e : OrientedEdge L => (orientedTarget e).1.val)
      (fun e : OrientedEdge L => (orientedTarget e).2.val)
      directionNumber varpi varsigma varpi' varsigma' δ δ' hne

end Ising2DLambda.KacWard
