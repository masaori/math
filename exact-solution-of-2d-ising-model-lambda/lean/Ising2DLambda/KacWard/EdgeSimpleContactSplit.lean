/-
「台の辺が相異なる閉歩道は接触点で二本の閉歩道に分かれる」の接続部分の具体版。
人手証明と同じく、元の接続と、前段で非後退と示した交換後の二接続を二点交換後の
接続族へまとめ、二つの添字区間の内部・継ぎ目・閉じる接続は、平滑化の主張
（`claim_smoothing_splits_closed_walk`）の具体版 `smoothing_split_closed_connections` から得る。
-/
import Ising2DLambda.KacWard.SmoothingClosedWalkSplit

namespace Ising2DLambda.KacWard

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
    Next (edge k) (edge (if l = m then 1 else l + 1)) := by
  -- 元の接続と交換した二接続を、二点交換後の接続族 `ν` へまとめる
  have hnext : ∀ r, Next (edge r) (edge (ν r)) := by
    intro r
    by_cases hrk : r = k
    · subst r
      simpa [hνk] using hswapK
    · by_cases hrl : r = l
      · subst r
        simpa [hνl] using hswapL
      · simpa [hother r hrk hrl] using horiginal r hrk hrl
  -- 残りは「横断の平滑化は二本の閉歩道に分ける」と同じ添字区間の論法
  -- （`claim_smoothing_splits_closed_walk` の具体版）
  exact smoothing_split_closed_connections Next edge m k l σ ν hσ hνk hνl hother hnext hkl hlm

end Ising2DLambda.KacWard
