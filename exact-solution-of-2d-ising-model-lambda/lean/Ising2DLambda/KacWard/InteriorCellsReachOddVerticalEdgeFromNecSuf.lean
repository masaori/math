/-
具体版が必要十分版の特殊化として得られることの導出。

右側で交差数が零になる位置と、隣接セルの交差数の等式を必要十分版へ渡す。
-/
import Ising2DLambda.KacWard.AdjacentCellsBoundaryParity
import Ising2DLambda.NecSuf.KacWard.InteriorCellsReachOddVerticalEdge

namespace Ising2DLambda.KacWard

/-- `claim_interior_cells_reach_odd_vertical_edge` を必要十分版から導く。 -/
theorem interiorCells_reachOddVerticalEdge_from_necSuf
    (n : ℕ) (row col : ℕ → ℤ) (r c cMax : ℤ)
    (hcol : ∀ k < n, col k ≤ cMax)
    (hinside : Odd (rightRayCrossingCount n row col r c)) :
    ∃ g : ℤ,
      c < g ∧
      (∀ j : ℤ, c ≤ j → j < g →
        Odd (rightRayCrossingCount n row col r j)) ∧
      ¬ Odd (rightRayCrossingCount n row col r g) ∧
      Odd (verticalEdgeTraversalCount n row col r g) ∧
      0 < verticalEdgeTraversalCount n row col r g := by
  apply Ising2DLambda.NecSuf.KacWard.odd_run_reaches_odd_increment_necSuf
    (fun j => rightRayCrossingCount n row col r j)
    (fun j => verticalEdgeTraversalCount n row col r j) c hinside
  · let j := max cMax (c + 1)
    have hcj : c < j := lt_of_lt_of_le (lt_add_one c) (le_max_right cMax (c + 1))
    have hzero : rightRayCrossingCount n row col r j = 0 :=
      rightRayCrossingCount_eq_zero_of_col_ge n row col cMax r j hcol
        (le_max_left cMax (c + 1))
    refine ⟨j, hcj, ?_⟩
    rw [hzero]
    exact Nat.not_odd_zero
  · intro j
    simpa using rightRayCrossingCount_adjacent n row col r (j - 1)

end Ising2DLambda.KacWard
