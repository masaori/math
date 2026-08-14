/-
「正の実数での分配多項式の値は正である」の必要十分版。

具体的な格子・配位・破れボンド数・実数を除き、証明が使う構造だけを残す。
有限添字型から一つの項を選べること、正の元の冪が正であること、残りの有限和が
非負であることが本質である。証明は具体版と同じく、選んだ一項を分離する。
-/
import Mathlib.Algebra.Order.BigOperators.Ring.Finset

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

open Finset

/-- 正の元の冪は正である。具体版と同じ帰納法。 -/
lemma pow_pos_by_induction {K : Type*} [Semiring K] [PartialOrder K] [IsStrictOrderedRing K]
    {t : K} (ht : 0 < t) : ∀ n : ℕ, 0 < t ^ n
  | 0 => by simpa using (show (0 : K) < 1 from zero_lt_one)
  | n + 1 => by
      rw [pow_succ]
      exact mul_pos (pow_pos_by_induction ht n) ht

/-- 正の元の冪の有限和は、選んだ一項を分離することで正になる。 -/
theorem sum_pow_pos_by_separating_term_necSuf
    {ι : Type*} [Fintype ι] [DecidableEq ι]
    {K : Type*} [Semiring K] [PartialOrder K] [IsStrictOrderedRing K]
    (chosen : ι) (f : ι → ℕ) {t : K} (ht : 0 < t) :
    0 < ∑ i : ι, t ^ f i := by
  have hchosen : chosen ∈ (univ : Finset ι) := mem_univ chosen
  have hrest : 0 ≤ ∑ i ∈ (univ : Finset ι).erase chosen, t ^ f i := by
    exact sum_nonneg fun i _ => (pow_pos_by_induction ht (f i)).le
  calc
    0 < t ^ f chosen := pow_pos_by_induction ht _
    _ ≤ t ^ f chosen + ∑ i ∈ (univ : Finset ι).erase chosen, t ^ f i :=
      le_add_of_nonneg_right hrest
    _ = ∑ i : ι, t ^ f i := by rw [add_comm, sum_erase_add _ _ hchosen]

end Ising2DLambda.NecSuf.ThermodynamicLimit
