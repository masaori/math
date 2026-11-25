/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.ContactPairCount
import Ising2DLambda.NecSuf.KacWard.ContactPairCount

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

theorem contactPairCount_from_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) :
    contactPairCount γ hγ =
      Ising2DLambda.NecSuf.KacWard.contactPairCount γ orientedTarget := by
  classical
  simp only [contactPairCount, Ising2DLambda.NecSuf.KacWard.contactPairCount]
  congr 1
  ext p
  simp

end Ising2DLambda.KacWard
