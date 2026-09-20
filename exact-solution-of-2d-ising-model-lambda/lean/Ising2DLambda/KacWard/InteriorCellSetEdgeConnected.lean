/-
章「Onsager 閉形式への接続」の
「持ち上げ点が相異なる閉路の内側セル集合は辺連結である」
（`claim_interior_cell_set_edge_connected`）の具体版。

人手証明の最後の合成と同じく、歩道沿いの内側帯を連結な核とし、任意の内側セルから
同じ行を進んで帯へ至る有限列を前後につなぐ。
-/
import Ising2DLambda.KacWard.WalkSideInteriorBandConnected
import Ising2DLambda.NecSuf.KacWard.InteriorCellSetEdgeConnected

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- `claim_interior_cell_set_edge_connected` の具体版。 -/
theorem interiorCellSet_nonempty_edgeConnected
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
      EdgeConnectedCellSet (oddRayInteriorCells n row col) := by
  have hband := walkSideInteriorBand_nonempty_edgeConnected
    n row col hn hnonempty hlocal hbridge
  apply connected_of_connected_core_and_reaches_necSuf
    CellEdgeAdjacent cellEdgeAdjacent_symmetric
    (oddRayInteriorCells n row col) (walkSideInteriorBand n row col)
    hband.1
  · rintro p ⟨k, hk, hp⟩
    exact hp.2
  · exact hband.2
  · exact hreaches

end Ising2DLambda.KacWard
