/-
「接触点分割の循環総回転数のずれは、交換した二接続の回転数差に等しい」
（`claim_contact_split_turning_update`）の具体版。
人手証明と同じく、二本の閉歩道の回転数和を更新後の添字区間和へ戻し、
二点更新の有限和の差を読む。
-/
import Ising2DLambda.KacWard.SmoothingSplitTurningSum
import Ising2DLambda.NecSuf.KacWard.ContactSplitTurningUpdate

namespace Ising2DLambda.KacWard

theorem contact_split_turning_update {E : Type} (τ : E → E → ℤ)
    (edge : ℕ → E) (m k l : ℕ) (σ ν : ℕ → ℕ)
    (hσ : ∀ r, σ r = if r = m then 1 else r + 1)
    (hνk : ν k = σ l) (hνl : ν l = σ k)
    (hother : ∀ r, r ≠ k → r ≠ l → ν r = σ r)
    (hk : 0 < k) (hkl : k < l) (hlm : l ≤ m) :
    ((∑ r ∈ Finset.Ioc k l, τ (edge r) (edge (if r = l then k + 1 else r + 1)))
      + ((∑ r ∈ Finset.Ioc l m, τ (edge r) (edge (if r = m then 1 else r + 1)))
        + ∑ r ∈ Finset.Ioc 0 k,
            τ (edge r) (edge (if r = k then (if l = m then 1 else l + 1) else r + 1))))
      - ∑ r ∈ Finset.Ioc 0 m, τ (edge r) (edge (σ r)) =
    (τ (edge k) (edge (σ l)) + τ (edge l) (edge (σ k)))
      - (τ (edge k) (edge (σ k)) + τ (edge l) (edge (σ l))) := by
  rw [smoothing_split_turning_sum τ edge m k l σ ν hσ hνk hνl hother hkl hlm]
  have hkMem : k ∈ Finset.Ioc 0 m := by
    rw [Finset.mem_Ioc]
    omega
  have hlMem : l ∈ Finset.Ioc 0 m := by
    rw [Finset.mem_Ioc]
    omega
  let old : ℕ → ℤ := fun r => τ (edge r) (edge (σ r))
  let updated : ℕ → ℤ := fun r => τ (edge r) (edge (ν r))
  let rest := ((Finset.Ioc 0 m).erase k).erase l
  have hlErase : l ∈ (Finset.Ioc 0 m).erase k :=
    Finset.mem_erase.mpr ⟨Nat.ne_of_gt hkl, hlMem⟩
  have hrest : ∑ r ∈ rest, updated r = ∑ r ∈ rest, old r := by
    apply Finset.sum_congr rfl
    intro r hr
    have hrEraseL : r ∈ (Finset.Ioc 0 m).erase k :=
      Finset.mem_of_mem_erase hr
    exact congrArg (τ (edge r) ∘ edge) (hother r
      (Finset.ne_of_mem_erase hrEraseL) (Finset.ne_of_mem_erase hr))
  have hUpdated : ∑ r ∈ Finset.Ioc 0 m, updated r =
      (∑ r ∈ rest, updated r) + (updated k + updated l) := by
    rw [← Finset.sum_erase_add _ updated hkMem,
      ← Finset.sum_erase_add _ updated hlErase]
    abel
  have hOld : ∑ r ∈ Finset.Ioc 0 m, old r =
      (∑ r ∈ rest, old r) + (old k + old l) := by
    rw [← Finset.sum_erase_add _ old hkMem,
      ← Finset.sum_erase_add _ old hlErase]
    abel
  have hdiff : (∑ r ∈ Finset.Ioc 0 m, updated r) -
      (∑ r ∈ Finset.Ioc 0 m, old r) =
      (updated k + updated l) - (old k + old l) := by
    rw [hUpdated, hOld, hrest]
    abel
  simpa only [old, updated, hνk, hνl] using hdiff

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem contact_split_turning_update_from_necSuf {E : Type} (τ : E → E → ℤ)
    (edge : ℕ → E) (m k l : ℕ) (σ ν : ℕ → ℕ)
    (hσ : ∀ r, σ r = if r = m then 1 else r + 1)
    (hνk : ν k = σ l) (hνl : ν l = σ k)
    (hother : ∀ r, r ≠ k → r ≠ l → ν r = σ r)
    (hk : 0 < k) (hkl : k < l) (hlm : l ≤ m) :
    ((∑ r ∈ Finset.Ioc k l, τ (edge r) (edge (if r = l then k + 1 else r + 1)))
      + ((∑ r ∈ Finset.Ioc l m, τ (edge r) (edge (if r = m then 1 else r + 1)))
        + ∑ r ∈ Finset.Ioc 0 k,
            τ (edge r) (edge (if r = k then (if l = m then 1 else l + 1) else r + 1))))
      - ∑ r ∈ Finset.Ioc 0 m, τ (edge r) (edge (σ r)) =
    (τ (edge k) (edge (σ l)) + τ (edge l) (edge (σ k)))
      - (τ (edge k) (edge (σ k)) + τ (edge l) (edge (σ l))) := by
  rw [smoothing_split_turning_sum τ edge m k l σ ν hσ hνk hνl hother hkl hlm]
  have hkMem : k ∈ Finset.Ioc 0 m := by
    rw [Finset.mem_Ioc]
    omega
  have hlMem : l ∈ Finset.Ioc 0 m := by
    rw [Finset.mem_Ioc]
    omega
  have hdiff := Ising2DLambda.NecSuf.KacWard.two_point_sum_difference_necSuf
    (fun r => τ (edge r) (edge (σ r))) (fun r => τ (edge r) (edge (ν r)))
    m k l hkMem hlMem (Nat.ne_of_lt hkl) (fun r _ hrk hrl => by rw [hother r hrk hrl])
  simpa only [hνk, hνl] using hdiff

end Ising2DLambda.KacWard
