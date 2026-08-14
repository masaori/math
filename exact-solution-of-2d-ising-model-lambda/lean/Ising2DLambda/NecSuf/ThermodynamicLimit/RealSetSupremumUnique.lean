/-
「上限の一意性」の必要十分版。

実数を外し、半順序だけを残す。証明手順は具体版と同じである
（相手が上界であることへ最小性を適用して両向きの ≤ を得て、≤ を < か = へ展開する）。

削れなかった仮定: `PartialOrder`。具体版の証明は ≤ から「< または =」を取り出す段
（`lt_or_eq_of_le`）を使い、これは反対称性を要する（`Preorder` では通らない）。
具体版が使った三分律の全体（線形順序）は要らず、半順序で足りる——これがこの検査の収穫である。
-/
import Mathlib.Order.Bounds.Basic

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

/-- 最小上界はただ一つである。 -/
theorem leastUpperBound_unique_necSuf
    {A : Type} [PartialOrder A]
    (S : Set A) (u₁ u₂ : A)
    (h₁ : IsLUB S u₁) (h₂ : IsLUB S u₂) :
    u₁ = u₂ := by
  -- 準備の第一: u₂ は上界なので、u₁ の最小性より u₁ ≤ u₂。
  have h12 : u₁ ≤ u₂ := h₁.2 h₂.1
  -- 準備の第二: u₁ と u₂ を入れ替えて同じ議論を行う。
  have h21 : u₂ ≤ u₁ := h₂.2 h₁.1
  -- 本体: ≤ の展開（u₁ < u₂ または u₁ = u₂）。
  rcases lt_or_eq_of_le h12 with hlt | heq
  · -- u₁ < u₂ の場合: u₂ ≤ u₁ の展開のどちらも順序の公理に反する。
    exfalso
    rcases lt_or_eq_of_le h21 with hlt' | heq'
    · -- u₂ < u₁ は u₁ < u₂ と両立しない。
      exact lt_asymm hlt hlt'
    · -- u₂ = u₁ は u₁ < u₂ と両立しない。
      exact absurd (heq' ▸ hlt) (lt_irrefl u₁)
  · -- u₁ = u₂ の場合: 主張を得る。
    exact heq

end Ising2DLambda.NecSuf.ThermodynamicLimit
