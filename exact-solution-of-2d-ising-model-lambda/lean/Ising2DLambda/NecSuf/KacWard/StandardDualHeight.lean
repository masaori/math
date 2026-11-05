import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- 二方向の横断偶奇を入力した標準双対路の高さ。 -/
def standardDualHeight (L : ℕ) [NeZero L]
    (horizontalCross verticalCross : ZMod L → ZMod L → ℕ)
    (cell : ZMod L × ZMod L) : ℕ :=
  ((∑ c ∈ Finset.Icc 1 cell.2.val, verticalCross 0 (c : ZMod L)) +
    (∑ r ∈ Finset.Icc 1 cell.1.val, horizontalCross (r : ZMod L) cell.2)) % 2

/-- 各頂点で四辺の通過和が偶数なら、長方形の対向辺の偶奇は一致する。 -/
theorem rectangle_crossing_parity (L : ℕ) [NeZero L]
    (horizontalCross verticalCross : ZMod L → ZMod L → ℕ)
    (i j : ℕ) (hi : i < L) (hj : j + 1 < L)
    (hvertex : ∀ r : ℕ, 1 ≤ r → r ≤ i →
      (horizontalCross (r : ZMod L) (j : ZMod L) +
        horizontalCross (r : ZMod L) ((j + 1 : ℕ) : ZMod L) +
        verticalCross ((r - 1 : ℕ) : ZMod L) ((j + 1 : ℕ) : ZMod L) +
        verticalCross (r : ZMod L) ((j + 1 : ℕ) : ZMod L)) % 2 = 0) :
    ((∑ r ∈ Finset.Icc 1 i,
        horizontalCross (r : ZMod L) (j : ZMod L)) +
      (∑ r ∈ Finset.Icc 1 i,
        horizontalCross (r : ZMod L) ((j + 1 : ℕ) : ZMod L)) +
      verticalCross (0 : ZMod L) ((j + 1 : ℕ) : ZMod L) +
      verticalCross (i : ZMod L) ((j + 1 : ℕ) : ZMod L)) % 2 = 0 := by
  induction i with
  | zero => simp; omega
  | succ i ih =>
      have hi0 : i < L := by omega
      have hprev := ih hi0 (fun r hr1 hri => hvertex r hr1 (by omega))
      have hlast := hvertex (i + 1) (by omega) (by omega)
      rw [Finset.sum_Icc_succ_top (by omega : 1 ≤ i + 1)]
      rw [Finset.sum_Icc_succ_top (by omega : 1 ≤ i + 1)]
      have hcast : ((i + 1 - 1 : ℕ) : ZMod L) = (i : ZMod L) := by simp
      rw [hcast] at hlast
      omega

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

/-- 必要なのは、二方向の横断数の局所偶奇だけである。 -/
theorem standardDualHeight_vertical_internal (L : ℕ) [NeZero L]
    (horizontalCross verticalCross : ZMod L → ZMod L → ℕ)
    (i j : ℕ) (hi : i < L) (hj : j + 1 < L)
    (hvertex : ∀ r : ℕ, 1 ≤ r → r ≤ i →
      (horizontalCross (r : ZMod L) (j : ZMod L) +
        horizontalCross (r : ZMod L) ((j + 1 : ℕ) : ZMod L) +
        verticalCross ((r - 1 : ℕ) : ZMod L) ((j + 1 : ℕ) : ZMod L) +
        verticalCross (r : ZMod L) ((j + 1 : ℕ) : ZMod L)) % 2 = 0) :
    standardDualHeight L horizontalCross verticalCross
        ((i : ZMod L), ((j + 1 : ℕ) : ZMod L)) =
      (standardDualHeight L horizontalCross verticalCross
        ((i : ZMod L), (j : ZMod L)) +
        verticalCross (i : ZMod L) ((j + 1 : ℕ) : ZMod L)) % 2 := by
  have hrect := rectangle_crossing_parity L horizontalCross verticalCross i j hi hj hvertex
  have hj0 : j < L := by omega
  simp only [standardDualHeight, ZMod.val_cast_of_lt hi,
    ZMod.val_cast_of_lt hj, ZMod.val_cast_of_lt hj0]
  rw [Finset.sum_Icc_succ_top (by omega : 1 ≤ j + 1)]
  omega

theorem standardDualHeight_vertical_internal_changes (L : ℕ) [NeZero L]
    (horizontalCross verticalCross : ZMod L → ZMod L → ℕ)
    (i j : ℕ) (hi : i < L) (hj : j + 1 < L)
    (hvertex : ∀ r : ℕ, 1 ≤ r → r ≤ i →
      (horizontalCross (r : ZMod L) (j : ZMod L) +
        horizontalCross (r : ZMod L) ((j + 1 : ℕ) : ZMod L) +
        verticalCross ((r - 1 : ℕ) : ZMod L) ((j + 1 : ℕ) : ZMod L) +
        verticalCross (r : ZMod L) ((j + 1 : ℕ) : ZMod L)) % 2 = 0) :
    (standardDualHeight L horizontalCross verticalCross
        ((i : ZMod L), ((j + 1 : ℕ) : ZMod L)) ≠
      standardDualHeight L horizontalCross verticalCross
        ((i : ZMod L), (j : ZMod L))) ↔
    verticalCross (i : ZMod L) ((j + 1 : ℕ) : ZMod L) % 2 = 1 := by
  rw [standardDualHeight_vertical_internal L horizontalCross verticalCross i j hi hj hvertex]
  unfold standardDualHeight
  omega

end Ising2DLambda.NecSuf.KacWard
