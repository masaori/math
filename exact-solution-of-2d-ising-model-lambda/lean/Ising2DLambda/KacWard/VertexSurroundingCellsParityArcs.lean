/-
章「Onsager 閉形式への接続」の
「持ち上げ点が相異なる閉路の各訪問頂点で内側セルと外側セルはそれぞれ一つの弧をなす」
（`claim_vertex_surrounding_cells_form_parity_arcs`）の具体版。

人手証明と同じく、訪問回数の二倍等式から接する四辺の総通過回数を二とし、
持ち上げ点の相異性が与える各辺の高々一回という局所条件と、隣接セルの境界奇偶を合成する。
-/
import Ising2DLambda.KacWard.VertexIncidentEdgeTraversalEven
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- 本文の主張の結論「四セル $C_0,C_1,C_2,C_3$ の内側セルと外側セルはそれぞれ空でない一つの巡回弧をなす」。
`c_i` は $C_i$ の右向き半直線の交差数の偶奇（$1$ が内側）である。巡回列 $C_0,C_1,C_2,C_3,C_0$ で内外の別が
ちょうど二回変わり、内側セルの個数が $0$ でも $4$ でもないことで述べる。 -/
def FourCellsFormParityArcs (c0 c1 c2 c3 : ℕ) : Prop :=
  (c0 + c1) % 2 + (c1 + c2) % 2 + (c2 + c3) % 2 + (c3 + c0) % 2 = 2 ∧
    0 < c0 + c1 + c2 + c3 ∧ c0 + c1 + c2 + c3 < 4

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
  -- 本文の最後の段: 奇数回通る共有辺はちょうど二本で、その各々で内外の別が変わるので、
  -- 巡回列で内外の別はちょうど二回変わり、内側と外側はともに空でない。
  change FourCellsFormParityArcs c0 c1 c2 c3
  clear_value c0 c1 c2 c3 e0 e1 e2 e3
  unfold FourCellsFormParityArcs
  refine ⟨?_, ?_, ?_⟩ <;> omega

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
  have hvisit := vertexVisitCount_eq_one_of_distinct n row col j hj hdistinct
  exact vertexSurroundingCells_formParityArcs_local n row col (row j) (col j)
    hclosedRow hclosedCol hunit hvisit hleft hright hdown hup

end Ising2DLambda.KacWard
