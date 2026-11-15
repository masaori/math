import Ising2DLambda.KacWard.SignedEvenSubgraphDualityPolynomiality
import Ising2DLambda.NecSuf.KacWard.SignedEvenSubgraphDualityPolynomiality

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- The concrete coefficient expression is the specialization of the generic one to `Qbar`. -/
theorem dualityDenominatorCleared_eval_from_necSuf (n : ℕ) (p : QbarPoly)
    (hn : p.natDegree ≤ n) (x : Qbar) (hx : 1 + x ≠ 0) :
    (dualityDenominatorCleared n p).eval x =
      (1 + x) ^ n * p.eval ((1 - x) / (1 + x)) := by
  change (Ising2DLambda.NecSuf.KacWard.denominatorCleared n p).eval x = _
  exact Ising2DLambda.NecSuf.KacWard.eval_denominatorCleared n p hn x hx

end Ising2DLambda.KacWard
