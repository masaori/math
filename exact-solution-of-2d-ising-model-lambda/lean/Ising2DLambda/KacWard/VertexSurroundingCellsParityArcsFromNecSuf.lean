/-
具体版が必要十分版の特殊化として得られることの導出。

四つのセルの交差数の偶奇と、接する四辺の通過回数を必要十分版へ渡す。
-/
import Ising2DLambda.KacWard.VertexSurroundingCellsParityArcs

namespace Ising2DLambda.KacWard

/-- `claim_vertex_surrounding_cells_form_parity_arcs` を必要十分版から導く。 -/
theorem vertexSurroundingCells_formParityArcs_from_necSuf
    (n : ℕ) (row col : ℕ → ℤ) (j : ℕ)
    (hj : j < n)
    (hclosedRow : row n = row 0) (hclosedCol : col n = col 0)
    (hunit : IsUnitGridWalk n row col)
    (hdistinct : ∀ k l, k < n → l < n →
      row k = row l → col k = col l → k = l)
    (hleft : verticalEdgeTraversalCount n row col (row j - 1) (col j) ≤ 1)
    (hright : verticalEdgeTraversalCount n row col (row j) (col j) ≤ 1)
    (hdown : horizontalEdgeTraversalCount n row col (row j) (col j - 1) ≤ 1)
    (hup : horizontalEdgeTraversalCount n row col (row j) (col j) ≤ 1) :
    Ising2DLambda.NecSuf.KacWard.FourCellsFormParityArcs
      (rightRayCrossingCount n row col (row j - 1) (col j - 1) % 2)
      (rightRayCrossingCount n row col (row j - 1) (col j) % 2)
      (rightRayCrossingCount n row col (row j) (col j) % 2)
      (rightRayCrossingCount n row col (row j) (col j - 1) % 2) :=
  vertexSurroundingCells_formParityArcs n row col j hj hclosedRow hclosedCol hunit hdistinct
    hleft hright hdown hup

end Ising2DLambda.KacWard
