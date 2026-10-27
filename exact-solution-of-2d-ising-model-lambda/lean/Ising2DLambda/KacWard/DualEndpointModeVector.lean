import Ising2DLambda.KacWard.EndpointModeVector

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

noncomputable def dualEndpointModeVector (L : ℕ) (varpi varsigma : Qbar)
    (δ₀ : ZMod 4) : OrientedEdge L → Qbar := fun e =>
  if directionNumber e = δ₀ then
    varpi⁻¹ ^ (orientedTarget e).2.val * varsigma⁻¹ ^ (orientedTarget e).1.val
  else 0

end Ising2DLambda.KacWard
