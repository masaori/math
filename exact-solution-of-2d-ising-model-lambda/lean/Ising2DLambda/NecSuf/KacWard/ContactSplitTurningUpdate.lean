/-
「接触点分割の循環総回転数のずれは、交換した二接続の回転数差に等しい」
（`claim_contact_split_turning_update`）の必要十分版。

辺・閉歩道・回転数は使わない。有限和の二項だけを更新し、他の項が一致するなら、
二つの有限和の差は更新した二項の和の差に等しいことだけを残す。
-/
import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Tactic.Abel

namespace Ising2DLambda.NecSuf.KacWard

open scoped BigOperators

/-- 有限区間和の二項だけを更新したとき、全体の差は二項の和の差に等しい。 -/
theorem two_point_sum_difference_necSuf (old updated : ℕ → ℤ)
    (m k l : ℕ) (hk : k ∈ Finset.Ioc 0 m) (hl : l ∈ Finset.Ioc 0 m)
    (hkl : k ≠ l)
    (hother : ∀ r ∈ Finset.Ioc 0 m, r ≠ k → r ≠ l → updated r = old r) :
    (∑ r ∈ Finset.Ioc 0 m, updated r) - (∑ r ∈ Finset.Ioc 0 m, old r) =
      (updated k + updated l) - (old k + old l) := by
  let rest := (Finset.Ioc 0 m).erase k |>.erase l
  have hlErase : l ∈ (Finset.Ioc 0 m).erase k :=
    Finset.mem_erase.mpr ⟨Ne.symm hkl, hl⟩
  have hrest : ∑ r ∈ rest, updated r = ∑ r ∈ rest, old r := by
    apply Finset.sum_congr rfl
    intro r hr
    have hrEraseL : r ∈ (Finset.Ioc 0 m).erase k :=
      Finset.mem_of_mem_erase hr
    exact hother r (Finset.mem_of_mem_erase hrEraseL)
      (Finset.ne_of_mem_erase hrEraseL) (Finset.ne_of_mem_erase hr)
  have hUpdated : ∑ r ∈ Finset.Ioc 0 m, updated r =
      (∑ r ∈ rest, updated r) + (updated k + updated l) := by
    rw [← Finset.sum_erase_add _ updated hk, ← Finset.sum_erase_add _ updated hlErase]
    abel
  have hOld : ∑ r ∈ Finset.Ioc 0 m, old r =
      (∑ r ∈ rest, old r) + (old k + old l) := by
    rw [← Finset.sum_erase_add _ old hk, ← Finset.sum_erase_add _ old hlErase]
    abel
  rw [hUpdated, hOld, hrest]
  abel

end Ising2DLambda.NecSuf.KacWard
