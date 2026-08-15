/-
「開境界長方形の値は 1 以上である」の必要十分版。

格子・配位・破れボンド数・実数を外し、有限添字型から選んだ一項の指数が零であること、
正の元の冪が非負であること、残りの有限和が非負であることだけを残す。
証明手順は具体版と同じ（選んだ一項を分離し、指数零で 1 に等しいことを使う）。
-/
import Ising2DLambda.NecSuf.ThermodynamicLimit.PartitionValuePositive

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

open Finset

/-- 指数が零の一項を分離して、正の元の冪の有限和を 1 で下から評価する。
`K` に要るのは半環と狭義順序環の性質（冪の正値性と加法の単調性）だけである。 -/
theorem one_le_sum_pow_by_separating_zero_exponent_term_necSuf
    {ι : Type*} [Fintype ι] [DecidableEq ι]
    {K : Type*} [Semiring K] [PartialOrder K] [IsStrictOrderedRing K]
    (chosen : ι) (exponent : ι → ℕ) (hchosen : exponent chosen = 0)
    {t : K} (ht : 0 < t) :
    1 ≤ ∑ i : ι, t ^ exponent i := by
  have hmem : chosen ∈ (univ : Finset ι) := mem_univ chosen
  have hrest : 0 ≤ ∑ i ∈ (univ : Finset ι).erase chosen, t ^ exponent i :=
    sum_nonneg fun i _ => (pow_pos_by_induction ht _).le
  calc
    1 = t ^ 0 := (pow_zero t).symm
    _ = t ^ exponent chosen := by rw [hchosen]
    _ ≤ t ^ exponent chosen + ∑ i ∈ (univ : Finset ι).erase chosen, t ^ exponent i :=
      le_add_of_nonneg_right hrest
    _ = ∑ i : ι, t ^ exponent i := by rw [add_comm, sum_erase_add _ _ hmem]

end Ising2DLambda.NecSuf.ThermodynamicLimit
