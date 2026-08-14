/-
「定数配位は周期辺を破らない」の必要十分版。

具体版の証明で使う性質だけを残す。

  使っている性質            なぜ削れないか
  `Fintype α`               重みが `m` である元の個数を数えるため。
  `a : α` と `weight a = m`  数える集合が空でないことの証人。具体版では
                            定数配位と、その破れ数が 0 であることの計算にあたる。

証明手順は具体版と同じ（証人が水準集合に属することを示し、空でない有限型の
元の個数が 1 以上であることで結ぶ）。周期辺・端点写像・値 ±1 は仮定しない
——具体版の証明がそれらを使うのは証人を作る段だけであり、数える段では使わないからである。

住処: 任意の有限型と自然数のみ。ℝ / ℂ は現れない。
-/
import Ising3DCut.NecSuf.NullModel.MultiplicityPalindrome

namespace Ising3DCut.NecSuf.NullModel

variable {α : Type*} [Fintype α]

/-- 重み `m` の元がひとつでもあれば、重み `m` の水準集合の元の個数は 1 以上である。 -/
theorem one_le_card_fiber (weight : α → ℕ) (m : ℕ) (a : α) (ha : weight a = m) :
    1 ≤ Fintype.card (Fiber weight m) := by
  apply Nat.succ_le_of_lt
  apply Fintype.card_pos_iff.mpr
  exact ⟨⟨a, Finset.mem_filter.mpr ⟨Finset.mem_univ _, ha⟩⟩⟩

end Ising3DCut.NecSuf.NullModel
