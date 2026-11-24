/-
具体版が必要十分版の特殊化として得られることの導出。

訪問頂点ごとの内側セル弧と、隣接する弧の共通セルを有限鎖の補題へ渡す。
-/
import Ising2DLambda.KacWard.WalkSideInteriorBandConnected

namespace Ising2DLambda.KacWard

/-- `claim_walk_side_interior_band_edge_connected` を必要十分版から導く。 -/
theorem walkSideInteriorBand_nonempty_edgeConnected_from_necSuf {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (hdistinct : Function.Injective
      (fun i : Fin (m + 1) => planeLift γ i.castSucc)) :
    (walkSideInteriorBandFromWalk γ hγ hh hv).Nonempty ∧
      Ising2DLambda.NecSuf.KacWard.ConnectedBy CellEdgeAdjacent
        (walkSideInteriorBandFromWalk γ hγ hh hv) :=
  walkSideInteriorBandFromWalk_nonempty_edgeConnected γ hγ hh hv hdistinct

end Ising2DLambda.KacWard
