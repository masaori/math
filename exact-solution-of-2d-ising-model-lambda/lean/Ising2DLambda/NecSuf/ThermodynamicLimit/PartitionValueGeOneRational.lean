/-
「正の有理点での分配多項式の値は 1 以上である」の必要十分版。

具体版が使うのは次だけである。有限添字型の中に指数が 0 の項が一つ選べること、
係数の住処が順序半環で `0 < t`（正の元の冪が正で、正の項の有限和が 0 以上）であること。
格子・配位・破れボンド数・有理数体は本質でない。証明手順は具体版と同じ
（`1 = t^0 = t^{f chosen} ≤ t^{f chosen} + Σ_{i≠chosen} t^{f i} = Σ_i t^{f i}`）。
-/
import Ising2DLambda.NecSuf.ThermodynamicLimit.PartitionValuePositive

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

open Finset

/-- 指数 0 の項を一つ選べれば、正の元の冪の有限和は 1 以上である。 -/
theorem one_le_sum_pow_of_exponent_zero_necSuf
    {ι : Type*} [Fintype ι] [DecidableEq ι]
    {K : Type*} [Semiring K] [PartialOrder K] [IsStrictOrderedRing K]
    (chosen : ι) (f : ι → ℕ) (hchosen : f chosen = 0) {t : K} (ht : 0 < t) :
    1 ≤ ∑ i : ι, t ^ f i := by
  have hmem : chosen ∈ (univ : Finset ι) := mem_univ chosen
  have hrest : 0 ≤ ∑ i ∈ (univ : Finset ι).erase chosen, t ^ f i :=
    sum_nonneg fun i _ => (pow_pos_by_induction ht (f i)).le
  calc
    1 = t ^ 0 := (pow_zero t).symm
    _ = t ^ f chosen := by rw [hchosen]
    _ ≤ t ^ f chosen + ∑ i ∈ (univ : Finset ι).erase chosen, t ^ f i :=
        le_add_of_nonneg_right hrest
    _ = ∑ i : ι, t ^ f i := by rw [add_comm, sum_erase_add _ _ hmem]

end Ising2DLambda.NecSuf.ThermodynamicLimit
