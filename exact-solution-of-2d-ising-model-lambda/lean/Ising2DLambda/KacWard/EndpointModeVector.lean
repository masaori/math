import Ising2DLambda.KacWard.TwistedModeSets
import Ising2DLambda.KacWard.ReversalDirectionShift
import Ising2DLambda.KacWard.ReversalFreeMovedSupportEven

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- The coordinate in a Fourier vector is the target of the oriented edge. -/
noncomputable def endpointModeVector (L : ℕ) (varpi varsigma : Qbar)
    (δ₀ : ZMod 4) : OrientedEdge L → Qbar := fun e =>
  if directionNumber e = δ₀ then
    varpi ^ (orientedTarget e).2.val * varsigma ^ (orientedTarget e).1.val
  else 0

end Ising2DLambda.KacWard
