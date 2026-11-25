/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.AdjacentCellCornersConnected
import Ising2DLambda.KacWard.CellCornerConnectedFromNecSuf
import Ising2DLambda.KacWard.WalkSideInteriorBandConnectedFromNecSuf
import Ising2DLambda.NecSuf.KacWard.AdjacentCellCornersConnected

namespace Ising2DLambda.KacWard

/-- The concrete statement follows from the necessary-sufficient gluing proof. -/
theorem adjacentCellCorners_connected_from_necSuf (p q : GridCell)
    (hadj : CellEdgeAdjacent p q) :
    ∀ u ∈ cellVertices ({p, q} : Finset GridCell),
      ∀ v ∈ cellVertices ({p, q} : Finset GridCell),
        Relation.EqvGen (CellVertexStep ({p, q} : Finset GridCell)) u v := by
  obtain ⟨w, hwp, hwq⟩ := adjacentCells_commonCorner p q hadj
  have hp := cellCorners_connected p.1 p.2
  have hq := cellCorners_connected q.1 q.2
  have h := Ising2DLambda.NecSuf.KacWard.adjacentCornerSets_connected
    (verticesOfCell p) (verticesOfCell q)
    (CellVertexStep ({p} : Finset GridCell))
    (CellVertexStep ({q} : Finset GridCell))
    (CellVertexStep ({p, q} : Finset GridCell))
    (by simpa only [Prod.mk.eta] using hp)
    (by simpa only [Prod.mk.eta] using hq)
    (singleCellStep_le_cells p {p, q} (by simp))
    (singleCellStep_le_cells q {p, q} (by simp))
    w hwp hwq
  simpa [cellVertices] using h

end Ising2DLambda.KacWard
