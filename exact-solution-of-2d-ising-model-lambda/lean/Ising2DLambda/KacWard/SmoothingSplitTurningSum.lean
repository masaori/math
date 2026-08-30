/-
「二本の閉歩道の循環総回転数の和は元の循環総回転数に等しい」の具体版。
人手証明と同じく、γ_A の和（`(k,l]`。末尾 `l` だけ閉じる接続 `k+1` へ）と
γ_B の和（`(l,m]`・`(0,k]`。末尾 `m` は `1` へ、末尾 `k` は閉じる接続へ）を、
各項を平滑化後の出辺 `edge (ν r)` の項へ書き換えてから区間の分割で合併する。
-/
import Ising2DLambda.NecSuf.KacWard.SmoothingSplitTurningSum

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

theorem smoothing_split_turning_sum {E : Type} (τ : E → E → ℤ)
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
  -- 準備（γ_A）: 位置ごとの接続は平滑化後の出辺である（claim_smoothing_splits_closed_walk）。
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
  -- 準備（γ_B 前半 `(l,m]`）: `l < r` なので二点交換に当たらない。
  have hB1 : ∀ r ∈ Finset.Ioc l m,
      τ (edge r) (edge (if r = m then 1 else r + 1)) = τ (edge r) (edge (ν r)) := by
    intro r hr
    rw [Finset.mem_Ioc] at hr
    have hrk : r ≠ k := by omega
    have hrl : r ≠ l := by omega
    rw [hother r hrk hrl, hσ r]
  -- 準備（γ_B 後半 `(0,k]`）: 末尾 `k` だけ交換された行き先 `σ l` へ。
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
  exact interval_split_sum_necSuf m k l (le_of_lt hkl) hlm
    (fun r => τ (edge r) (edge (ν r)))

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
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
    = ∑ r ∈ Finset.Ioc 0 m, τ (edge r) (edge (ν r)) :=
  smoothing_split_turning_sum τ edge m k l σ ν hσ hνk hνl hother hkl hlm

end Ising2DLambda.KacWard
