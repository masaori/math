/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.IndexPairCrossing
import Ising2DLambda.NecSuf.KacWard.IndexPairCrossing

namespace Ising2DLambda.KacWard

theorem indexPairCrossing_from_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (k l : Fin (m + 1)) :
    indexPairCrossing γ hγ k l ↔
      Ising2DLambda.NecSuf.KacWard.indexPairCrossing
        edgeTransverseCrossing γ k l := by
  rfl

end Ising2DLambda.KacWard
