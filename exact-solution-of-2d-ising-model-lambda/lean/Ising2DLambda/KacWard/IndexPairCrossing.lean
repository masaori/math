import Ising2DLambda.KacWard.ClosedWalkPasses
import Ising2DLambda.KacWard.TransverseCrossing

namespace Ising2DLambda.KacWard

/-- `def_index_pair_crossing` for two passes of an actual closed nonbacktracking walk. -/
def indexPairCrossing {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (_hγ : closedNonbacktrackingWalk γ) (k l : Fin (m + 1)) : Prop :=
  k ≠ l ∧ edgeTransverseCrossing
    (γ k) (γ (closedWalkSuccessor k))
    (γ l) (γ (closedWalkSuccessor l))

end Ising2DLambda.KacWard
