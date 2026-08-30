/-
接触点で二つの出辺を交換した後、二つの添字区間が閉じた接続列になることの必要十分版。
格子・辺・有限性は使わず、元の接続と交換した二接続が関係 `Next` に属することだけを
二点交換後の接続族へまとめ、既存の区間分割を適用する。
-/
import Ising2DLambda.NecSuf.KacWard.SmoothingClosedWalkSplit

namespace Ising2DLambda.NecSuf.KacWard

theorem contactSplitConnections_necSuf {E : Type} (Next : E → E → Prop)
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
    Next (edge k) (edge (if l = m then 1 else l + 1)) := by
  have hnext : ∀ r, Next (edge r) (edge (ν r)) := by
    intro r
    by_cases hrk : r = k
    · subst r
      simpa [hνk] using hswapK
    · by_cases hrl : r = l
      · subst r
        simpa [hνl] using hswapL
      · simpa [hother r hrk hrl] using horiginal r hrk hrl
  exact smoothing_split_closed_connections_necSuf Next edge m k l σ ν
    hσ hνk hνl hother hnext hkl hlm

end Ising2DLambda.NecSuf.KacWard
