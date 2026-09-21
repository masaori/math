/-
具体版が必要十分版の特殊化として得られることの導出。

訪問頂点ごとの内側セル弧と、隣接する弧の共通セルを有限鎖の補題へ渡す。
-/
import Ising2DLambda.KacWard.WalkSideInteriorBandConnected

namespace Ising2DLambda.KacWard

/-- `claim_walk_side_interior_band_edge_connected` を必要十分版から導く。 -/
theorem walkSideInteriorBand_nonempty_edgeConnected_from_necSuf
    (n : ℕ) (row col : ℕ → ℤ) (hn : 0 < n)
    (hclosedRow : row n = row 0) (hclosedCol : col n = col 0)
    (hunit : IsUnitGridWalk n row col)
    (hdistinct : ∀ k l, k < n → l < n →
      row k = row l → col k = col l → k = l)
    (hedgeSimple : ∀ k, k < n →
      verticalEdgeTraversalCount n row col (row k - 1) (col k) ≤ 1 ∧
      verticalEdgeTraversalCount n row col (row k) (col k) ≤ 1 ∧
      horizontalEdgeTraversalCount n row col (row k) (col k - 1) ≤ 1 ∧
      horizontalEdgeTraversalCount n row col (row k) (col k) ≤ 1)
    (hlocal : ∀ k < n, EdgeConnectedCellSet (surroundingInteriorCells n row col k))
    (hbridge : ∀ k, k + 1 < n → ∃ p,
      p ∈ surroundingInteriorCells n row col k ∧
      p ∈ surroundingInteriorCells n row col (k + 1)) :
    (walkSideInteriorBand n row col).Nonempty ∧
      EdgeConnectedCellSet (walkSideInteriorBand n row col) :=
  walkSideInteriorBand_nonempty_edgeConnected n row col hn hclosedRow hclosedCol hunit
    hdistinct hedgeSimple hlocal hbridge

end Ising2DLambda.KacWard
