/-
具体版が必要十分版の特殊化として得られることの導出。

四つのセルの交差数の偶奇と、接する四辺の通過回数を必要十分版へ渡す。
-/
import Ising2DLambda.KacWard.VertexSurroundingCellsParityArcs

namespace Ising2DLambda.KacWard

/-- `claim_vertex_surrounding_cells_form_parity_arcs` を必要十分版から導く。 -/
theorem vertexSurroundingCells_formParityArcs_from_necSuf
    (n : ℕ) (row col : ℕ → ℤ) (a b : ℤ)
    (hclosedRow : row n = row 0) (hclosedCol : col n = col 0)
    (hunit : IsUnitGridWalk n row col)
    (hvisit : vertexVisitCount n row col a b = 1)
    (hleft : verticalEdgeTraversalCount n row col (a - 1) b ≤ 1)
    (hright : verticalEdgeTraversalCount n row col a b ≤ 1)
    (hdown : horizontalEdgeTraversalCount n row col a (b - 1) ≤ 1)
    (hup : horizontalEdgeTraversalCount n row col a b ≤ 1) :
    Ising2DLambda.NecSuf.KacWard.FourCellsFormParityArcs
      (rightRayCrossingCount n row col (a - 1) (b - 1) % 2)
      (rightRayCrossingCount n row col (a - 1) b % 2)
      (rightRayCrossingCount n row col a b % 2)
      (rightRayCrossingCount n row col a (b - 1) % 2) :=
  vertexSurroundingCells_formParityArcs n row col a b hclosedRow hclosedCol hunit
    hvisit hleft hright hdown hup

end Ising2DLambda.KacWard
