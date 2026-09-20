/-
具体版が必要十分版の特殊化として得られることの導出。

横方向では整数位置による有限和の分割を、上下方向では閉じた指示値列の偶数性と
単位格子辺による三分割を、それぞれ必要十分版へ渡す。
-/
import Ising2DLambda.KacWard.AdjacentCellsBoundaryParity
import Ising2DLambda.NecSuf.KacWard.AdjacentCellsBoundaryParity

namespace Ising2DLambda.KacWard

open Ising2DLambda.Tools

/-- 横に隣り合うセルの交差数の等式を必要十分版から導く。 -/
theorem rightRayCrossingCount_adjacent_from_necSuf
    (n : ℕ) (row col : ℕ → ℤ) (r c : ℤ) :
    rightRayCrossingCount n row col r c =
      rightRayCrossingCount n row col r (c + 1) +
        verticalEdgeTraversalCount n row col r (c + 1) := by
  unfold rightRayCrossingCount verticalEdgeTraversalCount
  simpa [add_comm] using
    (Ising2DLambda.NecSuf.KacWard.integer_tail_sum_split_necSuf
      n (crossesRowLevel row r) col c)

/-- 上下に隣り合うセルの境界奇偶を必要十分版から導く。 -/
theorem verticallyAdjacentCells_boundaryParity_from_necSuf
    (n : ℕ) (row col : ℕ → ℤ) (r c : ℤ)
    (hclosedRow : row n = row 0) (hclosedCol : col n = col 0)
    (hunit : IsUnitGridWalk n row col) :
    (rightRayCrossingCount n row col r c +
      rightRayCrossingCount n row col (r + 1) c) % 2 =
        horizontalEdgeTraversalCount n row col (r + 1) c % 2 := by
  exact Ising2DLambda.NecSuf.KacWard.boundary_three_part_parity_necSuf
    (rightRayCrossingCount n row col r c)
    (rightRayCrossingCount n row col (r + 1) c)
    (horizontalEdgeTraversalCount n row col (r + 1) c)
    (upCrossingCount n (rayVertexIndicator row col (r + 1) c) 0 +
      downCrossingCount n (rayVertexIndicator row col (r + 1) c) 0)
    (rayBoundaryTransitionCount_partition n row col r c hunit)
    (rayBoundaryTransitionCount_even n row col (r + 1) c hclosedRow hclosedCol)

end Ising2DLambda.KacWard
