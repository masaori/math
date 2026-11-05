import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- 二方向の横断偶奇を入力した標準双対路の高さ。 -/
def standardDualHeight (L : ℕ) [NeZero L]
    (horizontalCross verticalCross : ZMod L → ZMod L → ℕ)
    (cell : ZMod L × ZMod L) : ℕ :=
  ((∑ c ∈ Finset.Icc 1 cell.2.val, verticalCross 0 (c : ZMod L)) +
    (∑ r ∈ Finset.Icc 1 cell.1.val, horizontalCross (r : ZMod L) cell.2)) % 2

/-- 標準双対路の横方向の内部一歩では、横辺の末項だけが加わる。 -/
theorem standardDualHeight_horizontal_internal (L : ℕ) [NeZero L]
    (horizontalCross verticalCross : ZMod L → ZMod L → ℕ)
    (i j : ℕ) (hi : i + 1 < L) (hj : j < L) :
    standardDualHeight L horizontalCross verticalCross
        (((i + 1 : ℕ) : ZMod L), (j : ZMod L)) =
      (standardDualHeight L horizontalCross verticalCross
        ((i : ZMod L), (j : ZMod L)) +
        horizontalCross ((i + 1 : ℕ) : ZMod L) (j : ZMod L)) % 2 := by
  have hi0 : i < L := by omega
  simp only [standardDualHeight, ZMod.val_cast_of_lt hi,
    ZMod.val_cast_of_lt hi0, ZMod.val_cast_of_lt hj]
  rw [Finset.sum_Icc_succ_top (by omega : 1 ≤ i + 1)]
  omega

theorem standardDualHeight_horizontal_internal_changes (L : ℕ) [NeZero L]
    (horizontalCross verticalCross : ZMod L → ZMod L → ℕ)
    (i j : ℕ) (hi : i + 1 < L) (hj : j < L) :
    (standardDualHeight L horizontalCross verticalCross
        (((i + 1 : ℕ) : ZMod L), (j : ZMod L)) ≠
      standardDualHeight L horizontalCross verticalCross
        ((i : ZMod L), (j : ZMod L))) ↔
    horizontalCross ((i + 1 : ℕ) : ZMod L) (j : ZMod L) % 2 = 1 := by
  rw [standardDualHeight_horizontal_internal L horizontalCross verticalCross i j hi hj]
  unfold standardDualHeight
  omega

end Ising2DLambda.NecSuf.KacWard
