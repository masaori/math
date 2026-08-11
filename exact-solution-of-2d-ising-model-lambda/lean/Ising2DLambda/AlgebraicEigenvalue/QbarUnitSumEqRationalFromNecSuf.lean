/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnity
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarUnitSumEqRational

namespace Ising2DLambda.AlgebraicEigenvalue

theorem qbarUnitSumEqRational_from_necSuf : ∀ n : ℕ,
    (∑ _i ∈ Finset.range n, (1 : Qbar)) = algebraMap ℚ Qbar (n : ℚ) :=
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.unit_sum_eq_rational_necSuf
    0 1 (· + ·)
    (fun n => ∑ _i ∈ Finset.range n, (1 : Qbar))
    (fun n => algebraMap ℚ Qbar (n : ℚ))
    (by rw [Finset.range_zero, Finset.sum_empty])
    (fun n => by rw [Finset.sum_range_succ])
    (by rw [Nat.cast_zero, map_zero])
    (fun n => by rw [Nat.cast_add_one, map_add, map_one])

end Ising2DLambda.AlgebraicEigenvalue
