/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.ClosedWalkRotationNumber
import Ising2DLambda.NecSuf.KacWard.ClosedWalkRotationNumber

namespace Ising2DLambda.KacWard

theorem closedWalkRotationNumber_from_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) :
    closedWalkRotationNumber γ hγ =
      Ising2DLambda.NecSuf.KacWard.rotationNumber (cyclicTotalTurning γ hγ) := rfl

end Ising2DLambda.KacWard
