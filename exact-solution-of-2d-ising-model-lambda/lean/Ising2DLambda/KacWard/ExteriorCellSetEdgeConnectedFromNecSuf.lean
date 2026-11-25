/-
具体版が必要十分版の特殊化として得られることの導出。

外接長方形の外側と歩道沿いの外側帯を二つの核として必要十分版へ渡す。
-/
import Ising2DLambda.KacWard.ExteriorCellReachesOuterCoreFromWalk
import Ising2DLambda.NecSuf.KacWard.WalkSideInteriorBandConnected

namespace Ising2DLambda.KacWard

/-- `claim_exterior_cell_set_edge_connected` を必要十分版から導く。 -/
theorem exteriorCellSet_nonempty_edgeConnected_from_necSuf {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (hdistinct : Function.Injective
      (fun i : Fin (m + 1) => planeLift γ i.castSucc)) :
    ((oddRayInteriorCellsOfWalk γ hγ hh hv)ᶜ).Nonempty ∧
      Ising2DLambda.NecSuf.KacWard.ConnectedBy CellEdgeAdjacent
        (oddRayInteriorCellsOfWalk γ hγ hh hv)ᶜ :=
  exteriorCellSetOfWalk_nonempty_edgeConnected γ hγ hh hv hdistinct

end Ising2DLambda.KacWard
