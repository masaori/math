import Mathlib.Data.Finset.Prod
import Mathlib.Data.Fintype.Basic
import Ising2DLambda.KacWard.IndexPairCrossing
import Ising2DLambda.NecSuf.KacWard.ClosedWalkCrossingNumber

namespace Ising2DLambda.KacWard

/-- `def_closed_walk_crossing_number` for an actual closed nonbacktracking walk. -/
noncomputable def closedWalkCrossingNumber {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) : ℕ := by
  classical
  exact ((Finset.univ ×ˢ Finset.univ).filter fun p : Fin (m + 1) × Fin (m + 1) =>
    p.1 < p.2 ∧ indexPairCrossing γ hγ p.1 p.2).card

theorem closedWalkCrossingNumber_from_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) :
    closedWalkCrossingNumber γ hγ =
      Ising2DLambda.NecSuf.KacWard.closedWalkCrossingNumber edgeTransverseCrossing γ := by
  rfl

end Ising2DLambda.KacWard
