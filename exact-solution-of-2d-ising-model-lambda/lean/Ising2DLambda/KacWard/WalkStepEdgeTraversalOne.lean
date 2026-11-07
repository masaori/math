/-
各単位歩が通る平面の辺の通過回数は、辺単純性の下で一である。
歩自身が和の一項を与えることと、局所的な高々一回を合わせる。
-/
import Ising2DLambda.KacWard.AdjacentCellsBoundaryParity
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- 歩の第 `k` 辺は、その通過回数の和に一を寄与する。 -/
theorem walkStep_edgeTraversal_one
    (n : ℕ) (row col : ℕ → ℤ) (k : ℕ) (hk : k < n)
    (hunit : IsUnitGridWalk n row col)
    (hlocal :
      verticalEdgeTraversalCount n row col (row k - 1) (col k) ≤ 1 ∧
      verticalEdgeTraversalCount n row col (row k) (col k) ≤ 1 ∧
      horizontalEdgeTraversalCount n row col (row k) (col k - 1) ≤ 1 ∧
      horizontalEdgeTraversalCount n row col (row k) (col k) ≤ 1) :
    (row (k + 1) = row k + 1 ∧ col (k + 1) = col k ∧
      verticalEdgeTraversalCount n row col (row k) (col k) = 1) ∨
    (row (k + 1) = row k - 1 ∧ col (k + 1) = col k ∧
      verticalEdgeTraversalCount n row col (row k - 1) (col k) = 1) ∨
    (row (k + 1) = row k ∧ col (k + 1) = col k + 1 ∧
      horizontalEdgeTraversalCount n row col (row k) (col k) = 1) ∨
    (row (k + 1) = row k ∧ col (k + 1) = col k - 1 ∧
      horizontalEdgeTraversalCount n row col (row k) (col k - 1) = 1) := by
  have hcontribution (f : ℕ → ℕ) (hf : f k = 1) :
      0 < ∑ i ∈ Finset.range n, f i := by
    have hle := Finset.single_le_sum (fun i hi => Nat.zero_le (f i))
      (Finset.mem_range.mpr hk)
    omega
  rcases hunit k hk with h | h | h | h
  · left
    refine ⟨h.1, h.2, ?_⟩
    have hp : 0 < verticalEdgeTraversalCount n row col (row k) (col k) := by
      unfold verticalEdgeTraversalCount
      apply hcontribution
      simp [crossesRowLevel, h]
    omega
  · right; left
    refine ⟨h.1, h.2, ?_⟩
    have hp : 0 < verticalEdgeTraversalCount n row col (row k - 1) (col k) := by
      unfold verticalEdgeTraversalCount
      apply hcontribution
      simp [crossesRowLevel, h]
    omega
  · right; right; left
    refine ⟨h.1, h.2, ?_⟩
    have hp : 0 < horizontalEdgeTraversalCount n row col (row k) (col k) := by
      unfold horizontalEdgeTraversalCount
      apply hcontribution
      simp [crossesColLevel, h]
    omega
  · right; right; right
    refine ⟨h.1, h.2, ?_⟩
    have hp : 0 < horizontalEdgeTraversalCount n row col (row k) (col k - 1) := by
      unfold horizontalEdgeTraversalCount
      apply hcontribution
      simp [crossesColLevel, h]
    omega

end Ising2DLambda.KacWard
