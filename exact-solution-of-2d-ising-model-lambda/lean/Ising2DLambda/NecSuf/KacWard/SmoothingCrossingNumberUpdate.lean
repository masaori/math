/-
「平滑化後の横断数の全体更新」の必要十分版。
有限和の一つの項だけが変わるとき、局所更新式を全体の和へ運ぶ。
格子・閉歩道・横断の構造は使わない。
-/
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Data.Finset.Card
import Mathlib.Data.Fintype.Basic

namespace Ising2DLambda.NecSuf.KacWard

open scoped BigOperators

/-- 有限和の一つの項だけが変わるなら、その局所更新式は全体の和の更新式になる。 -/
theorem single_fiber_update_sum_necSuf {V : Type} [Fintype V] [DecidableEq V]
    (before after : V → ℕ) (v : V) (axisZero axisOne : ℕ)
    (hloc : before v + 1 = after v + axisZero + axisOne)
    (hother : ∀ w, w ≠ v → after w = before w) :
    (∑ w : V, before w) + 1 = (∑ w : V, after w) + axisZero + axisOne := by
  change Finset.univ.sum before + 1 = Finset.univ.sum after + axisZero + axisOne
  have hbefore : (Finset.univ.erase v).sum before + before v = Finset.univ.sum before :=
    Finset.sum_erase_add (s := Finset.univ) before (Finset.mem_univ v)
  have hafter : (Finset.univ.erase v).sum after + after v = Finset.univ.sum after :=
    Finset.sum_erase_add (s := Finset.univ) after (Finset.mem_univ v)
  have hrest : (Finset.univ.erase v).sum after =
      (Finset.univ.erase v).sum before := by
    apply Finset.sum_congr rfl
    intro w hw
    exact hother w (Finset.ne_of_mem_erase hw)
  rw [← hbefore, ← hafter, hrest]
  omega

end Ising2DLambda.NecSuf.KacWard
