/-
「正の実数での分配多項式の値の上からの評価」の必要十分版。

格子・配位・破れボンド数・実数を除き、有限和、底と指数に関する冪の単調性、
指数の一様上界、定数和の評価だけを残す。
-/
import Mathlib.Algebra.Order.BigOperators.Ring.Finset

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

open Finset

/-- 各項の底と指数を順に上げ、定数の有限和へまとめる。 -/
theorem sum_pow_le_uniform_bound_necSuf
    {ι K : Type*} [Fintype ι]
    [AddCommMonoid K] [Monoid K] [PartialOrder K] [IsOrderedAddMonoid K]
    (base upperBase : K) (exponent : ι → ℕ) (cap : ℕ)
    (basePowLe : ∀ k : ℕ, base ^ k ≤ upperBase ^ k)
    (exponentPowLe : ∀ i : ι, upperBase ^ exponent i ≤ upperBase ^ cap) :
    ∑ i : ι, base ^ exponent i ≤ ∑ _i : ι, upperBase ^ cap := by
  calc
    ∑ i : ι, base ^ exponent i ≤ ∑ i : ι, upperBase ^ exponent i := by
      exact sum_le_sum fun i _ => basePowLe (exponent i)
    _ ≤ ∑ _i : ι, upperBase ^ cap := by
      exact sum_le_sum fun i _ => exponentPowLe i

end Ising2DLambda.NecSuf.ThermodynamicLimit
