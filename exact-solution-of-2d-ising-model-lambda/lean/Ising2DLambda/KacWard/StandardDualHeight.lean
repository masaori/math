import Ising2DLambda.KacWard.WalkTwistSign
import Ising2DLambda.KacWard.CellSetBoundaryCoefficients

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial Ising2DLambda.TransferMatrix

/-- 向きを忘れた基底辺の通過を、重複を保って数えた後に二で割った余り。 -/
def walkBaseEdgeParity {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (edge : Edge L) : ℕ :=
  (∑ k : Fin (m + 1), if (γ k).1 = edge then 1 else 0) % 2

/-- 基点セルから列方向、次に行方向へ進む標準双対路の横断偶奇。 -/
def standardDualHeight (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (cell : ZMod L × ZMod L) : ℕ :=
  ((∑ c ∈ Finset.Icc 1 cell.2.val,
      walkBaseEdgeParity γ (edgeOfRow L true 0 (c : ZMod L))) +
    (∑ r ∈ Finset.Icc 1 cell.1.val,
      walkBaseEdgeParity γ (edgeOfRow L false (r : ZMod L) cell.2))) % 2

/-- 閉歩道の基底辺について、局所的な偶数次数から長方形の辺偶奇を得る。 -/
theorem rectangle_crossing_parity (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (i j : ℕ) (hi : i < L) (hj : j + 1 < L)
    (hvertex : ∀ r : ℕ, 1 ≤ r → r ≤ i →
      (walkBaseEdgeParity γ (edgeOfRow L false (r : ZMod L) (j : ZMod L)) +
        walkBaseEdgeParity γ
          (edgeOfRow L false (r : ZMod L) ((j + 1 : ℕ) : ZMod L)) +
        walkBaseEdgeParity γ
          (edgeOfRow L true ((r - 1 : ℕ) : ZMod L) ((j + 1 : ℕ) : ZMod L)) +
        walkBaseEdgeParity γ
          (edgeOfRow L true (r : ZMod L) ((j + 1 : ℕ) : ZMod L))) % 2 = 0) :
    ((∑ r ∈ Finset.Icc 1 i,
        walkBaseEdgeParity γ (edgeOfRow L false (r : ZMod L) (j : ZMod L))) +
      (∑ r ∈ Finset.Icc 1 i,
        walkBaseEdgeParity γ
          (edgeOfRow L false (r : ZMod L) ((j + 1 : ℕ) : ZMod L))) +
      walkBaseEdgeParity γ (edgeOfRow L true 0 ((j + 1 : ℕ) : ZMod L)) +
      walkBaseEdgeParity γ
        (edgeOfRow L true (i : ZMod L) ((j + 1 : ℕ) : ZMod L))) % 2 = 0 := by
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

/-- 横方向の内部一歩では、横切る辺の通過偶奇だけ高さが変わる。 -/
theorem standardDualHeight_horizontal_internal (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (i j : ℕ) (hi : i + 1 < L) (hj : j < L) :
    standardDualHeight L m γ
        (((i + 1 : ℕ) : ZMod L), (j : ZMod L)) =
      (standardDualHeight L m γ
        ((i : ZMod L), (j : ZMod L)) +
        walkBaseEdgeParity γ
          (edgeOfRow L false ((i + 1 : ℕ) : ZMod L) (j : ZMod L))) % 2 := by
  have hi0 : i < L := by omega
  simp only [standardDualHeight, ZMod.val_cast_of_lt hi,
    ZMod.val_cast_of_lt hi0, ZMod.val_cast_of_lt hj]
  rw [Finset.sum_Icc_succ_top (by omega : 1 ≤ i + 1)]
  omega

theorem standardDualHeight_horizontal_internal_changes (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (i j : ℕ) (hi : i + 1 < L) (hj : j < L) :
    (standardDualHeight L m γ
        (((i + 1 : ℕ) : ZMod L), (j : ZMod L)) ≠
      standardDualHeight L m γ ((i : ZMod L), (j : ZMod L))) ↔
    walkBaseEdgeParity γ
      (edgeOfRow L false ((i + 1 : ℕ) : ZMod L) (j : ZMod L)) = 1 := by
  rw [standardDualHeight_horizontal_internal L m γ i j hi hj]
  unfold standardDualHeight walkBaseEdgeParity
  omega

end Ising2DLambda.KacWard
