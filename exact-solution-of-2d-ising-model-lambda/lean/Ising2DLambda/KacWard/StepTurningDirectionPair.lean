import Ising2DLambda.KacWard.StepTurning
import Ising2DLambda.KacWard.PlaneProjectionCyclicTurning

namespace Ising2DLambda.KacWard

/-- 非後退の一歩の回転数（`def_step_turning`）を方向番号の対の回転数として読む定義の対応。
逆向きの方向の対 `b = a + 2` では両辺とも零なので、後続辺が反転でないことは使わない。 -/
theorem stepTurning_eq_directionPairTurning {L : ℕ} [NeZero L]
    (e f : OrientedEdge L) (hf : f ∈ nonbacktrackingSuccessors e) :
    stepTurning e f = directionPairTurning (directionNumber e) (directionNumber f) := by
  simp only [stepTurning, if_pos hf]
  generalize ha : directionNumber e = a at *
  generalize hb : directionNumber f = b at *
  fin_cases a <;> fin_cases b <;>
    simp_all [directionPairTurning] <;> decide

end Ising2DLambda.KacWard
