/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.CyclicTotalTurning
import Ising2DLambda.NecSuf.KacWard.CyclicTotalTurning

namespace Ising2DLambda.KacWard

/-- 具体的な閉歩道と一歩の回転数を必要十分版へ代入する。 -/
theorem cyclicTotalTurning_from_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) :
    cyclicTotalTurning γ hγ =
      Ising2DLambda.NecSuf.KacWard.cyclicTotalTurning stepTurning γ := rfl

end Ising2DLambda.KacWard
