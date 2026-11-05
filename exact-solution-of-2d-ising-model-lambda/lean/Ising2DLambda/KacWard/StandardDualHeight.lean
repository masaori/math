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

end Ising2DLambda.KacWard
