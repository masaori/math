import Ising2DLambda.KacWard.TwistedFourierMatrix
import Ising2DLambda.NecSuf.KacWard.TwistedFourierMatrix

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

theorem twistedFourierMatrix_from_necSuf {L : ℕ}
    (s : SpinStructure)
    (κ : OrientedEdge L ≃ {m // m ∈ fourierModeIndexSet L s}) :
    twistedFourierMatrix s κ =
      Ising2DLambda.NecSuf.KacWard.fourierMatrix κ
        (fun m e => endpointModeVector L m.val.1 m.val.2.1 m.val.2.2 e) := by
  rfl

end Ising2DLambda.KacWard
