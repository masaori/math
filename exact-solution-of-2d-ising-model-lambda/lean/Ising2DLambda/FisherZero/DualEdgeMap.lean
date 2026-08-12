/-
「双対辺写像は全単射である」の具体版。
人手証明と同じく、横向き辺 `(i,j)` を縦向き辺 `(i,j+1)` へ、
縦向き辺 `(i,j)` を横向き辺 `(i+1,j)` へ送り、逆写像を明示する。
-/
import Ising2DLambda.TransferMatrix.Basic

namespace Ising2DLambda.FisherZero

open Ising2DLambda.PartitionPolynomial Ising2DLambda.TransferMatrix

private abbrev EdgeCoordinates (L : ℕ) :=
  (ZMod L × ZMod L) ⊕ (ZMod L × ZMod L)

/-- 辺の向きを交換し、交差する双対辺の座標へ送る全単射。 -/
def dualEdgeCoordinatesEquiv (L : ℕ) : EdgeCoordinates L ≃ EdgeCoordinates L where
  toFun
    | Sum.inl (i, j) => Sum.inr (i, j + 1)
    | Sum.inr (i, j) => Sum.inl (i + 1, j)
  invFun
    | Sum.inl (i, j) => Sum.inr (i - 1, j)
    | Sum.inr (i, j) => Sum.inl (i, j - 1)
  left_inv := by
    rintro (⟨i, j⟩ | ⟨i, j⟩) <;> simp
  right_inv := by
    rintro (⟨i, j⟩ | ⟨i, j⟩) <;> simp

/-- 正方格子の各辺を、それと交差する双対辺へ送る全単射 `\delta_L`。 -/
noncomputable def dualEdgeEquiv (L : ℕ) [NeZero L] : Edge L ≃ Edge L :=
  (edgeEquiv L).symm.trans ((dualEdgeCoordinatesEquiv L).trans (edgeEquiv L))

/-- `claim_dual_edge_map_bijective` の具体版。 -/
theorem dualEdgeEquiv_bijective (L : ℕ) [NeZero L] :
    Function.Bijective (dualEdgeEquiv L) :=
  (dualEdgeEquiv L).bijective

end Ising2DLambda.FisherZero
