import Ising2DLambda.KacWard.ClosedNonbacktrackingWalk
import Ising2DLambda.KacWard.StepTurning
import Ising2DLambda.NecSuf.KacWard.EdgeSequenceTotalTurning

open scoped BigOperators

namespace Ising2DLambda.KacWard

/-- `def_total_turning`。実際の向き付き辺列の隣接二辺の回転数を足す。 -/
def edgeSequenceTotalTurning {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) : ℤ :=
  ∑ k : Fin m, stepTurning (γ (Fin.castSucc k)) (γ (Fin.succ k))

theorem edgeSequenceTotalTurning_eq {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) :
    edgeSequenceTotalTurning γ =
      ∑ k : Fin m, stepTurning (γ (Fin.castSucc k)) (γ (Fin.succ k)) := rfl

/-- 具体的な向き付き辺と回転数を必要十分版へ代入する。 -/
theorem edgeSequenceTotalTurning_from_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) :
    edgeSequenceTotalTurning γ =
      Ising2DLambda.NecSuf.KacWard.edgeSequenceTotalTurning stepTurning γ := rfl

end Ising2DLambda.KacWard
