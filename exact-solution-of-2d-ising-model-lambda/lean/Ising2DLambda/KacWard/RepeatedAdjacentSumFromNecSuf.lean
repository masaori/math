/- 必要十分版を整数ベクトルの有限列と整数の回転表へ特殊化する。 -/
import Ising2DLambda.KacWard.RepeatedAdjacentSum

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

theorem latticeInternalTurning_repeat_difference_from_necSuf
    {n : ℕ} (u : Fin n → ℤ × ℤ) (c : ℕ) (hn : 0 < n) (hc : 0 < c) :
    internalAdjacentSum latticeStepTurning ((c + 1) * n) (repeatedLatticeWord u) -
        internalAdjacentSum latticeStepTurning (c * n) (repeatedLatticeWord u) =
      internalAdjacentSum latticeStepTurning n (extendLatticeWord u) +
        latticeStepTurning (extendLatticeWord u (n - 1)) (extendLatticeWord u 0) := by
  exact internalAdjacentSum_repeat_difference_necSuf latticeStepTurning
    (extendLatticeWord u) n c hn hc

end Ising2DLambda.KacWard
