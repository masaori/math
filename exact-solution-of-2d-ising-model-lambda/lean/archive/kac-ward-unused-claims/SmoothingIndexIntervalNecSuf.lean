/-
「平滑化後の添字後続写像は二つの添字区間を渡らない」の必要十分版。
二点 k, l で像を交換した写像について、交換先の帰属（σ(k) ∈ A、σ(l) ∉ A）と
残りの元の閉包だけから、帰属の同値が従う。
順序・有限性・全単射性・区間の形は使わない。

- 仮定 `hkA`（k ∉ A）は、逆向きで r ∈ A の余事象から r ≠ k を得るのに必要である。
- 仮定 `hlA`（l ∈ A）は、順向きの余事象から r ≠ l を得るのに必要である。
- 仮定 `hin`・`hk` が人手証明の「A から A へ」の二場合、
  仮定 `hout`・`hl` が「B から B へ」の二場合に対応する。
-/
import Mathlib.Logic.Basic
import Mathlib.Tactic.ByContra

namespace Ising2DLambda.NecSuf.KacWard

/-- 二点で像を交換した写像は、交換先の帰属と残りの閉包から集合の帰属を保つ。 -/
theorem swap_redirect_invariant_necSuf {ι : Type} (σ ν : ι → ι) (A : ι → Prop)
    (k l : ι) (hkA : ¬ A k) (hlA : A l)
    (hνk : ν k = σ l) (hνl : ν l = σ k)
    (hother : ∀ r, r ≠ k → r ≠ l → ν r = σ r)
    (hin : ∀ r, A r → r ≠ l → A (σ r)) (hk : A (σ k)) (hl : ¬ A (σ l))
    (hout : ∀ r, ¬ A r → r ≠ k → ¬ A (σ r)) :
    ∀ r, A (ν r) ↔ A r := by
  intro r
  constructor
  · -- 対偶: r ∉ A ならば ν r ∉ A
    intro hν
    by_contra hr
    rcases eq_or_ne r k with rfl | hrk
    · rw [hνk] at hν
      exact hl hν
    · have hrl : r ≠ l := fun h => hr (h ▸ hlA)
      rw [hother r hrk hrl] at hν
      exact hout r hr hrk hν
  · -- 順向き: r ∈ A ならば ν r ∈ A
    intro hr
    rcases eq_or_ne r l with rfl | hrl
    · rw [hνl]
      exact hk
    · have hrk : r ≠ k := fun h => hkA (h ▸ hr)
      rw [hother r hrk hrl]
      exact hin r hr hrl

end Ising2DLambda.NecSuf.KacWard
