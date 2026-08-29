/-
「横断数は頂点ごとの横断数の和である」（`claim_crossing_number_vertex_decomposition`）の必要十分版。

人手証明が使うのは二つの準備だけである。第一に、各元の値（横断対の頂点）が値の有限集合に
属すること（被覆）。第二に、一つの元の値はただ一つに定まるので、値ごとのファイバーが
互いに交わらないこと。横断・閉歩道・格子の構造は使わない。

  使っている性質      なぜ削れないか
  `DecidableEq α`     ファイバーの合併 `biUnion` を有限集合として作るため。
  `DecidableEq V`     ファイバー `t.filter (f · = v)` の述語の決定可能性のため。
  被覆 `hcover`       これが無いと合併が `t` 全体に届かず、第二の等号が成り立たない。

住処: ここに ℝ / ℂ は現れない（数え上げは ℕ）。
-/
import Mathlib.Data.Finset.Card
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace Ising2DLambda.NecSuf.KacWard

/-- 有限集合 `t` の元の個数は、写像 `f` の値ごとのファイバーの個数の和である。
値の有限集合 `vs` が `t` 上の `f` の値をすべて含むことだけを仮定する。
人手証明と同じ二段（被覆・互いに素）で示す。 -/
theorem card_eq_sum_fiber_card_necSuf {α V : Type} [DecidableEq α] [DecidableEq V]
    (t : Finset α) (f : α → V) (vs : Finset V)
    (hcover : ∀ x ∈ t, f x ∈ vs) :
    t.card = ∑ v ∈ vs, (t.filter fun x => f x = v).card := by
  -- 第一の準備（被覆）: ファイバーの合併は t 全体である
  have hunion : vs.biUnion (fun v => t.filter fun x => f x = v) = t := by
    ext x
    simp only [Finset.mem_biUnion, Finset.mem_filter]
    constructor
    · rintro ⟨v, _, hx, _⟩
      exact hx
    · intro hx
      exact ⟨f x, hcover x hx, hx, rfl⟩
  -- 第二の準備（互いに素）: 一つの元の値はただ一つに定まる
  have hdisj : ∀ v ∈ vs, ∀ w ∈ vs, v ≠ w →
      Disjoint (t.filter fun x => f x = v) (t.filter fun x => f x = w) := by
    intro v _ w _ hvw
    refine Finset.disjoint_left.mpr ?_
    intro x hxv hxw
    exact hvw ((Finset.mem_filter.mp hxv).2.symm.trans (Finset.mem_filter.mp hxw).2)
  -- 互いに交わらない有限集合の合併の個数は個数の和
  calc t.card
      = (vs.biUnion fun v => t.filter fun x => f x = v).card := by rw [hunion]
    _ = ∑ v ∈ vs, (t.filter fun x => f x = v).card := Finset.card_biUnion hdisj

end Ising2DLambda.NecSuf.KacWard
