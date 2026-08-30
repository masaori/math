/-
「台の辺が相異なる閉歩道は接触点で二本の閉歩道に分かれる」の接続部分の具体版。
人手証明と同じく、元の接続と、前段で非後退と示した交換後の二接続を二点交換後の
接続族へまとめ、二つの添字区間の内部・継ぎ目・閉じる接続を順に得る。
-/
import Ising2DLambda.NecSuf.KacWard.ContactSplitConnections

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

theorem edgeSimpleContactSplitConnections {E : Type} (Next : E → E → Prop)
    (edge : ℕ → E) (m k l : ℕ) (σ ν : ℕ → ℕ)
    (hσ : ∀ r, σ r = if r = m then 1 else r + 1)
    (hνk : ν k = σ l) (hνl : ν l = σ k)
    (hother : ∀ r, r ≠ k → r ≠ l → ν r = σ r)
    (horiginal : ∀ r, r ≠ k → r ≠ l → Next (edge r) (edge (σ r)))
    (hswapK : Next (edge k) (edge (σ l)))
    (hswapL : Next (edge l) (edge (σ k)))
    (hkl : k < l) (hlm : l ≤ m) :
    (∀ r, k < r → r < l → Next (edge r) (edge (r + 1))) ∧
    Next (edge l) (edge (k + 1)) ∧
    (∀ r, l < r → r < m → Next (edge r) (edge (r + 1))) ∧
    (l < m → Next (edge m) (edge 1)) ∧
    (∀ r, 1 ≤ r → r < k → Next (edge r) (edge (r + 1))) ∧
    Next (edge k) (edge (if l = m then 1 else l + 1)) :=
  contactSplitConnections_necSuf Next edge m k l σ ν hσ hνk hνl hother
    horiginal hswapK hswapL hkl hlm

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem edgeSimpleContactSplitConnections_from_necSuf {E : Type} (Next : E → E → Prop)
    (edge : ℕ → E) (m k l : ℕ) (σ ν : ℕ → ℕ)
    (hσ : ∀ r, σ r = if r = m then 1 else r + 1)
    (hνk : ν k = σ l) (hνl : ν l = σ k)
    (hother : ∀ r, r ≠ k → r ≠ l → ν r = σ r)
    (horiginal : ∀ r, r ≠ k → r ≠ l → Next (edge r) (edge (σ r)))
    (hswapK : Next (edge k) (edge (σ l)))
    (hswapL : Next (edge l) (edge (σ k)))
    (hkl : k < l) (hlm : l ≤ m) :
    (∀ r, k < r → r < l → Next (edge r) (edge (r + 1))) ∧
    Next (edge l) (edge (k + 1)) ∧
    (∀ r, l < r → r < m → Next (edge r) (edge (r + 1))) ∧
    (l < m → Next (edge m) (edge 1)) ∧
    (∀ r, 1 ≤ r → r < k → Next (edge r) (edge (r + 1))) ∧
    Next (edge k) (edge (if l = m then 1 else l + 1)) :=
  edgeSimpleContactSplitConnections Next edge m k l σ ν hσ hνk hνl hother
    horiginal hswapK hswapL hkl hlm

end Ising2DLambda.KacWard
