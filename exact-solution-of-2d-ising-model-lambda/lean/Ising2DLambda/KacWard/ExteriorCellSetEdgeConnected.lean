/-
章「Onsager 閉形式への接続」の
「持ち上げ点が相異なる閉路の内側セル集合の補集合は辺連結である」
（`claim_exterior_cell_set_edge_connected`）の具体版。

人手証明と同じく、外接長方形の外側と歩道沿いの外側帯を交わる二つの連結な核とし、
任意の外側セルから同じ行を進んでその合併へ至る有限列をつなぐ。
-/
import Ising2DLambda.KacWard.WalkSideExteriorBandConnected
import Ising2DLambda.NecSuf.KacWard.ExteriorCellSetEdgeConnected

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 右半直線交差数が偶数であるセル、すなわち内側セル集合の補集合。 -/
def exteriorCells (n : ℕ) (row col : ℕ → ℤ) : Set (ℤ × ℤ) :=
  (oddRayInteriorCells n row col)ᶜ

/-- 外接長方形の四辺より外にある整数格子セル。 -/
def outsideBoundingRectangle
    (rMin rMax cMin cMax : ℤ) : Set (ℤ × ℤ) :=
  {p | p.1 < rMin ∨ rMax ≤ p.1 ∨ p.2 < cMin ∨ cMax ≤ p.2}

/-- 外側帯・外接長方形外・行方向到達を合成する局所版。 -/
theorem exteriorCellSet_nonempty_edgeConnected_local
    (n : ℕ) (row col : ℕ → ℤ) (rMin rMax cMin cMax : ℤ) (hn : 0 < n)
    (houtsideSubset : outsideBoundingRectangle rMin rMax cMin cMax ⊆
      exteriorCells n row col)
    (houtsideConnected : EdgeConnectedCellSet
      (outsideBoundingRectangle rMin rMax cMin cMax))
    (hbandNonempty : ∀ k < n, (surroundingExteriorCells n row col k).Nonempty)
    (hbandLocal : ∀ k < n,
      EdgeConnectedCellSet (surroundingExteriorCells n row col k))
    (hbandBridge : ∀ k, k + 1 < n → ∃ p,
      p ∈ surroundingExteriorCells n row col k ∧
      p ∈ surroundingExteriorCells n row col (k + 1))
    (hoverlap : ∃ p,
      p ∈ outsideBoundingRectangle rMin rMax cMin cMax ∧
      p ∈ walkSideExteriorBand n row col)
    (hreaches : ∀ x ∈ exteriorCells n row col,
      ∃ b ∈ outsideBoundingRectangle rMin rMax cMin cMax ∪
          walkSideExteriorBand n row col,
        Relation.ReflTransGen
          (fun a b =>
            a ∈ exteriorCells n row col ∧
            b ∈ exteriorCells n row col ∧
            CellEdgeAdjacent a b)
          x b) :
    (exteriorCells n row col).Nonempty ∧
      EdgeConnectedCellSet (exteriorCells n row col) := by
  have hband := walkSideExteriorBand_nonempty_edgeConnected_local
    n row col hn hbandNonempty hbandLocal hbandBridge
  have hbandSubset : walkSideExteriorBand n row col ⊆ exteriorCells n row col := by
    rintro p ⟨k, hk, hp⟩
    change p ∉ oddRayInteriorCells n row col
    exact hp.2
  exact connected_of_two_connected_cores_and_reaches_necSuf
    CellEdgeAdjacent cellEdgeAdjacent_symmetric
    (exteriorCells n row col)
    (outsideBoundingRectangle rMin rMax cMin cMax)
    (walkSideExteriorBand n row col)
    houtsideSubset hbandSubset houtsideConnected hband.2 hoverlap hreaches

/-- `claim_exterior_cell_set_edge_connected` の具体版。 -/
theorem exteriorCellSet_nonempty_edgeConnected
    (n : ℕ) (row col : ℕ → ℤ) (rMin rMax cMin cMax : ℤ) (hn : 0 < n)
    (hclosedRow : row n = row 0) (hclosedCol : col n = col 0)
    (hunit : IsUnitGridWalk n row col)
    (hdistinct : ∀ k l, k < n → l < n →
      row k = row l → col k = col l → k = l)
    (hedgeSimple : ∀ k, k < n →
      verticalEdgeTraversalCount n row col (row k - 1) (col k) ≤ 1 ∧
      verticalEdgeTraversalCount n row col (row k) (col k) ≤ 1 ∧
      horizontalEdgeTraversalCount n row col (row k) (col k - 1) ≤ 1 ∧
      horizontalEdgeTraversalCount n row col (row k) (col k) ≤ 1)
    (houtsideSubset : outsideBoundingRectangle rMin rMax cMin cMax ⊆
      exteriorCells n row col)
    (houtsideConnected : EdgeConnectedCellSet
      (outsideBoundingRectangle rMin rMax cMin cMax))
    (hbandLocal : ∀ k < n,
      EdgeConnectedCellSet (surroundingExteriorCells n row col k))
    (hbandBridge : ∀ k, k + 1 < n → ∃ p,
      p ∈ surroundingExteriorCells n row col k ∧
      p ∈ surroundingExteriorCells n row col (k + 1))
    (hoverlap : ∃ p,
      p ∈ outsideBoundingRectangle rMin rMax cMin cMax ∧
      p ∈ walkSideExteriorBand n row col)
    (hreaches : ∀ x ∈ exteriorCells n row col,
      ∃ b ∈ outsideBoundingRectangle rMin rMax cMin cMax ∪
          walkSideExteriorBand n row col,
        Relation.ReflTransGen
          (fun a b =>
            a ∈ exteriorCells n row col ∧
            b ∈ exteriorCells n row col ∧
            CellEdgeAdjacent a b)
          x b) :
    (exteriorCells n row col).Nonempty ∧
      EdgeConnectedCellSet (exteriorCells n row col) := by
  have hband := walkSideExteriorBand_nonempty_edgeConnected n row col hn
    hclosedRow hclosedCol hunit hdistinct hedgeSimple hbandLocal hbandBridge
  have hbandSubset : walkSideExteriorBand n row col ⊆ exteriorCells n row col := by
    rintro p ⟨k, hk, hp⟩
    change p ∉ oddRayInteriorCells n row col
    exact hp.2
  exact connected_of_two_connected_cores_and_reaches_necSuf
    CellEdgeAdjacent cellEdgeAdjacent_symmetric
    (exteriorCells n row col)
    (outsideBoundingRectangle rMin rMax cMin cMax)
    (walkSideExteriorBand n row col)
    houtsideSubset hbandSubset houtsideConnected hband.2 hoverlap hreaches

end Ising2DLambda.KacWard
