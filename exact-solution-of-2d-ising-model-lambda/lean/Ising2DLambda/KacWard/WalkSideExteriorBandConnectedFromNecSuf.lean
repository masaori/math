/-
具体版が必要十分版の特殊化として得られることの導出。

訪問頂点ごとの外側セル弧と、隣接する弧の共通セルを有限鎖の補題へ渡す。
-/
import Ising2DLambda.KacWard.ExteriorCellReachesOuterCoreFromWalk
import Ising2DLambda.KacWard.WalkSideExteriorBandConnected
import Ising2DLambda.NecSuf.KacWard.WalkSideInteriorBandConnected

namespace Ising2DLambda.KacWard

theorem walkSideExteriorBandFromWalk_from_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0) :
    walkSideExteriorBandFromWalk γ hγ hh hv =
      Ising2DLambda.NecSuf.KacWard.walkSideBand Finset.univ
        (oddRayInteriorCellsOfWalk γ hγ hh hv)ᶜ
        (fun (k : Fin (m + 1)) (p : ℤ × ℤ) =>
          let P := planeLift γ k.castSucc
          p = (P.1 - 1, P.2 - 1) ∨ p = (P.1 - 1, P.2) ∨
          p = P ∨ p = (P.1, P.2 - 1)) := by
  ext p
  simp only [walkSideExteriorBandFromWalk,
    Ising2DLambda.NecSuf.KacWard.walkSideBand, Finset.mem_univ,
    true_and, Set.mem_compl_iff, Set.mem_setOf_eq]

/-- `claim_walk_side_exterior_band_edge_connected` を必要十分版から導く。 -/
theorem walkSideExteriorBand_nonempty_edgeConnected_from_necSuf {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (hdistinct : Function.Injective
      (fun i : Fin (m + 1) => planeLift γ i.castSucc)) :
    (walkSideExteriorBandFromWalk γ hγ hh hv).Nonempty ∧
      Ising2DLambda.NecSuf.KacWard.ConnectedBy CellEdgeAdjacent
        (walkSideExteriorBandFromWalk γ hγ hh hv) :=
  walkSideExteriorBandFromWalk_nonempty_edgeConnected γ hγ hh hv hdistinct

end Ising2DLambda.KacWard
