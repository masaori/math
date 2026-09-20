/-
具体版が必要十分版の特殊化として得られることの導出。

歩道沿いの内側帯を核とし、各内側セルから帯へ至る有限列を必要十分版へ渡す。
-/
import Ising2DLambda.KacWard.InteriorCellSetEdgeConnected

namespace Ising2DLambda.KacWard

/-- `claim_interior_cell_set_edge_connected` を必要十分版から導く。 -/
theorem interiorCellSet_nonempty_edgeConnected_from_necSuf
    (n : ℕ) (row col : ℕ → ℤ) (hn : 0 < n)
    (hnonempty : ∀ k < n, (surroundingInteriorCells n row col k).Nonempty)
    (hlocal : ∀ k < n, EdgeConnectedCellSet (surroundingInteriorCells n row col k))
    (hbridge : ∀ k, k + 1 < n → ∃ p,
      p ∈ surroundingInteriorCells n row col k ∧
      p ∈ surroundingInteriorCells n row col (k + 1))
    (hreaches : ∀ x ∈ oddRayInteriorCells n row col, ∃ b ∈ walkSideInteriorBand n row col,
      Relation.ReflTransGen
        (fun a b =>
          a ∈ oddRayInteriorCells n row col ∧
          b ∈ oddRayInteriorCells n row col ∧
          CellEdgeAdjacent a b)
        x b) :
    (oddRayInteriorCells n row col).Nonempty ∧
      EdgeConnectedCellSet (oddRayInteriorCells n row col) :=
  interiorCellSet_nonempty_edgeConnected
    n row col hn hnonempty hlocal hbridge hreaches

end Ising2DLambda.KacWard
