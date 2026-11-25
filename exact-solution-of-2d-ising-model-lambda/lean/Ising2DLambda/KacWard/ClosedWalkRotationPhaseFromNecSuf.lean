/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.ClosedWalkRotationPhase
import Ising2DLambda.KacWard.TotalTurningFromNecSuf
import Ising2DLambda.NecSuf.KacWard.ClosedWalkRotationPhase

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem closed_walk_rotation_phase_from_necSuf {z : Qbar} (hz : z ≠ 0)
    (turns : List Turn) (closing : Turn) :
    (turns.map (phaseOfTurn z)).prod * phaseOfTurn z closing =
      z ^ ((turns.map turnValue).sum + turnValue closing) := by
  rw [phaseOfTurn_map_eq_necSuf, turnValue_map_eq_necSuf, phaseOfTurn_eq_necSuf,
    turnValue_eq_necSuf]
  exact Ising2DLambda.NecSuf.KacWard.phase_prod_mul_closing_eq_zpow_sum_add_necSuf hz
    (turns.map Turn.toNecSuf) closing.toNecSuf

end Ising2DLambda.KacWard
