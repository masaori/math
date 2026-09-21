/-
「格子頂点に接する四辺の通過回数の総和は頂点の通過数の二倍である」の必要十分版。

格子から切り離すと、必要なのは一周期の始点指示値と終点指示値が一致することだけである。
各辺の寄与を始点と終点へ一回ずつ分け、終点側の和を巡回的に一つずらす。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

open BigOperators

/-- 閉じた有限列では、各区間の両端の指示値の総和は訪問指示値の総和の二倍である。 -/
theorem closed_endpoint_incidence_double_necSuf
    (n : ℕ) (p : ℕ → Prop) [DecidablePred p]
    (hclosed : p n ↔ p 0) :
    (∑ k ∈ Finset.range n,
      ((if p k then 1 else 0) + (if p (k + 1) then 1 else 0))) =
      2 * ∑ k ∈ Finset.range n, (if p k then 1 else 0) := by
  let f : ℕ → ℕ := fun k => if p k then 1 else 0
  have hshift_all : ∀ m : ℕ,
      f 0 + ∑ k ∈ Finset.range m, f (k + 1) =
        (∑ k ∈ Finset.range m, f k) + f m := by
    intro m
    induction m with
    | zero => simp
    | succ n ih =>
        rw [Finset.sum_range_succ]
        calc
          f 0 + ((∑ k ∈ Finset.range n, f (k + 1)) + f (n + 1)) =
              (f 0 + ∑ k ∈ Finset.range n, f (k + 1)) + f (n + 1) := by
                omega
          _ = ((∑ k ∈ Finset.range n, f k) + f n) + f (n + 1) := by rw [ih]
          _ = (∑ k ∈ Finset.range (n + 1), f k) + f (n + 1) := by
                rw [Finset.sum_range_succ]
  have hshift := hshift_all n
  have hend : f n = f 0 := by
    unfold f
    by_cases hn : p n <;> by_cases h0 : p 0 <;> simp [hn, h0] at hclosed ⊢
  have hsame :
      ∑ k ∈ Finset.range n, f (k + 1) =
        ∑ k ∈ Finset.range n, f k := by
    rw [hend] at hshift
    omega
  change (∑ k ∈ Finset.range n, (f k + f (k + 1))) =
    2 * ∑ k ∈ Finset.range n, f k
  rw [Finset.sum_add_distrib, hsame]
  omega

end Ising2DLambda.NecSuf.KacWard
