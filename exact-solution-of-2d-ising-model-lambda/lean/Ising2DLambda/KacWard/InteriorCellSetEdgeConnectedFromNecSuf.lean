/-
具体版が必要十分版の特殊化として得られることの導出。

歩道沿いの内側帯を核とし、各内側セルから帯へ至る有限列を必要十分版へ渡す。
-/
import Ising2DLambda.KacWard.InteriorCellSetEdgeConnected
import Ising2DLambda.NecSuf.KacWard.InteriorCellSetEdgeConnected

namespace Ising2DLambda.KacWard

/-- `claim_interior_cell_set_edge_connected` を必要十分版から導く。 -/
theorem interiorCellSet_nonempty_edgeConnected_from_necSuf {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (hdistinct : Function.Injective
      (fun i : Fin (m + 1) => planeLift γ i.castSucc)) :
    (oddRayInteriorCellsOfWalk γ hγ hh hv).Nonempty ∧
      Ising2DLambda.NecSuf.KacWard.ConnectedBy CellEdgeAdjacent
        (oddRayInteriorCellsOfWalk γ hγ hh hv) := by
  have hband := walkSideInteriorBandFromWalk_nonempty_edgeConnected γ hγ hh hv hdistinct
  exact Ising2DLambda.NecSuf.KacWard.connected_of_connected_core_and_reaches_necSuf
    CellEdgeAdjacent cellEdgeAdjacent_symmetric
    (oddRayInteriorCellsOfWalk γ hγ hh hv) (walkSideInteriorBandFromWalk γ hγ hh hv)
    hband.1 (fun _ hp => hp.1) hband.2
    (fun ⟨r, c⟩ hinside => interiorCellOfWalk_reaches_band γ hγ hh hv r c hinside)

end Ising2DLambda.KacWard
