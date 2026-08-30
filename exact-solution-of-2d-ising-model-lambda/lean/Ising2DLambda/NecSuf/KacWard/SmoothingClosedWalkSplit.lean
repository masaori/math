/-
横断の平滑化で生じる二つの添字区間を、二本の閉じた辺列として読むための必要十分版。
辺・格子・有限性は使わず、巡回後続の式、二点での行き先の交換、各接続が関係
`Next` に属することだけを使う。
-/
import Mathlib.Data.Nat.Basic

namespace Ising2DLambda.NecSuf.KacWard

/-- 巡回後続の二点交換は `(k,l]` とその補区間を、それぞれ閉じた接続列にする。 -/
theorem smoothing_split_closed_connections_necSuf {E : Type} (Next : E → E → Prop)
    (edge : ℕ → E) (m k l : ℕ) (σ ν : ℕ → ℕ)
    (hσ : ∀ r, σ r = if r = m then 1 else r + 1)
    (hνk : ν k = σ l) (hνl : ν l = σ k)
    (hother : ∀ r, r ≠ k → r ≠ l → ν r = σ r)
    (hnext : ∀ r, Next (edge r) (edge (ν r)))
    (hkl : k < l) (hlm : l ≤ m) :
    (∀ r, k < r → r < l → Next (edge r) (edge (r + 1))) ∧
    Next (edge l) (edge (k + 1)) ∧
    (∀ r, l < r → r < m → Next (edge r) (edge (r + 1))) ∧
    (l < m → Next (edge m) (edge 1)) ∧
    (∀ r, 1 ≤ r → r < k → Next (edge r) (edge (r + 1))) ∧
    Next (edge k) (edge (if l = m then 1 else l + 1)) := by
  constructor
  · intro r hkr hrl
    have hrk : r ≠ k := by omega
    have hrl' : r ≠ l := by omega
    have hrm : r ≠ m := by omega
    simpa [hother r hrk hrl', hσ r, if_neg hrm] using hnext r
  constructor
  · have hkm : k ≠ m := by omega
    simpa [hνl, hσ k, if_neg hkm] using hnext l
  constructor
  · intro r hlr hrm
    have hrk : r ≠ k := by omega
    have hrl' : r ≠ l := by omega
    have hrm' : r ≠ m := by omega
    simpa [hother r hrk hrl', hσ r, if_neg hrm'] using hnext r
  constructor
  · intro hlm'
    have hmk : m ≠ k := by omega
    have hml : m ≠ l := by omega
    simpa [hother m hmk hml, hσ m] using hnext m
  constructor
  · intro r hr1 hrk
    have hrk' : r ≠ k := by omega
    have hrl : r ≠ l := by omega
    have hrm : r ≠ m := by omega
    simpa [hother r hrk' hrl, hσ r, if_neg hrm] using hnext r
  · by_cases hlm' : l = m
    · have hkNext := hnext k
      rw [hνk, hσ l] at hkNext
      simpa [hlm'] using hkNext
    · have hkNext := hnext k
      rw [hνk, hσ l] at hkNext
      simpa [hlm'] using hkNext

end Ising2DLambda.NecSuf.KacWard
