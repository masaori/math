/- 平行帰路の必要十分版を本文の整数格子階段へ特殊化する。 -/
import Ising2DLambda.KacWard.OneSidedParallelReturn
import Ising2DLambda.NecSuf.KacWard.OneSidedParallelReturn

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

theorem oneSidedParallelReturn_step_from_necSuf (L : ℕ) (wh wv : ℤ)
    (base : ℤ × ℤ) (c : ℕ) (hn : 0 < L * wh.natAbs + L * wv.natAbs) (s : ℕ) :
    oneSidedParallelReturn L wh wv base c (s + 1) -
        oneSidedParallelReturn L wh wv base c s =
      negatedParallelStaircaseStep L wh wv (s % (L * wh.natAbs + L * wv.natAbs)) := by
  rw [negatedParallelStaircaseStep_difference]
  exact translatedNegativeRepeat_step_necSuf
    (L * wh.natAbs + L * wv.natAbs) (windingParallelStaircase L wh wv)
    ((L : ℤ) * wv, (L : ℤ) * wh) base c hn
    (by rw [windingParallelStaircase_zero, windingParallelStaircase_end, sub_zero]) s

end Ising2DLambda.KacWard
