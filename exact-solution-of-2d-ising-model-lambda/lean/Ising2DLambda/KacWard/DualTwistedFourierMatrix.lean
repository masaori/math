import Ising2DLambda.KacWard.TwistedFourierMatrix
import Ising2DLambda.KacWard.DualEndpointModeVector

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

noncomputable def dualTwistedFourierMatrix {L : ℕ} (s : SpinStructure)
    (κ : OrientedEdge L ≃ {m // m ∈ fourierModeIndexSet L s}) :
    Matrix (OrientedEdge L) (OrientedEdge L) Qbar :=
  fun g e => dualEndpointModeVector L (κ g).val.1 (κ g).val.2.1 (κ g).val.2.2 e

noncomputable def twistedFourierInverseCandidate {L : ℕ} (s : SpinStructure)
    (κ : OrientedEdge L ≃ {m // m ∈ fourierModeIndexSet L s}) :
    Matrix (OrientedEdge L) (OrientedEdge L) Qbar :=
  (L : Qbar)⁻¹ ^ 2 • dualTwistedFourierMatrix s κ

end Ising2DLambda.KacWard
