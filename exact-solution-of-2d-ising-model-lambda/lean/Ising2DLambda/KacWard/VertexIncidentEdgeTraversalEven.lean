/-
章「Onsager 閉形式への接続」の
「格子頂点に接する四辺の通過回数の総和は頂点の通過数の二倍である」
（`claim_vertex_incident_edge_traversal_even`）の具体版。

人手証明と同じく、各単位格子辺は始点と終点の両方へ一回ずつ寄与する。
四方向の場合分けで四辺の指示値を両端点の指示値へ書き換え、
閉性による巡回的な添字の付け替えは必要十分版と同じ手順で行う。
-/
import Ising2DLambda.KacWard.AdjacentCellsBoundaryParity
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

open BigOperators

/-- 一周期の持ち上げ点が格子点 `(a,b)` に一致する回数。 -/
def vertexVisitCount
    (n : ℕ) (row col : ℕ → ℤ) (a b : ℤ) : ℕ :=
  ∑ k ∈ Finset.range n, if row k = a ∧ col k = b then 1 else 0

/-- `claim_vertex_incident_edge_traversal_even` の具体版。 -/
theorem vertexIncidentEdgeTraversal_even
    (n : ℕ) (row col : ℕ → ℤ) (a b : ℤ)
    (hunit : IsUnitGridWalk n row col)
    (hclosedRow : row n = row 0) (hclosedCol : col n = col 0) :
    verticalEdgeTraversalCount n row col (a - 1) b +
        verticalEdgeTraversalCount n row col a b +
        horizontalEdgeTraversalCount n row col a (b - 1) +
        horizontalEdgeTraversalCount n row col a b =
      2 * vertexVisitCount n row col a b := by
  have hpoint : ∀ k < n,
      (if crossesRowLevel row (a - 1) k ∧ col k = b then 1 else 0) +
          (if crossesRowLevel row a k ∧ col k = b then 1 else 0) +
          (if crossesColLevel col (b - 1) k ∧ row k = a then 1 else 0) +
          (if crossesColLevel col b k ∧ row k = a then 1 else 0) =
        (if row k = a ∧ col k = b then 1 else 0) +
          (if row (k + 1) = a ∧ col (k + 1) = b then 1 else 0) := by
    intro k hk
    rcases hunit k hk with h | h | h | h <;>
      simp only [crossesRowLevel, crossesColLevel] <;>
      split_ifs <;> omega
  let f : ℕ → ℕ := fun k => if row k = a ∧ col k = b then 1 else 0
  have hshift_all : ∀ m : ℕ,
      f 0 + ∑ k ∈ Finset.range m, f (k + 1) =
        (∑ k ∈ Finset.range m, f k) + f m := by
    intro m
    induction m with
    | zero => simp
    | succ m ih =>
        rw [Finset.sum_range_succ]
        calc
          f 0 + ((∑ k ∈ Finset.range m, f (k + 1)) + f (m + 1)) =
              (f 0 + ∑ k ∈ Finset.range m, f (k + 1)) + f (m + 1) := by omega
          _ = ((∑ k ∈ Finset.range m, f k) + f m) + f (m + 1) := by rw [ih]
          _ = (∑ k ∈ Finset.range (m + 1), f k) + f (m + 1) := by
                rw [Finset.sum_range_succ]
  have hend : f n = f 0 := by
    simp [f, hclosedRow, hclosedCol]
  have hshift : ∑ k ∈ Finset.range n, f (k + 1) =
      ∑ k ∈ Finset.range n, f k := by
    have h := hshift_all n
    rw [hend] at h
    omega
  unfold verticalEdgeTraversalCount horizontalEdgeTraversalCount vertexVisitCount
  rw [← Finset.sum_add_distrib, ← Finset.sum_add_distrib,
    ← Finset.sum_add_distrib]
  calc
    _ = ∑ k ∈ Finset.range n,
        ((if row k = a ∧ col k = b then 1 else 0) +
          (if row (k + 1) = a ∧ col (k + 1) = b then 1 else 0)) := by
      apply Finset.sum_congr rfl
      intro k hk
      exact hpoint k (Finset.mem_range.mp hk)
    _ = 2 * ∑ k ∈ Finset.range n,
        (if row k = a ∧ col k = b then 1 else 0) := by
      change (∑ k ∈ Finset.range n, (f k + f (k + 1))) =
        2 * ∑ k ∈ Finset.range n, f k
      rw [Finset.sum_add_distrib, hshift]
      omega

end Ising2DLambda.KacWard
