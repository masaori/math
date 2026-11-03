import Ising2DLambda.KacWard.SmoothingStraightVisitCount
import Ising2DLambda.NecSuf.KacWard.SmoothedCyclicTotalTurning

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- `def_smoothed_cyclic_total_turning` for an actual closed nonbacktracking walk. -/
def smoothedCyclicTotalTurning {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (_hγ : closedNonbacktrackingWalk γ) (k l : Fin (m + 1)) : ℤ :=
  ∑ r : Fin (m + 1), stepTurning (γ r) (smoothedExitEdge γ k l r)

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
