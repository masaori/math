/-
章「Onsager 閉形式への接続」の
「持ち上げ点が相異なる閉路の歩道沿いの外側帯は空でなく辺連結である」
（`claim_walk_side_exterior_band_edge_connected`）の具体版。

人手証明の最後の合成と同じく、各訪問頂点に接する外側セルの弧を、
隣り合う二頂点が共有する外側セルで順につなぐ。
-/
import Ising2DLambda.KacWard.WalkSideInteriorBandConnected

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 持ち上げ点 `(row k, col k)` に接する四セルのうち、右半直線交差数が偶数のもの。 -/
def surroundingExteriorCells
    (n : ℕ) (row col : ℕ → ℤ) (k : ℕ) : Set (ℤ × ℤ) :=
  {p | p = (row k - 1, col k - 1) ∨
       p = (row k - 1, col k) ∨
       p = (row k, col k) ∨
       p = (row k, col k - 1)} \ oddRayInteriorCells n row col

/-- 一周期の各持ち上げ点に接する外側セルを集めた歩道沿いの外側帯。 -/
def walkSideExteriorBand
    (n : ℕ) (row col : ℕ → ℤ) : Set (ℤ × ℤ) :=
  {p | ∃ k < n, p ∈ surroundingExteriorCells n row col k}

/-- `claim_walk_side_exterior_band_edge_connected` の具体版。 -/
theorem walkSideExteriorBand_nonempty_edgeConnected
    (n : ℕ) (row col : ℕ → ℤ) (hn : 0 < n)
    (hnonempty : ∀ k < n, (surroundingExteriorCells n row col k).Nonempty)
    (hlocal : ∀ k < n, EdgeConnectedCellSet (surroundingExteriorCells n row col k))
    (hbridge : ∀ k, k + 1 < n → ∃ p,
      p ∈ surroundingExteriorCells n row col k ∧
      p ∈ surroundingExteriorCells n row col (k + 1)) :
    (walkSideExteriorBand n row col).Nonempty ∧
      EdgeConnectedCellSet (walkSideExteriorBand n row col) := by
  exact finite_chain_union_connected_necSuf CellEdgeAdjacent cellEdgeAdjacent_symmetric
    n (surroundingExteriorCells n row col) hn hnonempty hlocal hbridge

end Ising2DLambda.KacWard
