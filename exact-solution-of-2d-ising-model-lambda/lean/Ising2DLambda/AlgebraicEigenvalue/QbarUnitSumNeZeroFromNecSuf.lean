/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.AlgebraicEigenvalue.QbarUnitSumEqRational
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarUnitSumNeZero

namespace Ising2DLambda.AlgebraicEigenvalue

theorem qbarUnitSumNeZero_from_necSuf (n : ℕ) (hn : 1 ≤ n) :
    (∑ _i ∈ Finset.range n, (1 : Qbar)) ≠ 0 :=
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.unit_sum_ne_zero_necSuf
    0
    (fun n => ∑ _i ∈ Finset.range n, (1 : Qbar))
    (fun n => algebraMap ℚ Qbar (n : ℚ))
    qbarUnitSumEqRational
    (fun n hn => by
      exact (map_ne_zero (algebraMap ℚ Qbar)).2 (by
        exact_mod_cast (Nat.ne_of_gt hn)))
    n hn

end Ising2DLambda.AlgebraicEigenvalue
