import Ising2DLambda.KacWard.EdgeModeIndexBijection
import Ising2DLambda.KacWard.EndpointModeVector

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

noncomputable def twistedFourierMatrix {L : ℕ} (s : SpinStructure)
    (κ : OrientedEdge L ≃ {m // m ∈ fourierModeIndexSet L s}) :
    Matrix (OrientedEdge L) (OrientedEdge L) Qbar :=
  fun e g => endpointModeVector L (κ g).val.1 (κ g).val.2.1 (κ g).val.2.2 e

end Ising2DLambda.KacWard
