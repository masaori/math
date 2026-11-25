/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.SmoothedSuccessorMap
import Ising2DLambda.NecSuf.KacWard.SmoothedSuccessorMap
import Ising2DLambda.KacWard.ClosedWalkPassesFromNecSuf

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

theorem smoothedSuccessorMap_from_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (k l r : Fin (m + 1)) :
    smoothedSuccessorMap γ hγ k l r =
      Ising2DLambda.NecSuf.KacWard.smoothedSuccessorMap k l r := by
  simp only [smoothedSuccessorMap,
    Ising2DLambda.NecSuf.KacWard.smoothedSuccessorMap,
    closedWalkSuccessor_from_necSuf]

end Ising2DLambda.KacWard
