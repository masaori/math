/-
章「Onsager 閉形式への接続」の
「持ち上げ点が相異なる閉路の各訪問頂点で内側セルと外側セルはそれぞれ一つの弧をなす」
（`claim_vertex_surrounding_cells_form_parity_arcs`）の具体版。

人手証明と同じく、訪問回数の二倍等式から接する四辺の総通過回数を二とし、
持ち上げ点の相異性が与える各辺の高々一回という局所条件と、隣接セルの境界奇偶を合成する。
-/
import Ising2DLambda.KacWard.VertexIncidentEdgeTraversalEven
import Ising2DLambda.NecSuf.KacWard.VertexSurroundingCellsParityArcs
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 訪問回数が一回である頂点についての局所計算。 -/
theorem vertexSurroundingCells_formParityArcs_local
    (n : ℕ) (row col : ℕ → ℤ) (a b : ℤ)
    (hclosedRow : row n = row 0) (hclosedCol : col n = col 0)
    (hunit : IsUnitGridWalk n row col)
    (hvisit : vertexVisitCount n row col a b = 1)
    (hleft : verticalEdgeTraversalCount n row col (a - 1) b ≤ 1)
    (hright : verticalEdgeTraversalCount n row col a b ≤ 1)
    (hdown : horizontalEdgeTraversalCount n row col a (b - 1) ≤ 1)
    (hup : horizontalEdgeTraversalCount n row col a b ≤ 1) :
    FourCellsFormParityArcs
      (rightRayCrossingCount n row col (a - 1) (b - 1) % 2)
      (rightRayCrossingCount n row col (a - 1) b % 2)
      (rightRayCrossingCount n row col a b % 2)
      (rightRayCrossingCount n row col a (b - 1) % 2) := by
  let c0 := rightRayCrossingCount n row col (a - 1) (b - 1) % 2
  let c1 := rightRayCrossingCount n row col (a - 1) b % 2
  let c2 := rightRayCrossingCount n row col a b % 2
  let c3 := rightRayCrossingCount n row col a (b - 1) % 2
  let e0 := verticalEdgeTraversalCount n row col (a - 1) b
  let e1 := horizontalEdgeTraversalCount n row col a b
  let e2 := verticalEdgeTraversalCount n row col a b
  let e3 := horizontalEdgeTraversalCount n row col a (b - 1)
  have hc0 : c0 ≤ 1 := by
    exact Nat.le_of_lt_succ (Nat.mod_lt _ (by omega))
  have hc1 : c1 ≤ 1 := by
    exact Nat.le_of_lt_succ (Nat.mod_lt _ (by omega))
  have hc2 : c2 ≤ 1 := by
    exact Nat.le_of_lt_succ (Nat.mod_lt _ (by omega))
  have hc3 : c3 ≤ 1 := by
    exact Nat.le_of_lt_succ (Nat.mod_lt _ (by omega))
  have hedges : e0 + e1 + e2 + e3 = 2 := by
    have hsum := vertexIncidentEdgeTraversal_even
      n row col a b hunit hclosedRow hclosedCol
    simp [e0, e1, e2, e3, hvisit] at hsum ⊢
    omega
  have h01 : (c0 + c1) % 2 = e0 := by
    have hsplit := rightRayCrossingCount_adjacent n row col (a - 1) (b - 1)
    simp only [Int.sub_add_cancel] at hsplit
    simp [c0, c1, e0]
    omega
  have h12 : (c1 + c2) % 2 = e1 := by
    have hparity := verticallyAdjacentCells_boundaryParity
      n row col (a - 1) b hclosedRow hclosedCol hunit
    simp only [Int.sub_add_cancel] at hparity
    simp [c1, c2, e1]
    omega
  have h23 : (c2 + c3) % 2 = e2 := by
    have hsplit := rightRayCrossingCount_adjacent n row col a (b - 1)
    simp only [Int.sub_add_cancel] at hsplit
    simp [c2, c3, e2]
    omega
  have h30 : (c3 + c0) % 2 = e3 := by
    have hparity := verticallyAdjacentCells_boundaryParity
      n row col (a - 1) (b - 1) hclosedRow hclosedCol hunit
    simp only [Int.sub_add_cancel] at hparity
    simp [c3, c0, e3]
    omega
  exact four_cells_form_parity_arcs_necSuf c0 c1 c2 c3 e0 e1 e2 e3
    hc0 hc1 hc2 hc3 hedges h01 h12 h23 h30

/-- `claim_vertex_surrounding_cells_form_parity_arcs` の具体版。 -/
theorem vertexSurroundingCells_formParityArcs
    (n : ℕ) (row col : ℕ → ℤ) (j : ℕ)
    (hj : j < n)
    (hclosedRow : row n = row 0) (hclosedCol : col n = col 0)
    (hunit : IsUnitGridWalk n row col)
    (hdistinct : ∀ k l, k < n → l < n →
      row k = row l → col k = col l → k = l)
    -- 閉じた非後退単位格子路と持ち上げ点の相異性から得る局所的な辺単純性。
    (hleft : verticalEdgeTraversalCount n row col (row j - 1) (col j) ≤ 1)
    (hright : verticalEdgeTraversalCount n row col (row j) (col j) ≤ 1)
    (hdown : horizontalEdgeTraversalCount n row col (row j) (col j - 1) ≤ 1)
    (hup : horizontalEdgeTraversalCount n row col (row j) (col j) ≤ 1) :
    FourCellsFormParityArcs
      (rightRayCrossingCount n row col (row j - 1) (col j - 1) % 2)
      (rightRayCrossingCount n row col (row j - 1) (col j) % 2)
      (rightRayCrossingCount n row col (row j) (col j) % 2)
      (rightRayCrossingCount n row col (row j) (col j - 1) % 2) := by
  have hvisit : vertexVisitCount n row col (row j) (col j) = 1 := by
    unfold vertexVisitCount
    rw [Finset.sum_eq_single j]
    · simp
    · intro k hk hkj
      have hklt : k < n := Finset.mem_range.mp hk
      have hcoordinates : ¬ (row k = row j ∧ col k = col j) := by
        intro h
        exact hkj (hdistinct k j hklt hj h.1 h.2)
      simp [hcoordinates]
    · exact fun h => False.elim (h (Finset.mem_range.mpr hj))
  exact vertexSurroundingCells_formParityArcs_local n row col (row j) (col j)
    hclosedRow hclosedCol hunit hvisit hleft hright hdown hup

end Ising2DLambda.KacWard
