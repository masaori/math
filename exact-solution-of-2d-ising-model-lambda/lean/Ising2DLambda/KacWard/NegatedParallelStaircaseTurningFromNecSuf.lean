/- 符号反転階段の必要十分版を、本文の整数格子と回転表へ特殊化する。 -/
import Ising2DLambda.KacWard.NegatedParallelStaircaseTurning

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

theorem negatedParallelStaircase_turning_zero_from_necSuf (L : ℕ) (wh wv : ℤ)
    (hn : 0 < L * wh.natAbs + L * wv.natAbs) :
    cyclicAdjacentSum (fun u v => turnValue (latticeTurnOfSteps u v))
      (L * wh.natAbs + L * wv.natAbs) (negatedParallelStaircaseStep L wh wv) = 0 := by
  rw [negatedParallelStaircase_turnValue_sum_eq L wh wv hn]
  have hsteps : negatedParallelStaircaseStep L wh wv =
      fun s => -(windingParallelStaircase L wh wv (s + 1) -
        windingParallelStaircase L wh wv s) :=
    funext (negatedParallelStaircaseStep_difference L wh wv)
  rw [hsteps]
  unfold windingParallelStaircase orderedTwoPhaseStaircase
  by_cases horder : 0 < wh * wv
  · simp only [if_pos horder]
    exact negatedTwoPhase_cyclicAdjacentSum_zero_necSuf latticeStepTurning _ _ _ _
      (latticeStepTurning_self _) (latticeStepTurning_self _)
      (latticeStepTurning_reverse_cancel _ _)
  · simp only [if_neg horder]
    rw [Nat.add_comm (L * wh.natAbs) (L * wv.natAbs)]
    exact negatedTwoPhase_cyclicAdjacentSum_zero_necSuf latticeStepTurning _ _ _ _
      (latticeStepTurning_self _) (latticeStepTurning_self _)
      (latticeStepTurning_reverse_cancel _ _)

end Ising2DLambda.KacWard
