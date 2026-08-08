/-
主張「破れボンド数は行内の破れと行間の破れに分かれる」の必要十分版。

具体版（`Ising2DLambda.TransferMatrix.RowDecomposition`）の証明が実際に使っているのは
次だけである。格子の形・周期境界条件・スピンの値が `{+1,-1}` であること・端点写像・
`ZMod L` の加法は、どこにも使っていない。破れているかどうかを決める述語も一般のままでよい。

  使っている性質                      なぜ削れないか
  `Fintype ι`                         数える対象の全体 `univ` を取り、その上で和を作るため。
                                      無限集合では `card` も `∑` も意味をなさない。
  `Fintype α` / `Fintype β`           行番号・列番号それぞれについて和を取るため。
  `DecidablePred p`                   `Finset.filter` が定義できるため。
                                      「破れている」が判定できないと数え上げが始まらない。
  `(α × β) ⊕ (α × β) ≃ ι`             人手証明の Step 2（向きで 2 つに分ける）と
                                      Step 3（行ごとに分ける）と、1 行分の全単射
                                      （Step 4・Step 5 の前半）を 1 つにまとめたもの。
                                      これが無いと辺の集合を行ごとに束ねられない。

すなわちこの版が言っているのは、「数える対象の集合が 2 つの向きに分かれ、それぞれが
(行, 列) の 2 つ組で添字づけられているなら、どんな述語についても数え上げは
行ごとの数え上げの和に分かれる」ということである。Ising 模型であることは本質ではない。

証明手順は具体版と同じ Step 1–6 である（別の論法へ差し替えていない）。

住処: ここに ℝ / ℂ は現れない（数え上げは `ℕ`）。
-/
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Data.Fintype.BigOperators

namespace Ising2DLambda.NecSuf.TransferMatrix

open Finset

variable {ι α β : Type*} [Fintype ι] [Fintype α] [Fintype β]

/-- 人手証明の Step 1–6。数える対象が 2 つの向きに分かれ、それぞれが (行, 列) で
添字づけられていれば、数え上げは行ごとの数え上げの和に分かれる。 -/
theorem card_filter_eq_sum_add_sum (e : ((α × β) ⊕ (α × β)) ≃ ι) (p : ι → Prop)
    [DecidablePred p] :
    (univ.filter p).card
      = (∑ a : α, (univ.filter fun b : β => p (e (Sum.inl (a, b)))).card)
        + ∑ a : α, (univ.filter fun b : β => p (e (Sum.inr (a, b)))).card := by
  -- Step 1。個数を 0/1 の和として書く。
  rw [card_filter]
  -- Step 2 の前半。1 対 1 対応で添字を移す。
  rw [← Equiv.sum_comp e fun i => if p i then 1 else 0]
  -- Step 2 の後半。向きで 2 つに分ける。
  rw [Fintype.sum_sum_type]
  -- Step 3。それぞれを行ごとに分ける。
  rw [Fintype.sum_prod_type, Fintype.sum_prod_type]
  -- Step 4・Step 5・Step 6。1 行分の和を個数へ戻す。
  congr 1 <;> exact sum_congr rfl fun a _ => (card_filter _ _).symm

end Ising2DLambda.NecSuf.TransferMatrix
