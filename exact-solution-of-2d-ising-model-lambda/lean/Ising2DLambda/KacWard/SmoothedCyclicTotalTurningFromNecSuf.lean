/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.SmoothedCyclicTotalTurning
import Ising2DLambda.NecSuf.KacWard.SmoothedCyclicTotalTurning
import Ising2DLambda.KacWard.ClosedWalkPassesFromNecSuf

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

theorem smoothedCyclicTotalTurning_from_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (k l : Fin (m + 1)) :
    smoothedCyclicTotalTurning γ hγ k l =
      Ising2DLambda.NecSuf.KacWard.smoothedCyclicTotalTurning
        stepTurning γ k l := by
  simp only [smoothedCyclicTotalTurning,
    Ising2DLambda.NecSuf.KacWard.smoothedCyclicTotalTurning,
    smoothedExitEdge, Ising2DLambda.NecSuf.KacWard.smoothedSuccessorEdge,
    closedWalkSuccessor_from_necSuf]

end Ising2DLambda.KacWard
