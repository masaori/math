/-
具体版が必要十分版の特殊化として得られることの導出。

四セルの交差数の奇偶、持ち上げ点の相異性と四辺の通過回数に対する仮定を具体版へ渡す。
-/
import Ising2DLambda.KacWard.BoundaryVertexDiagonalContactExcluded

namespace Ising2DLambda.KacWard

/-- `claim_boundary_vertex_diagonal_contact_excluded` を必要十分版から導く。 -/
theorem boundaryVertex_diagonalContactExcluded_from_necSuf
    (n : ℕ) (row col : ℕ → ℤ) (a b : ℤ)
    (hclosedRow : row n = row 0) (hclosedCol : col n = col 0)
    (hunit : IsUnitGridWalk n row col)
    (hdistinct : ∀ k l, k < n → l < n →
      row k = row l → col k = col l → k = l)
    (hleft : verticalEdgeTraversalCount n row col (a - 1) b ≤ 1)
    (hright : verticalEdgeTraversalCount n row col a b ≤ 1)
    (hdown : horizontalEdgeTraversalCount n row col a (b - 1) ≤ 1)
    (hup : horizontalEdgeTraversalCount n row col a b ≤ 1) :
    Ising2DLambda.NecSuf.KacWard.DiagonalCellPairsExcluded
      (rightRayCrossingCount n row col (a - 1) (b - 1) % 2)
      (rightRayCrossingCount n row col (a - 1) b % 2)
      (rightRayCrossingCount n row col a b % 2)
      (rightRayCrossingCount n row col a (b - 1) % 2) :=
  boundaryVertex_diagonalContactExcluded n row col a b hclosedRow hclosedCol hunit
    hdistinct hleft hright hdown hup

end Ising2DLambda.KacWard
