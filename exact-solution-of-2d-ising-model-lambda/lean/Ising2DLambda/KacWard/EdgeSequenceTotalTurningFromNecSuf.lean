/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.EdgeSequenceTotalTurning
import Ising2DLambda.NecSuf.KacWard.EdgeSequenceTotalTurning

open scoped BigOperators

namespace Ising2DLambda.KacWard

/-- 具体的な向き付き辺と回転数を必要十分版へ代入する。 -/
theorem edgeSequenceTotalTurning_from_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) :
    edgeSequenceTotalTurning γ =
      Ising2DLambda.NecSuf.KacWard.edgeSequenceTotalTurning stepTurning γ := rfl

end Ising2DLambda.KacWard
