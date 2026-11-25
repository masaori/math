/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.TotalTurning
import Ising2DLambda.KacWard.ReversalRotationPhaseFromNecSuf
import Ising2DLambda.NecSuf.KacWard.TotalTurning

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- 具体版の一歩の回転数は、場合を送った先の必要十分版の回転数に等しい。 -/
theorem turnValue_eq_necSuf (turn : Turn) :
    turnValue turn = Ising2DLambda.NecSuf.KacWard.turnValue turn.toNecSuf := by
  cases turn <;> rfl

/-- 回転位相の列は、場合を送った先の必要十分版の回転位相の列に等しい。 -/
theorem phaseOfTurn_map_eq_necSuf (z : Qbar) (turns : List Turn) :
    turns.map (phaseOfTurn z) =
      (turns.map Turn.toNecSuf).map (Ising2DLambda.NecSuf.KacWard.phaseOfTurn z) := by
  rw [List.map_map]
  exact List.map_congr_left (fun turn _ => phaseOfTurn_eq_necSuf z turn)

/-- 回転数の列は、場合を送った先の必要十分版の回転数の列に等しい。 -/
theorem turnValue_map_eq_necSuf (turns : List Turn) :
    turns.map turnValue =
      (turns.map Turn.toNecSuf).map Ising2DLambda.NecSuf.KacWard.turnValue := by
  rw [List.map_map]
  exact List.map_congr_left (fun turn _ => turnValue_eq_necSuf turn)

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem phaseOfTurn_eq_zpow_from_necSuf (z : Qbar) (turn : Turn) :
    phaseOfTurn z turn = z ^ turnValue turn := by
  rw [phaseOfTurn_eq_necSuf, turnValue_eq_necSuf]
  exact Ising2DLambda.NecSuf.KacWard.phaseOfTurn_eq_zpow_necSuf z turn.toNecSuf

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem walk_rotation_phase_total_turning_from_necSuf {z : Qbar} (hz : z ≠ 0)
    (turns : List Turn) :
    (turns.map (phaseOfTurn z)).prod = z ^ (turns.map turnValue).sum := by
  rw [phaseOfTurn_map_eq_necSuf, turnValue_map_eq_necSuf]
  exact Ising2DLambda.NecSuf.KacWard.phase_prod_eq_zpow_sum_necSuf hz (turns.map Turn.toNecSuf)

end Ising2DLambda.KacWard
