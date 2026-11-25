/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.ClosedWalkPasses
import Ising2DLambda.NecSuf.KacWard.ClosedWalkPasses

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

theorem closedWalkSuccessor_from_necSuf {m : ℕ} (k : Fin (m + 1)) :
    closedWalkSuccessor k = Ising2DLambda.NecSuf.KacWard.cyclicSuccessor k := rfl

theorem closedWalkPass_from_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (k : Fin (m + 1)) :
    closedWalkPass γ hγ k = Ising2DLambda.NecSuf.KacWard.cyclicPass γ k := rfl

theorem closedWalkPassVertex_from_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (k : Fin (m + 1)) :
    closedWalkPassVertex γ hγ k =
      Ising2DLambda.NecSuf.KacWard.cyclicPassVertex γ orientedTarget k := rfl

end Ising2DLambda.KacWard
