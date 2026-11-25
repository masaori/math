/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.ClosedWalkCrossingNumber
import Ising2DLambda.NecSuf.KacWard.ClosedWalkCrossingNumber

namespace Ising2DLambda.KacWard

theorem closedWalkCrossingNumber_from_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) :
    closedWalkCrossingNumber γ hγ =
      Ising2DLambda.NecSuf.KacWard.closedWalkCrossingNumber edgeTransverseCrossing γ := by
  rfl

end Ising2DLambda.KacWard
