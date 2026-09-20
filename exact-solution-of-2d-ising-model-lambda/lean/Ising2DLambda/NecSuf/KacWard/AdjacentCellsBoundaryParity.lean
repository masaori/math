/-
「隣接セルの交差奇偶と共有辺の通過奇偶」の必要十分版。

横方向の等式に必要なのは、整数位置が `c` より右にあるという条件を
`c + 1` にある場合と、さらに右にある場合へ分ける有限和の分割だけである。
上下方向の合同式に必要なのは、境界を横切る項の総数が偶数であり、その総数が
下側・上側・共有辺の三つの個数の和へ分割されることだけである。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

open BigOperators

/-- 整数位置の右側条件を、次の位置とそのさらに右へ分割する。 -/
theorem integer_tail_sum_split_necSuf
    (n : ℕ) (active : ℕ → Prop) [DecidablePred active]
    (position : ℕ → ℤ) (c : ℤ) :
    (∑ k ∈ Finset.range n, if active k ∧ c < position k then 1 else 0) =
      (∑ k ∈ Finset.range n, if active k ∧ position k = c + 1 then 1 else 0) +
      (∑ k ∈ Finset.range n, if active k ∧ c + 1 < position k then 1 else 0) := by
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro k _
  by_cases ha : active k <;> by_cases heq : position k = c + 1 <;>
    by_cases hlt : c + 1 < position k <;> simp [ha, heq, hlt] <;> omega

/-- 偶数個の境界横断が三種類へ分割されるなら、最初の二種類の和と第三種類の奇偶は等しい。 -/
theorem boundary_three_part_parity_necSuf
    (lower upper shared total : ℕ)
    (hpartition : total = lower + upper + shared)
    (heven : Even total) :
    (lower + upper) % 2 = shared % 2 := by
  rcases heven with ⟨q, hq⟩
  omega

end Ising2DLambda.NecSuf.KacWard
