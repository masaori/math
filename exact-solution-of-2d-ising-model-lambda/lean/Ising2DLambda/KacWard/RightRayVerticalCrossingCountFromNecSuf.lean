/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.RightRayVerticalCrossingCount
import Ising2DLambda.NecSuf.KacWard.RightRayVerticalCrossingCount

namespace Ising2DLambda.KacWard

theorem rightRayVerticalCrossingCount_from_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (r c : ℤ) :
    rightRayVerticalCrossingCount γ hγ r c =
      Ising2DLambda.NecSuf.KacWard.rightRayVerticalCrossingCount m (planeLift γ) r c := rfl

end Ising2DLambda.KacWard
