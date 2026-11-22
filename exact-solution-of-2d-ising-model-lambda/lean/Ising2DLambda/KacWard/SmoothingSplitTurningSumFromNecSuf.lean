/-
「二本の閉歩道の循環総回転数の和は元の循環総回転数に等しい」の具体版が、
必要十分版 `interval_split_sum_necSuf`（加法可換モノイドの値の区間分割）の特殊化として得られることの記録。
各項を平滑化後の出辺の項へ書き換える段は具体版と同じで、区間の合併だけを必要十分版で行う。
-/
import Ising2DLambda.KacWard.SmoothingSplitTurningSum
import Ising2DLambda.NecSuf.KacWard.SmoothingSplitTurningSum

namespace Ising2DLambda.KacWard

theorem smoothing_split_turning_sum_from_necSuf {E : Type} (τ : E → E → ℤ)
    (edge : ℕ → E) (m k l : ℕ) (σ ν : ℕ → ℕ)
    (hσ : ∀ r, σ r = if r = m then 1 else r + 1)
    (hνk : ν k = σ l) (hνl : ν l = σ k)
    (hother : ∀ r, r ≠ k → r ≠ l → ν r = σ r)
    (hkl : k < l) (hlm : l ≤ m) :
    (∑ r ∈ Finset.Ioc k l, τ (edge r) (edge (if r = l then k + 1 else r + 1)))
      + ((∑ r ∈ Finset.Ioc l m, τ (edge r) (edge (if r = m then 1 else r + 1)))
        + ∑ r ∈ Finset.Ioc 0 k,
            τ (edge r) (edge (if r = k then (if l = m then 1 else l + 1) else r + 1)))
    = ∑ r ∈ Finset.Ioc 0 m, τ (edge r) (edge (ν r)) := by
  have hA : ∀ r ∈ Finset.Ioc k l,
      τ (edge r) (edge (if r = l then k + 1 else r + 1)) = τ (edge r) (edge (ν r)) := by
    intro r hr
    rw [Finset.mem_Ioc] at hr
    by_cases hrl : r = l
    · subst hrl
      have hkm : k ≠ m := by omega
      rw [if_pos rfl, hνl, hσ k, if_neg hkm]
    · have hrk : r ≠ k := by omega
      have hrm : r ≠ m := by omega
      rw [if_neg hrl, hother r hrk hrl, hσ r, if_neg hrm]
  have hB1 : ∀ r ∈ Finset.Ioc l m,
      τ (edge r) (edge (if r = m then 1 else r + 1)) = τ (edge r) (edge (ν r)) := by
    intro r hr
    rw [Finset.mem_Ioc] at hr
    have hrk : r ≠ k := by omega
    have hrl : r ≠ l := by omega
    rw [hother r hrk hrl, hσ r]
  have hB2 : ∀ r ∈ Finset.Ioc 0 k,
      τ (edge r) (edge (if r = k then (if l = m then 1 else l + 1) else r + 1))
        = τ (edge r) (edge (ν r)) := by
    intro r hr
    rw [Finset.mem_Ioc] at hr
    by_cases hrk : r = k
    · subst hrk
      rw [if_pos rfl, hνk, hσ l]
    · have hrl : r ≠ l := by omega
      have hrm : r ≠ m := by omega
      rw [if_neg hrk, hother r hrk hrl, hσ r, if_neg hrm]
  rw [Finset.sum_congr rfl hA, Finset.sum_congr rfl hB1, Finset.sum_congr rfl hB2]
  exact Ising2DLambda.NecSuf.KacWard.interval_split_sum_necSuf m k l (le_of_lt hkl) hlm
    (fun r => τ (edge r) (edge (ν r)))

end Ising2DLambda.KacWard
