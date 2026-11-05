import Mathlib
import Ising2DLambda.NecSuf.KacWard.ClosedWalkIncidenceParity

namespace Ising2DLambda.NecSuf.KacWard

/-- The only combinatorial input is the four-position incidence identity for each edge. -/
theorem closedWalk_four_edge_parity {E B V : Type*} [DecidableEq B] [DecidableEq V]
    {m : ℕ} (γ : Fin (m + 1) → E) (base : E → B) (source target : E → V)
    (first second third fourth : B) (v : V)
    (hstep : ∀ k : Fin m, target (γ (Fin.castSucc k)) = source (γ (Fin.succ k)))
    (hclose : target (γ (Fin.last m)) = source (γ 0))
    (hlocal : ∀ e : E,
      ((if base e = first then 1 else 0) +
        (if base e = second then 1 else 0) +
        (if base e = third then 1 else 0) +
        (if base e = fourth then 1 else 0)) =
        (if source e = v then 1 else 0) +
          (if target e = v then 1 else 0)) :
    (((∑ k : Fin (m + 1), if base (γ k) = first then 1 else 0) % 2) +
      ((∑ k : Fin (m + 1), if base (γ k) = second then 1 else 0) % 2) +
      ((∑ k : Fin (m + 1), if base (γ k) = third then 1 else 0) % 2) +
      ((∑ k : Fin (m + 1), if base (γ k) = fourth then 1 else 0) % 2)) % 2 = 0 := by
  have hsum :
      (∑ k : Fin (m + 1), if base (γ k) = first then 1 else 0) +
      (∑ k : Fin (m + 1), if base (γ k) = second then 1 else 0) +
      (∑ k : Fin (m + 1), if base (γ k) = third then 1 else 0) +
      (∑ k : Fin (m + 1), if base (γ k) = fourth then 1 else 0) =
      ∑ k : Fin (m + 1),
        ((if source (γ k) = v then 1 else 0) +
          (if target (γ k) = v then 1 else 0)) := by
    rw [← Finset.sum_add_distrib, ← Finset.sum_add_distrib,
      ← Finset.sum_add_distrib]
    exact Finset.sum_congr rfl (fun k _ => hlocal (γ k))
  have heven := closedWalk_incidence_even γ source target hstep hclose v
  omega

/-- 二方向の横断偶奇を入力した標準双対路の高さ。 -/
def standardDualHeight (L : ℕ) [NeZero L]
    (horizontalCross verticalCross : ZMod L → ZMod L → ℕ)
    (cell : ZMod L × ZMod L) : ℕ :=
  ((∑ c ∈ Finset.Icc 1 cell.2.val, verticalCross 0 (c : ZMod L)) +
    (∑ r ∈ Finset.Icc 1 cell.1.val, horizontalCross (r : ZMod L) cell.2)) % 2

/-- 頂点の四辺の偶奇が零なら、横辺の全行和の偶奇は隣の列で一致する。 -/
theorem horizontalCross_column_parity_invariant (L : ℕ) [NeZero L]
    (horizontalCross verticalCross : ZMod L → ZMod L → ℕ)
    (j : ZMod L)
    (hvertex : ∀ i : ZMod L,
      (horizontalCross i j + horizontalCross i (j + 1) +
        verticalCross (i - 1) (j + 1) + verticalCross i (j + 1)) % 2 = 0) :
    (∑ i : ZMod L, horizontalCross i j) % 2 =
      (∑ i : ZMod L, horizontalCross i (j + 1)) % 2 := by
  let e : ZMod L ≃ ZMod L := Equiv.addRight (-1)
  have hshift : (∑ i : ZMod L, verticalCross (i - 1) (j + 1)) =
      ∑ i : ZMod L, verticalCross i (j + 1) := by
    exact Fintype.sum_equiv e _ _ (by intro i; simp [e, sub_eq_add_neg])
  have hsum :
      (∑ i : ZMod L,
        (horizontalCross i j + horizontalCross i (j + 1) +
          verticalCross (i - 1) (j + 1) + verticalCross i (j + 1))) % 2 = 0 := by
    rw [Finset.sum_nat_mod]
    simp [hvertex]
  simp only [Finset.sum_add_distrib] at hsum
  rw [hshift] at hsum
  omega

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

/-- 四辺の偶奇を閉歩道から得た後に、縦方向の高さ差へ代入する。 -/
theorem closedWalk_standardDualHeight_vertical_internal (L : ℕ) [NeZero L]
    (horizontalCross verticalCross : ZMod L → ZMod L → ℕ)
    (i j : ℕ) (hi : i < L) (hj : j + 1 < L)
    (hfour : ∀ r : ℕ, 1 ≤ r → r ≤ i →
      (horizontalCross (r : ZMod L) ((j + 1 : ℕ) : ZMod L) +
        horizontalCross (r : ZMod L) (j : ZMod L) +
        verticalCross (r : ZMod L) ((j + 1 : ℕ) : ZMod L) +
        verticalCross ((r - 1 : ℕ) : ZMod L) ((j + 1 : ℕ) : ZMod L)) % 2 = 0) :
    standardDualHeight L horizontalCross verticalCross
        ((i : ZMod L), ((j + 1 : ℕ) : ZMod L)) =
      (standardDualHeight L horizontalCross verticalCross
        ((i : ZMod L), (j : ZMod L)) +
        verticalCross (i : ZMod L) ((j + 1 : ℕ) : ZMod L)) % 2 := by
  apply standardDualHeight_vertical_internal L horizontalCross verticalCross i j hi hj
  intro r hr1 hri
  have h := hfour r hr1 hri
  omega

/-- 全周偶奇だけを入力とする、横方向の切断線での高さ差。 -/
theorem standardDualHeight_horizontal_seam_of_line_parity (L : ℕ) [NeZero L]
    (horizontalCross verticalCross : ZMod L → ZMod L → ℕ)
    (j : ℕ) (hL : 2 ≤ L) (hj : j < L)
    (hline :
      ((∑ r ∈ Finset.Icc 1 (L - 1), horizontalCross (r : ZMod L) (j : ZMod L)) +
        horizontalCross 0 (j : ZMod L)) % 2 = 0) :
    standardDualHeight L horizontalCross verticalCross (0, (j : ZMod L)) =
      (standardDualHeight L horizontalCross verticalCross
          (((L - 1 : ℕ) : ZMod L), (j : ZMod L)) +
        horizontalCross 0 (j : ZMod L)) % 2 := by
  have hlast : L - 1 < L := by omega
  simp only [standardDualHeight, ZMod.val_zero,
    ZMod.val_cast_of_lt hlast, ZMod.val_cast_of_lt hj]
  simp only [Finset.Icc_eq_empty_of_lt (by omega : 0 < 1), Finset.sum_empty, Nat.add_zero]
  omega

theorem standardDualHeight_horizontal_seam_changes_of_line_parity (L : ℕ) [NeZero L]
    (horizontalCross verticalCross : ZMod L → ZMod L → ℕ)
    (j : ℕ) (hL : 2 ≤ L) (hj : j < L)
    (hline :
      ((∑ r ∈ Finset.Icc 1 (L - 1), horizontalCross (r : ZMod L) (j : ZMod L)) +
        horizontalCross 0 (j : ZMod L)) % 2 = 0) :
    (standardDualHeight L horizontalCross verticalCross (0, (j : ZMod L)) ≠
      standardDualHeight L horizontalCross verticalCross
        (((L - 1 : ℕ) : ZMod L), (j : ZMod L))) ↔
    horizontalCross 0 (j : ZMod L) % 2 = 1 := by
  rw [standardDualHeight_horizontal_seam_of_line_parity L horizontalCross verticalCross
    j hL hj hline]
  unfold standardDualHeight
  omega

end Ising2DLambda.NecSuf.KacWard
