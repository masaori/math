import Ising2DLambda.KacWard.SmoothingStraightVisitCount

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- `def_smoothed_successor_map` for an actual closed nonbacktracking walk. -/
def smoothedSuccessorMap {L m : ℕ}
    (_γ : Fin (m + 1) → OrientedEdge L)
    (_hγ : closedNonbacktrackingWalk _γ) (k l r : Fin (m + 1)) : Fin (m + 1) :=
  if r = k then closedWalkSuccessor l
  else if r = l then closedWalkSuccessor k
  else closedWalkSuccessor r

theorem smoothedExitEdge_eq_map {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (k l r : Fin (m + 1)) :
    smoothedExitEdge γ k l r = γ (smoothedSuccessorMap γ hγ k l r) := by
  by_cases hrk : r = k
  · simp [smoothedExitEdge, smoothedSuccessorMap, hrk]
  · by_cases hrl : r = l
    · by_cases hlk : l = k <;>
        simp [smoothedExitEdge, smoothedSuccessorMap, hrl, hlk]
    · simp [smoothedExitEdge, smoothedSuccessorMap, hrk, hrl]

end Ising2DLambda.KacWard
