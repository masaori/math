import Ising2DLambda.KacWard.CellEulerNumberFromEvenEdgeCounts
import Ising2DLambda.KacWard.CellVertexIncidenceCount
import Ising2DLambda.KacWard.OddRayInteriorCellsFromWalkFinite
import Ising2DLambda.KacWard.InteriorCellSetEdgeConnected
import Ising2DLambda.KacWard.ExteriorCellReachesOuterCoreFromWalk
import Ising2DLambda.KacWard.OneSidedClosureProjectionWindingFromWalk

namespace Ising2DLambda.KacWard

/-- Count incidences between the four edges of each interior cell and the
edges of the actual closed walk's interior cell complex. -/
theorem interiorCellsOfWalk_edgeIncidence_sum {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0) :
    let cells := (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset
    (∑ e ∈ cellEdges cells,
      (cells.filter (fun x => e ∈ edgesOfCell x)).card) = 4 * cells.card := by
  classical
  dsimp only
  let cells := (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset
  change (∑ e ∈ cellEdges cells,
    (cells.filter (fun x => e ∈ edgesOfCell x)).card) = 4 * cells.card
  calc
    (∑ e ∈ cellEdges cells,
      (cells.filter (fun x => e ∈ edgesOfCell x)).card) =
        ∑ e ∈ cellEdges cells, ∑ x ∈ cells,
          if e ∈ edgesOfCell x then 1 else 0 := by
            simp only [Finset.card_filter]
    _ = ∑ x ∈ cells, ∑ e ∈ cellEdges cells,
          if e ∈ edgesOfCell x then 1 else 0 := by
            rw [Finset.sum_comm]
    _ = ∑ x ∈ cells, (edgesOfCell x).card := by
          apply Finset.sum_congr rfl
          intro x hx
          rw [← Finset.sum_subset (show edgesOfCell x ⊆ cellEdges cells by
            intro e he
            exact Finset.mem_biUnion.mpr ⟨x, hx, he⟩)]
          · simp
          · intro e he hex
            simp [hex]
    _ = 4 * cells.card := by
          have hcard (x : GridCell) : (edgesOfCell x).card = 4 := by
            rcases x with ⟨r, c⟩
            simp [edgesOfCell]
          simp [hcard, mul_comm]

/-- Count vertex incidences in the interior cells of an actual closed walk. -/
theorem interiorCellsOfWalk_vertexIncidence_sum {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0) :
    let cells := (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset
    (∑ v ∈ cellVertices cells, vertexCellIncidenceCount cells v) = 4 * cells.card := by
  exact cellVertexIncidence_sum _

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

/-- The Euler identity applies to the interior cells of the actual one-sided
closure, with the cut point shared by simplicity and zero winding. -/
theorem oneSidedClosureProjectionFromWalk_interior_eulerNumber_eq_one
    {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hcontact : contactPairCount γ hγ = 0)
    (hwind : (horizontalDirectedWindingNumber γ,
      verticalDirectedWindingNumber γ) ≠ (0, 0)) :
    ∃ k₀ : ℤ, ∀ t c : ℕ, 0 < t → 0 < c →
      let W := oneSidedClosurePoint (m + 1) L (planeLiftIntegerBase γ)
        (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) k₀ t c
      let N := oneSidedClosureLength (m + 1) L
        (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) t c
      let Γ : Fin (N - 1 + 1) → OrientedEdge L := fun j =>
        projectedUnitStep L (W j.val) (W (j.val + 1) - W j.val)
      ∃ (hΓ : closedNonbacktrackingWalk Γ)
        (hh : horizontalDirectedWindingNumber Γ = 0)
        (hv : verticalDirectedWindingNumber Γ = 0),
        cellEulerNumber (oddRayInteriorCellsOfWalk_finite Γ hΓ hh hv).toFinset = 1 := by
  obtain ⟨k₀, hsimpleZero⟩ :=
    oneSidedClosureProjectionFromWalk_simple_zero_winding γ hγ hcontact hwind
  refine ⟨k₀, ?_⟩
  intro t c ht hc
  have hp := hsimpleZero t c ht hc
  dsimp only at hp ⊢
  exact ⟨hp.2.1, hp.2.2.2, hp.2.2.1,
    interiorCellsOfWalk_eulerNumber_eq_one _ hp.2.1 hp.2.2.2 hp.2.2.1 hp.1⟩

end Ising2DLambda.KacWard
