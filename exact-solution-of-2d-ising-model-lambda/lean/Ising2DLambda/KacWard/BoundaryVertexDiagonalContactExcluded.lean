/-
章「Onsager 閉形式への接続」の
「持ち上げ点が相異なる閉路で頂点まわりの内側セルが対角の二セルだけになることは無い」
（`claim_boundary_vertex_diagonal_contact_excluded`）の具体版。

人手証明と同じく、持ち上げ点の相異性から各格子点の訪問回数が零か一であることを導く。
頂点を一回訪問する場合は四セルが二つの巡回弧を作ることを使い、訪問しない場合は
四辺の通過回数が零なので四セルの内外がすべて一致することを使う。
-/
import Ising2DLambda.KacWard.VertexSurroundingCellsParityArcs
import Ising2DLambda.NecSuf.KacWard.BoundaryVertexDiagonalContactExcluded
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- `claim_boundary_vertex_diagonal_contact_excluded` の具体版。 -/
theorem boundaryVertex_diagonalContactExcluded
    (n : ℕ) (row col : ℕ → ℤ) (a b : ℤ)
    (hclosedRow : row n = row 0) (hclosedCol : col n = col 0)
    (hunit : IsUnitGridWalk n row col)
    (hdistinct : ∀ k l, k < n → l < n →
      row k = row l → col k = col l → k = l)
    (hleft : verticalEdgeTraversalCount n row col (a - 1) b ≤ 1)
    (hright : verticalEdgeTraversalCount n row col a b ≤ 1)
    (hdown : horizontalEdgeTraversalCount n row col a (b - 1) ≤ 1)
    (hup : horizontalEdgeTraversalCount n row col a b ≤ 1) :
    DiagonalCellPairsExcluded
      (rightRayCrossingCount n row col (a - 1) (b - 1) % 2)
      (rightRayCrossingCount n row col (a - 1) b % 2)
      (rightRayCrossingCount n row col a b % 2)
      (rightRayCrossingCount n row col a (b - 1) % 2) := by
  let c0 := rightRayCrossingCount n row col (a - 1) (b - 1) % 2
  let c1 := rightRayCrossingCount n row col (a - 1) b % 2
  let c2 := rightRayCrossingCount n row col a b % 2
  let c3 := rightRayCrossingCount n row col a (b - 1) % 2
  have hc0 : c0 ≤ 1 := Nat.le_of_lt_succ (Nat.mod_lt _ (by omega))
  have hc1 : c1 ≤ 1 := Nat.le_of_lt_succ (Nat.mod_lt _ (by omega))
  have hc2 : c2 ≤ 1 := Nat.le_of_lt_succ (Nat.mod_lt _ (by omega))
  have hc3 : c3 ≤ 1 := Nat.le_of_lt_succ (Nat.mod_lt _ (by omega))
  apply diagonal_cell_pairs_excluded_necSuf c0 c1 c2 c3 hc0 hc1 hc2 hc3
  by_cases hv : ∃ j, j < n ∧ row j = a ∧ col j = b
  · left
    rcases hv with ⟨j, hj, hrow, hcol⟩
    simpa [hrow, hcol] using
      vertexSurroundingCells_formParityArcs n row col j hj hclosedRow hclosedCol hunit
        hdistinct (by simpa [hrow, hcol] using hleft)
        (by simpa [hrow, hcol] using hright)
        (by simpa [hrow, hcol] using hdown)
        (by simpa [hrow, hcol] using hup)
  · right
    have hvisit0 : vertexVisitCount n row col a b = 0 := by
      unfold vertexVisitCount
      apply Finset.sum_eq_zero
      intro k hk
      have hklt : k < n := Finset.mem_range.mp hk
      simp only [ite_eq_right_iff]
      intro hpoint
      exact False.elim (hv ⟨k, hklt, hpoint⟩)
    have hsum := vertexIncidentEdgeTraversal_even
      n row col a b hunit hclosedRow hclosedCol
    have hleft0 : verticalEdgeTraversalCount n row col (a - 1) b = 0 := by omega
    have hright0 : verticalEdgeTraversalCount n row col a b = 0 := by omega
    have hdown0 : horizontalEdgeTraversalCount n row col a (b - 1) = 0 := by omega
    have hup0 : horizontalEdgeTraversalCount n row col a b = 0 := by omega
    have h01 := rightRayCrossingCount_adjacent n row col (a - 1) (b - 1)
    have h12 := verticallyAdjacentCells_boundaryParity
      n row col (a - 1) b hclosedRow hclosedCol hunit
    have h23 := rightRayCrossingCount_adjacent n row col a (b - 1)
    have h30 := verticallyAdjacentCells_boundaryParity
      n row col (a - 1) (b - 1) hclosedRow hclosedCol hunit
    simp only [Int.sub_add_cancel] at h01 h12 h23 h30
    change c0 = c1 ∧ c1 = c2 ∧ c2 = c3
    simp [hleft0, hright0, hdown0, hup0] at h01 h12 h23 h30
    omega

end Ising2DLambda.KacWard
