/-
具体版が必要十分版の特殊化として得られることの導出。

訪問頂点ごとの内側セル弧と、隣接する弧の共通セルを有限鎖の補題へ渡す。
-/
import Ising2DLambda.KacWard.WalkSideInteriorBandConnected
import Ising2DLambda.NecSuf.KacWard.WalkSideInteriorBandConnected

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

theorem cellEdgeAdjacent_from_necSuf (p q : ℤ × ℤ) :
    CellEdgeAdjacent p q ↔
      Ising2DLambda.NecSuf.KacWard.cellEdgeAdjacent
        (fun p q : ℤ × ℤ =>
          q.1 = p.1 ∧ (q.2 = p.2 - 1 ∨ q.2 = p.2 + 1))
        (fun p q : ℤ × ℤ =>
          q.2 = p.2 ∧ (q.1 = p.1 - 1 ∨ q.1 = p.1 + 1)) p q :=
  Iff.rfl

theorem edgeConnectedCellSet_from_necSuf (S : Set (ℤ × ℤ)) :
    EdgeConnectedCellSet S ↔
      Ising2DLambda.NecSuf.KacWard.ConnectedBy
        (Ising2DLambda.NecSuf.KacWard.cellEdgeAdjacent
          (fun p q : ℤ × ℤ =>
            q.1 = p.1 ∧ (q.2 = p.2 - 1 ∨ q.2 = p.2 + 1))
          (fun p q : ℤ × ℤ =>
            q.2 = p.2 ∧ (q.1 = p.1 - 1 ∨ q.1 = p.1 + 1))) S :=
  Iff.rfl

theorem walkSideInteriorBandFromWalk_from_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0) :
    walkSideInteriorBandFromWalk γ hγ hh hv =
      Ising2DLambda.NecSuf.KacWard.walkSideBand Finset.univ
        (oddRayInteriorCellsOfWalk γ hγ hh hv)
        (fun (k : Fin (m + 1)) (p : ℤ × ℤ) =>
          let P := planeLift γ k.castSucc
          p = (P.1 - 1, P.2 - 1) ∨ p = (P.1 - 1, P.2) ∨
          p = P ∨ p = (P.1, P.2 - 1)) := by
  ext p
  simp only [walkSideInteriorBandFromWalk,
    Ising2DLambda.NecSuf.KacWard.walkSideBand, Finset.mem_univ,
    true_and, Set.mem_setOf_eq]

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
