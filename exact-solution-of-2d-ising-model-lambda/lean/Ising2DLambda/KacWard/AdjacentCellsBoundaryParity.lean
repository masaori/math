/-
章「Onsager 閉形式への接続」の「隣接セルの交差奇偶と共有辺の通過奇偶」の具体版。

人手証明と同じく、横に隣り合うセルでは右半直線上の縦辺を列 `c+1` とその右側へ分割する。
上下に隣り合うセルでは、行 `r+1` の右半直線上の頂点への出入りを数え、閉路なので境界横断の
総数が偶数であることを示す。その境界横断を下側縦辺・上側縦辺・共有横辺へ分割する。
-/
import Ising2DLambda.KacWard.OddRayInteriorCellsBounded
import Mathlib
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

open BigOperators Ising2DLambda.Tools

/-- 頂点 `(row k, col k)` から始まる第 `k` 辺が列水準 `c` を横に横切ること。 -/
def crossesColLevel (col : ℕ → ℤ) (c : ℤ) (k : ℕ) : Prop :=
  (col k = c ∧ col (k + 1) = c + 1) ∨
  (col k = c + 1 ∧ col (k + 1) = c)

instance crossesColLevelDecidable (col : ℕ → ℤ) (c : ℤ) (k : ℕ) :
    Decidable (crossesColLevel col c k) := by
  unfold crossesColLevel
  infer_instance

/-- 平面の縦辺 `{(r,j),(r+1,j)}` の通過回数。 -/
def verticalEdgeTraversalCount
    (n : ℕ) (row col : ℕ → ℤ) (r j : ℤ) : ℕ :=
  ∑ k ∈ Finset.range n,
    if crossesRowLevel row r k ∧ col k = j then 1 else 0

/-- 平面の横辺 `{(i,c),(i,c+1)}` の通過回数。 -/
def horizontalEdgeTraversalCount
    (n : ℕ) (row col : ℕ → ℤ) (i c : ℤ) : ℕ :=
  ∑ k ∈ Finset.range n,
    if crossesColLevel col c k ∧ row k = i then 1 else 0

/-- 平面持ち上げが単位格子辺を一歩進むという条件。 -/
def IsUnitGridWalk (n : ℕ) (row col : ℕ → ℤ) : Prop :=
  ∀ k < n,
    (row (k + 1) = row k + 1 ∧ col (k + 1) = col k) ∨
    (row (k + 1) = row k - 1 ∧ col (k + 1) = col k) ∨
    (row (k + 1) = row k ∧ col (k + 1) = col k + 1) ∨
    (row (k + 1) = row k ∧ col (k + 1) = col k - 1)

/-- `claim_adjacent_cells_ray_crossing_difference` の具体版。 -/
theorem rightRayCrossingCount_adjacent
    (n : ℕ) (row col : ℕ → ℤ) (r c : ℤ) :
    rightRayCrossingCount n row col r c =
      rightRayCrossingCount n row col r (c + 1) +
        verticalEdgeTraversalCount n row col r (c + 1) := by
  unfold rightRayCrossingCount verticalEdgeTraversalCount
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro k _
  by_cases ha : crossesRowLevel row r k <;> by_cases heq : col k = c + 1 <;>
    by_cases hlt : c + 1 < col k <;> simp [ha, heq, hlt] <;> omega

/-- 行 `i` の右半直線上の頂点に属することの指示値。 -/
def rayVertexIndicator (row col : ℕ → ℤ) (i c : ℤ) (k : ℕ) : ℤ :=
  if row k = i ∧ c < col k then 1 else 0

/-- 閉じた指示値列では、境界を横切る総数が偶数である。 -/
theorem rayBoundaryTransitionCount_even
    (n : ℕ) (row col : ℕ → ℤ) (i c : ℤ)
    (hclosedRow : row n = row 0) (hclosedCol : col n = col 0) :
    Even (upCrossingCount n (rayVertexIndicator row col i c) 0 +
      downCrossingCount n (rayVertexIndicator row col i c) 0) := by
  have hstep : ∀ k < n,
      rayVertexIndicator row col i c (k + 1) - rayVertexIndicator row col i c k = -1 ∨
      rayVertexIndicator row col i c (k + 1) - rayVertexIndicator row col i c k = 0 ∨
      rayVertexIndicator row col i c (k + 1) - rayVertexIndicator row col i c k = 1 := by
    intro k _
    unfold rayVertexIndicator
    split_ifs <;> omega
  have hcross := integerSequence_levelCrossing n (rayVertexIndicator row col i c) 0 hstep
  have hend : rayVertexIndicator row col i c n = rayVertexIndicator row col i c 0 := by
    simp [rayVertexIndicator, hclosedRow, hclosedCol]
  have hendpoint : endpointCrossingValue 0
      (rayVertexIndicator row col i c 0) (rayVertexIndicator row col i c n) = 0 := by
    rw [hend]
    unfold endpointCrossingValue
    split_ifs <;> omega
  have hud : upCrossingCount n (rayVertexIndicator row col i c) 0 =
      downCrossingCount n (rayVertexIndicator row col i c) 0 := by
    rw [hendpoint] at hcross
    omega
  rw [hud]
  exact ⟨downCrossingCount n (rayVertexIndicator row col i c) 0, by omega⟩

/-- 境界横断は下側縦辺・上側縦辺・共有横辺の三種類へ分割される。 -/
theorem rayBoundaryTransitionCount_partition
    (n : ℕ) (row col : ℕ → ℤ) (r c : ℤ)
    (hunit : IsUnitGridWalk n row col) :
    upCrossingCount n (rayVertexIndicator row col (r + 1) c) 0 +
        downCrossingCount n (rayVertexIndicator row col (r + 1) c) 0 =
      rightRayCrossingCount n row col r c +
        rightRayCrossingCount n row col (r + 1) c +
        horizontalEdgeTraversalCount n row col (r + 1) c := by
  unfold upCrossingCount downCrossingCount rightRayCrossingCount
    horizontalEdgeTraversalCount
  rw [← Finset.sum_add_distrib, ← Finset.sum_add_distrib, ← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro k hk
  have hklt := Finset.mem_range.mp hk
  rcases hunit k hklt with h | h | h | h <;>
    simp only [rayVertexIndicator, crossesRowLevel, crossesColLevel] <;>
    split_ifs <;> omega

/-- `claim_vertically_adjacent_cells_boundary_parity` の具体版。 -/
theorem verticallyAdjacentCells_boundaryParity
    (n : ℕ) (row col : ℕ → ℤ) (r c : ℤ)
    (hclosedRow : row n = row 0) (hclosedCol : col n = col 0)
    (hunit : IsUnitGridWalk n row col) :
    (rightRayCrossingCount n row col r c +
      rightRayCrossingCount n row col (r + 1) c) % 2 =
        horizontalEdgeTraversalCount n row col (r + 1) c % 2 := by
  have heven := rayBoundaryTransitionCount_even n row col (r + 1) c hclosedRow hclosedCol
  have hpartition := rayBoundaryTransitionCount_partition n row col r c hunit
  rw [hpartition] at heven
  rcases heven with ⟨q, hq⟩
  omega

end Ising2DLambda.KacWard
