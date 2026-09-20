/-
具体版が必要十分版の特殊化として得られることの導出。

訪問頂点ごとの外側セル弧と、隣接する弧の共通セルを有限鎖の補題へ渡す。
-/
import Ising2DLambda.KacWard.WalkSideExteriorBandConnected

namespace Ising2DLambda.KacWard

/-- `claim_walk_side_exterior_band_edge_connected` を必要十分版から導く。 -/
theorem walkSideExteriorBand_nonempty_edgeConnected_from_necSuf
    (n : ℕ) (row col : ℕ → ℤ) (hn : 0 < n)
    (hnonempty : ∀ k < n, (surroundingExteriorCells n row col k).Nonempty)
    (hlocal : ∀ k < n, EdgeConnectedCellSet (surroundingExteriorCells n row col k))
    (hbridge : ∀ k, k + 1 < n → ∃ p,
      p ∈ surroundingExteriorCells n row col k ∧
      p ∈ surroundingExteriorCells n row col (k + 1)) :
    (walkSideExteriorBand n row col).Nonempty ∧
      EdgeConnectedCellSet (walkSideExteriorBand n row col) :=
  walkSideExteriorBand_nonempty_edgeConnected n row col hn hnonempty hlocal hbridge

end Ising2DLambda.KacWard
