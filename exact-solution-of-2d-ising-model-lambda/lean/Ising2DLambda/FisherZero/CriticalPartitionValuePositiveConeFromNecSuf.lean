/- 具体版の有限和の帰納法が必要十分版の特殊化であることを記録する。 -/
import Ising2DLambda.FisherZero.CriticalPartitionValuePositiveCone

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem criticalPartitionValue_mem_positiveCone_from_necSuf (L : ℕ) [NeZero L]
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2) :
    ∃ xi : QuadraticFieldElement s,
      (xi : Qbar) = qbarPolynomialEval (criticalPoint s : Qbar)
        (Ising2DLambda.PartitionPolynomial.partitionPolynomial L) ∧
        xi ∈ quadraticPositiveCone s :=
  criticalPartitionValue_mem_positiveCone L s hs

end Ising2DLambda.FisherZero
