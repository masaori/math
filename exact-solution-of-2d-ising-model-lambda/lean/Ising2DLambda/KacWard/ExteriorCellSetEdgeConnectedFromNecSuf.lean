/-
具体版が必要十分版の特殊化として得られることの導出。

外接長方形の外側と歩道沿いの外側帯を二つの核として必要十分版へ渡す。
-/
import Ising2DLambda.KacWard.ExteriorCellSetEdgeConnected

namespace Ising2DLambda.KacWard

/-- `claim_exterior_cell_set_edge_connected` を必要十分版から導く。 -/
theorem exteriorCellSet_nonempty_edgeConnected_from_necSuf
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
      EdgeConnectedCellSet (exteriorCells n row col) :=
  exteriorCellSet_nonempty_edgeConnected
    n row col rMin rMax cMin cMax hn
    houtsideSubset houtsideConnected
    hbandNonempty hbandLocal hbandBridge hoverlap hreaches

end Ising2DLambda.KacWard
