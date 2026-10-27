import Ising2DLambda.KacWard.EndpointModeVector
import Ising2DLambda.NecSuf.KacWard.EndpointModeVector

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

theorem endpointModeVector_from_necSuf (L : ℕ) (varpi varsigma : Qbar)
    (δ₀ : ZMod 4) : endpointModeVector L varpi varsigma δ₀ =
      Ising2DLambda.NecSuf.KacWard.endpointModeVector
        (fun e : OrientedEdge L => (orientedTarget e).1.val)
        (fun e : OrientedEdge L => (orientedTarget e).2.val)
        directionNumber varpi varsigma δ₀ := rfl

end Ising2DLambda.KacWard
