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

end Ising2DLambda.KacWard
