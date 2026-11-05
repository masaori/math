import Ising2DLambda.KacWard.StandardDualHeight
import Ising2DLambda.NecSuf.KacWard.StandardDualHeight

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial Ising2DLambda.TransferMatrix

/-- 一般の横断関数へ実際の辺通過偶奇を入れた値は具体版と一致する。 -/
theorem standardDualHeight_from_necSuf (L m : ℕ) [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (cell : ZMod L × ZMod L) :
    standardDualHeight L m γ cell =
      Ising2DLambda.NecSuf.KacWard.standardDualHeight L
        (fun i j => walkBaseEdgeParity γ (edgeOfRow L false i j))
        (fun i j => walkBaseEdgeParity γ (edgeOfRow L true i j)) cell := rfl

/-- 縦方向の具体式は、横断関数の一般式へ実際の通過偶奇を代入したもの。 -/
theorem standardDualHeight_vertical_internal_from_necSuf (L m : ℕ) [NeZero L]
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
    standardDualHeight L m γ
        ((i : ZMod L), ((j + 1 : ℕ) : ZMod L)) =
      (standardDualHeight L m γ
        ((i : ZMod L), (j : ZMod L)) +
        walkBaseEdgeParity γ
          (edgeOfRow L true (i : ZMod L) ((j + 1 : ℕ) : ZMod L))) % 2 := by
  simpa only [← standardDualHeight_from_necSuf] using
    Ising2DLambda.NecSuf.KacWard.standardDualHeight_vertical_internal L
      (fun i j => walkBaseEdgeParity γ (edgeOfRow L false i j))
      (fun i j => walkBaseEdgeParity γ (edgeOfRow L true i j))
      i j hi hj hvertex

end Ising2DLambda.KacWard
