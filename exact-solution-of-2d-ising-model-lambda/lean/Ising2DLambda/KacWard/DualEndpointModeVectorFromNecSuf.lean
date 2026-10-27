import Ising2DLambda.KacWard.DualEndpointModeVector
import Ising2DLambda.NecSuf.KacWard.DualEndpointModeVector

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

theorem dualEndpointModeVector_from_necSuf (L : ℕ) (varpi varsigma : Qbar)
    (δ₀ : ZMod 4) : dualEndpointModeVector L varpi varsigma δ₀ =
      Ising2DLambda.NecSuf.KacWard.dualEndpointModeVector
        (fun e : OrientedEdge L => (orientedTarget e).1.val)
        (fun e : OrientedEdge L => (orientedTarget e).2.val)
        directionNumber varpi varsigma δ₀ := rfl

end Ising2DLambda.KacWard
