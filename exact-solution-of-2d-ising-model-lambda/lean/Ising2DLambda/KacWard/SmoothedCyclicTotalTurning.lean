import Ising2DLambda.KacWard.SmoothingStraightVisitCount

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- `def_smoothed_cyclic_total_turning` for an actual closed nonbacktracking walk. -/
def smoothedCyclicTotalTurning {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (_hγ : closedNonbacktrackingWalk γ) (k l : Fin (m + 1)) : ℤ :=
  ∑ r : Fin (m + 1), stepTurning (γ r) (smoothedExitEdge γ k l r)

end Ising2DLambda.KacWard
