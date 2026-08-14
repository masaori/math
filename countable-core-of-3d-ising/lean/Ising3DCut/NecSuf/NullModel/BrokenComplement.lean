/-
「奇数側だけ反転すると破れ数は補数になる」の必要十分版。

具体版の証明で使うのは、辺の全体が有限であることと、二つの条件が各辺で
互いの否定になっていることだけである。条件が「配位の両端の値の不一致」であること、
写像が奇数側の符号反転であること、値が整数 ±1 であることは使わない。

  使っている性質                     なぜ削れないか
  `Fintype ι`（辺の全体が有限）       個数を数えるため。無限では #E − m が書けない。
  `DecidableEq ι`                    補集合（`Finset` の差）を作るため。
  `DecidablePred P` / `DecidablePred Q`  条件を満たす辺を有限集合として集める（filter）ため。
  `∀ e, Q e ↔ ¬ P e`                 変換後の集合が補集合に一致することの中身。

証明手順は具体版と同じ（集合の等式を要素ごとに示してから、
部分集合の補集合の元の個数 `Finset.card_sdiff` を当てる）。

住処: 有限型と有限集合のみ。ℝ / ℂ は現れない。
-/
import Mathlib.Data.Fintype.Card

namespace Ising3DCut.NecSuf.NullModel

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- 各点で互いの否定になる二条件について、一方を満たす元の個数は他方の補数になる。 -/
theorem card_filter_of_iff_not (P Q : ι → Prop)
    [DecidablePred P] [DecidablePred Q] (h : ∀ e, Q e ↔ ¬ P e) :
    (Finset.univ.filter Q).card = Fintype.card ι - (Finset.univ.filter P).card := by
  have hset : Finset.univ.filter Q = Finset.univ \ Finset.univ.filter P := by
    ext e
    simp [h e]
  rw [hset, Finset.card_sdiff, Finset.inter_univ, Finset.card_univ]

end Ising3DCut.NecSuf.NullModel
