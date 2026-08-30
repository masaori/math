/-
「平滑化後の添字後続写像は二つの添字区間を渡らない」の具体版。
人手証明と同じく、添字は自然数、σ は巡回後続（σ(m)=1、他は +1）、
A は区間 {r | k < r ≤ l}。四つの閉包（A の内部・r=l・B の内部・r=k）を
自然数の順序の場合分けで示し、必要十分版へ渡す。
人手証明は r ∈ I_m = {1,…,m} に制限して述べるが、四つの閉包は
同じ場合分けで任意の自然数 r について成り立つので、ここでは全域で示す。
-/
import Ising2DLambda.NecSuf.KacWard.SmoothingIndexInterval
import Mathlib.Data.Nat.Basic

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 巡回後続の二点交換 ν は区間 (k, l] の帰属を保つ。 -/
theorem smoothing_interval_invariance (m k l : ℕ) (σ ν : ℕ → ℕ)
    (hσ : ∀ r, σ r = if r = m then 1 else r + 1)
    (hνk : ν k = σ l) (hνl : ν l = σ k)
    (hother : ∀ r, r ≠ k → r ≠ l → ν r = σ r)
    (hk1 : 1 ≤ k) (hkl : k < l) (hlm : l ≤ m) :
    ∀ r, (k < ν r ∧ ν r ≤ l) ↔ (k < r ∧ r ≤ l) := by
  apply swap_redirect_invariant_necSuf σ ν (fun r => k < r ∧ r ≤ l) k l
  -- k ∉ A（k < k は成り立たない）
  · omega
  -- l ∈ A（k < l ≤ l）
  · omega
  · exact hνk
  · exact hνl
  · exact hother
  -- A の内部の閉包: k < r < l ならば σ(r) = r + 1 で k < r + 1 ≤ l
  · intro r hr hrl
    rw [hσ r]
    split_ifs <;> omega
  -- r = l の行き先: σ(k) = k + 1 ∈ A（k < l ≤ m から k ≠ m）
  · rw [hσ k]
    split_ifs <;> omega
  -- r = k の行き先: σ(l) は l = m なら 1 ≤ k、l < m なら l + 1 > l で A に入らない
  · rw [hσ l]
    split_ifs <;> omega
  -- B の内部の閉包: r ∉ A、r ≠ k ならば σ(r) も A に入らない
  · intro r hr hrk
    rw [hσ r]
    split_ifs <;> omega

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem smoothing_interval_invariance_from_necSuf (m k l : ℕ) (σ ν : ℕ → ℕ)
    (hσ : ∀ r, σ r = if r = m then 1 else r + 1)
    (hνk : ν k = σ l) (hνl : ν l = σ k)
    (hother : ∀ r, r ≠ k → r ≠ l → ν r = σ r)
    (hk1 : 1 ≤ k) (hkl : k < l) (hlm : l ≤ m) :
    ∀ r, (k < ν r ∧ ν r ≤ l) ↔ (k < r ∧ r ≤ l) :=
  smoothing_interval_invariance m k l σ ν hσ hνk hνl hother hk1 hkl hlm

end Ising2DLambda.KacWard
