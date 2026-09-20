/-
章「Onsager 閉形式への接続」の「内側セルは行に沿って奇数回通過の縦辺まで届く」の具体版。

人手証明と同じく、開始セルの右側にある外側セルの列座標から最小のものを取る。
その直前までは内側であり、隣接セルの交差数の等式から境界の縦辺の通過回数が奇数になる。
-/
import Ising2DLambda.KacWard.AdjacentCellsBoundaryParity
import Mathlib.Data.Int.LeastGreatest
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- `claim_interior_cells_reach_odd_vertical_edge` の具体版。 -/
theorem interiorCells_reachOddVerticalEdge
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
  let P : ℤ → Prop := fun j =>
    c < j ∧ ¬ Odd (rightRayCrossingCount n row col r j)
  have houtside : ∃ j : ℤ, P j := by
    let j := max cMax (c + 1)
    have hcj : c < j := lt_of_lt_of_le (lt_add_one c) (le_max_right cMax (c + 1))
    have hzero : rightRayCrossingCount n row col r j = 0 :=
      rightRayCrossingCount_eq_zero_of_col_ge n row col cMax r j hcol
        (le_max_left cMax (c + 1))
    refine ⟨j, hcj, ?_⟩
    rw [hzero]
    exact Nat.not_odd_zero
  have hbounded : ∃ b : ℤ, ∀ j : ℤ, P j → b ≤ j := by
    refine ⟨c + 1, ?_⟩
    intro j hj
    exact Int.add_one_le_iff.mpr hj.1
  obtain ⟨g, hgP, hgmin⟩ := Int.exists_least_of_bdd hbounded houtside
  have hinterior : ∀ j : ℤ, c ≤ j → j < g →
      Odd (rightRayCrossingCount n row col r j) := by
    intro j hcj hjg
    by_cases hjc : j = c
    · simpa [hjc] using hinside
    · have hcj' : c < j := lt_of_le_of_ne hcj (Ne.symm hjc)
      by_contra hjodd
      have hjP : P j := ⟨hcj', hjodd⟩
      exact (not_le_of_gt hjg) (hgmin j hjP)
  have hprevious : Odd (rightRayCrossingCount n row col r (g - 1)) := by
    apply hinterior (g - 1)
    · omega
    · omega
  have hcurrentEven : Even (rightRayCrossingCount n row col r g) :=
    Nat.not_odd_iff_even.mp hgP.2
  have hsplit : rightRayCrossingCount n row col r (g - 1) =
      rightRayCrossingCount n row col r g +
        verticalEdgeTraversalCount n row col r g := by
    simpa using rightRayCrossingCount_adjacent n row col r (g - 1)
  have hedgeOdd : Odd (verticalEdgeTraversalCount n row col r g) := by
    rcases hprevious with ⟨q, hq⟩
    rcases hcurrentEven with ⟨t, ht⟩
    refine ⟨q - t, ?_⟩
    omega
  have hedgePos : 0 < verticalEdgeTraversalCount n row col r g := by
    rcases hedgeOdd with ⟨q, hq⟩
    omega
  exact ⟨g, hgP.1, hinterior, hgP.2, hedgeOdd, hedgePos⟩

end Ising2DLambda.KacWard
