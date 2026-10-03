/- 二区間の相殺を、整数格子の回転数へ特殊化する。 -/
import Ising2DLambda.KacWard.ReversedParallelStaircaseTurning

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

theorem reversedParallelStaircase_turning_zero_from_necSuf (L : ℕ) (wh wv : ℤ)
    (hn : 0 < L * wh.natAbs + L * wv.natAbs) :
    cyclicAdjacentSum (fun u v => turnValue (latticeTurnOfSteps u v))
      (L * wh.natAbs + L * wv.natAbs) (reversedParallelStaircaseStep L wh wv) = 0 := by
  rw [reversedParallelStaircase_turnValue_sum_eq L wh wv hn]
  rw [reversedParallelStaircase_cyclicSum_eq L wh wv hn]
  split <;>
    exact twoBlock_cyclicAdjacentSum_zero_necSuf latticeStepTurning _ _ _ _
      (latticeStepTurning_self _) (latticeStepTurning_self _)
      (latticeStepTurning_reverse_cancel _ _)

end Ising2DLambda.KacWard
