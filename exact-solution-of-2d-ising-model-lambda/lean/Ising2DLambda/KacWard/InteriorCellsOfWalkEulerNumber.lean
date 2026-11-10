import Ising2DLambda.KacWard.CellEulerNumberFromEvenEdgeCounts
import Ising2DLambda.KacWard.OddRayInteriorCellsFromWalkFinite
import Ising2DLambda.KacWard.InteriorCellSetEdgeConnected
import Ising2DLambda.KacWard.ExteriorCellReachesOuterCoreFromWalk

namespace Ising2DLambda.KacWard

/-- The interior cells of an actual simple zero-winding closed walk satisfy the
cell Euler identity. -/
theorem interiorCellsOfWalk_eulerNumber_eq_one {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (hdistinct : Function.Injective
      (fun i : Fin (m + 1) => planeLift γ i.castSucc)) :
    cellEulerNumber (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset = 1 := by
  let S := oddRayInteriorCellsOfWalk γ hγ hh hv
  have hfinite : S.Finite := oddRayInteriorCellsOfWalk_finite γ hγ hh hv
  have hinside := interiorCellSetOfWalk_nonempty_edgeConnected γ hγ hh hv hdistinct
  have houtside := exteriorCellSetOfWalk_nonempty_edgeConnected γ hγ hh hv hdistinct
  have hset : (hfinite.toFinset : Set GridCell) = S := Set.Finite.coe_toFinset hfinite
  apply cellEulerNumber_eq_one_of_actual_even_edge_counts
  · obtain ⟨x, hx⟩ := hinside.1
    exact ⟨x, by simpa only [Set.Finite.mem_toFinset] using hx⟩
  · simpa only [hset] using hinside.2
  · simpa only [hset] using houtside.2

end Ising2DLambda.KacWard
