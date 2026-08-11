/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.AlgebraicEigenvalue.QbarRepeatedSumNeZero
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarRepeatedSumNeZero

namespace Ising2DLambda.AlgebraicEigenvalue

theorem qbarRepeatedSumNeZero_from_necSuf {a : Qbar} (ha : a ≠ 0)
    (n : ℕ) (hn : 1 ≤ n) :
    (∑ _i ∈ Finset.range n, a) ≠ 0 :=
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.repeated_sum_ne_zero_necSuf
    0
    (fun u b => u * b)
    (fun b m => ∑ _i ∈ Finset.range m, b)
    (fun m => ∑ _i ∈ Finset.range m, (1 : Qbar))
    qbarRepeatedSumFactorization
    qbarUnitSumNeZero
    (fun hu hprod => qbarNoZeroDivisors hu hprod)
    ha n hn

end Ising2DLambda.AlgebraicEigenvalue
