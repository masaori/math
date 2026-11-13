/-
「横断の平滑化は二本の閉歩道に分ける」の具体版。
人手証明と同じ二本の並び `(k,l]` と `(l,m]・[1,k]` の、
内部の接続・継ぎ目・閉じる接続をそれぞれ明示する。
-/
import Ising2DLambda.NecSuf.KacWard.SmoothingClosedWalkSplit

namespace Ising2DLambda.KacWard

theorem smoothing_split_closed_connections {E : Type} (Next : E → E → Prop)
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
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_⟩
  · intro r hkr hrl
    have hrk : r ≠ k := by omega
    have hrl' : r ≠ l := by omega
    have h := hnext r
    rw [hother r hrk hrl', hσ r, if_neg (by omega)] at h
    exact h
  · have h := hnext l
    rw [hνl, hσ, if_neg (by omega)] at h
    exact h
  · intro r hlr hrm
    have hrk : r ≠ k := by omega
    have hrl : r ≠ l := by omega
    have h := hnext r
    rw [hother r hrk hrl, hσ r, if_neg (by omega)] at h
    exact h
  · intro hlm'
    have hmk : m ≠ k := by omega
    have hml : m ≠ l := by omega
    have h := hnext m
    rw [hother m hmk hml, hσ, if_pos rfl] at h
    exact h
  · intro r _h1r hrk
    have hrk' : r ≠ k := by omega
    have hrl : r ≠ l := by omega
    have h := hnext r
    rw [hother r hrk' hrl, hσ, if_neg (by omega)] at h
    exact h
  · have h := hnext k
    rw [hνk, hσ] at h
    exact h

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem smoothing_split_closed_connections_from_necSuf {E : Type} (Next : E → E → Prop)
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
    Next (edge k) (edge (if l = m then 1 else l + 1)) :=
  Ising2DLambda.NecSuf.KacWard.smoothing_split_closed_connections_necSuf Next edge m k l σ ν
    hσ hνk hνl hother hnext hkl hlm

end Ising2DLambda.KacWard
