import Ising2DLambda.KacWard.DualTwistedFourierMatrix
import Ising2DLambda.NecSuf.KacWard.DualTwistedFourierMatrix

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

theorem dualTwistedFourierMatrix_from_necSuf {L : ℕ}
    (s : SpinStructure)
    (κ : OrientedEdge L ≃ {m // m ∈ fourierModeIndexSet L s}) :
    dualTwistedFourierMatrix s κ =
      Ising2DLambda.NecSuf.KacWard.dualFourierMatrix κ
        (fun m e => dualEndpointModeVector L m.val.1 m.val.2.1 m.val.2.2 e) := by
  rfl

theorem twistedFourierInverseCandidate_from_necSuf {L : ℕ}
    (s : SpinStructure)
    (κ : OrientedEdge L ≃ {m // m ∈ fourierModeIndexSet L s}) :
    twistedFourierInverseCandidate s κ =
      Ising2DLambda.NecSuf.KacWard.fourierInverseCandidate ((L : Qbar)⁻¹ ^ 2) κ
        (fun m e => dualEndpointModeVector L m.val.1 m.val.2.1 m.val.2.2 e) := by
  rfl

end Ising2DLambda.KacWard
