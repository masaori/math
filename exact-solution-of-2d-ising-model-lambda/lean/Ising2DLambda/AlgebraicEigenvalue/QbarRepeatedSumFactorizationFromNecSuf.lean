/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnity
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarRepeatedSumFactorization

namespace Ising2DLambda.AlgebraicEigenvalue

theorem qbarRepeatedSumFactorization_from_necSuf (a : Qbar) : ∀ n : ℕ,
    (∑ _i ∈ Finset.range n, a) = (∑ _i ∈ Finset.range n, (1 : Qbar)) * a :=
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.repeated_sum_factorization_necSuf
    0 1 (· + ·) (· * ·) (fun x n => ∑ _i ∈ Finset.range n, x)
    (fun x => by rw [Finset.range_zero, Finset.sum_empty])
    (fun x n => by rw [Finset.sum_range_succ])
    (fun x => zero_mul x)
    (fun x => one_mul x)
    (fun x y z => (add_mul x y z).symm)
    a

end Ising2DLambda.AlgebraicEigenvalue
