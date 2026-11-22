/-
具体版が必要十分版の特殊化として得られることの導出。
-/
import Ising2DLambda.KacWard.CellComplexOneCellIncrement
import Ising2DLambda.NecSuf.KacWard.CellComplexOneCellIncrement

namespace Ising2DLambda.KacWard

/-- `claim_cell_complex_one_cell_increment` を必要十分版から導く。 -/
theorem cellEulerNumber_insert_from_necSuf
    (cells : Finset GridCell) (x : GridCell) (hx : x ∉ cells) :
    cellEulerNumber (insert x cells) =
      cellEulerNumber cells + 1 + (cellEdges cells ∩ cellEdges {x}).card -
        (cellVertices cells ∩ cellVertices {x}).card := by
  unfold cellEulerNumber
  exact Ising2DLambda.NecSuf.KacWard.cellComplex_oneCellIncrement_necSuf
    cells x cellVertices cellEdges hx
    (by simp [cellVertices, Finset.union_comm])
    (by simp [cellEdges, Finset.union_comm])
    (by simpa [cellVertices] using verticesOfCell_card x)
    (by simpa [cellEdges] using edgesOfCell_card x)

end Ising2DLambda.KacWard
