/-
「自由エネルギー密度の下からの評価」の必要十分版。

格子を除き、有限和の選んだ一項の指数が零であること、正の元の冪、
一で零になる狭義単調写像、非負の倍率だけを残す。
-/
import Mathlib.Data.Real.Basic
import Ising2DLambda.NecSuf.ThermodynamicLimit.PartitionValuePositive

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

open Finset

/-- 選んだ指数零の項で有限和を一以上に評価し、単調写像と非負倍率を適用する。 -/
theorem scaled_monotone_sum_nonnegative_necSuf
    {ι : Type*} [Fintype ι] [DecidableEq ι]
    (chosen : ι) (exponent : ι → ℕ) (hchosen : exponent chosen = 0)
    {t : ℝ} (ht : 0 < t)
    (ell : {x : ℝ // 0 < x} → ℝ)
    (hellOne : ell ⟨1, zero_lt_one⟩ = 0)
    (hellStrictMono : ∀ u v, u.1 < v.1 → ell u < ell v)
    {scale : ℝ} (hscale : 0 ≤ scale) :
    0 ≤ scale * ell ⟨∑ i : ι, t ^ exponent i,
      sum_pow_pos_by_separating_term_necSuf chosen exponent ht⟩ := by
  have hmem : chosen ∈ (univ : Finset ι) := mem_univ chosen
  have hrest : 0 ≤ ∑ i ∈ (univ : Finset ι).erase chosen, t ^ exponent i := by
    exact sum_nonneg fun i _ => (pow_pos_by_induction ht _).le
  have hsum : 1 ≤ ∑ i : ι, t ^ exponent i := by
    calc
      1 = t ^ exponent chosen := by rw [hchosen, pow_zero]
      _ ≤ t ^ exponent chosen + ∑ i ∈ (univ : Finset ι).erase chosen, t ^ exponent i :=
        le_add_of_nonneg_right hrest
      _ = ∑ i : ι, t ^ exponent i := by rw [add_comm, sum_erase_add _ _ hmem]
  let sumPositive : {x : ℝ // 0 < x} :=
    ⟨∑ i : ι, t ^ exponent i,
      sum_pow_pos_by_separating_term_necSuf chosen exponent ht⟩
  have hell : 0 ≤ ell sumPositive := by
    have hmono : ell ⟨1, zero_lt_one⟩ ≤ ell sumPositive := by
      rcases hsum.eq_or_lt with heq | hlt
      · exact le_of_eq (congrArg ell (Subtype.ext heq))
      · exact (hellStrictMono ⟨1, zero_lt_one⟩ sumPositive hlt).le
    calc
      0 = ell ⟨1, zero_lt_one⟩ := hellOne.symm
      _ ≤ ell sumPositive := hmono
  exact mul_nonneg hscale hell

end Ising2DLambda.NecSuf.ThermodynamicLimit
