import Ising2DLambda.KacWard.UntwistedModeZeroCondition
import Ising2DLambda.NecSuf.KacWard.UntwistedModeZeroCondition

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

theorem untwistedMode_zero_condition_from_necSuf (L : ℕ) (q : Qbar) :
    ((1 + q ^ 2) ^ 2 - q * (1 - q ^ 2) * (1 + 1 + 1 + 1) = 0 ↔
      q ^ 2 + 2 * q - 1 = 0) := by
  have _ := L
  exact Ising2DLambda.NecSuf.KacWard.untwistedMode_zero_condition q

end Ising2DLambda.KacWard
