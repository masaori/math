import Ising2DLambda.KacWard.CellEulerNumberFromEvenEdgeCounts
import Ising2DLambda.KacWard.CellVertexIncidenceCount
import Ising2DLambda.KacWard.PlaneCellBoundary
import Ising2DLambda.KacWard.OddRayInteriorCellsFromWalkFinite
import Ising2DLambda.KacWard.InteriorCellSetEdgeConnected
import Ising2DLambda.KacWard.ExteriorCellReachesOuterCoreFromWalk
import Ising2DLambda.KacWard.OneSidedClosureProjectionWindingFromWalk

namespace Ising2DLambda.KacWard

/-- A horizontal grid edge meets precisely the selected cells above and below it. -/
theorem horizontalEdge_cellIncidence_count (cells : Finset GridCell) (r c : ℤ) :
    (cells.filter (fun x => (false, (r, c)) ∈ edgesOfCell x)).card =
      (if (r, c) ∈ cells then 1 else 0) +
        (if (r - 1, c) ∈ cells then 1 else 0) := by
  classical
  have hfilter : cells.filter (fun x => (false, (r, c)) ∈ edgesOfCell x) =
      ({(r, c), (r - 1, c)} : Finset GridCell) ∩ cells := by
    ext ⟨i, j⟩
    simp [edgesOfCell, Prod.mk.injEq]
    constructor
    · rintro ⟨hmem, h⟩
      constructor
      · rcases h with h | h <;> omega
      · exact hmem
    · rintro ⟨h, hmem⟩
      constructor
      · exact hmem
      · rcases h with h | h <;> omega
  rw [hfilter]
  have hne : (r, c) ≠ (r - 1, c) := by
    intro h
    have := congrArg Prod.fst h
    omega
  by_cases ha : (r, c) ∈ cells <;> by_cases hb : (r - 1, c) ∈ cells <;>
    simp [ha, hb, hne]

/-- A vertical grid edge meets precisely the selected cells on either side. -/
theorem verticalEdge_cellIncidence_count (cells : Finset GridCell) (r c : ℤ) :
    (cells.filter (fun x => (true, (r, c)) ∈ edgesOfCell x)).card =
      (if (r, c) ∈ cells then 1 else 0) +
        (if (r, c - 1) ∈ cells then 1 else 0) := by
  classical
  have hfilter : cells.filter (fun x => (true, (r, c)) ∈ edgesOfCell x) =
      ({(r, c), (r, c - 1)} : Finset GridCell) ∩ cells := by
    ext ⟨i, j⟩
    simp [edgesOfCell, Prod.mk.injEq]
    constructor
    · rintro ⟨hmem, h⟩
      constructor
      · rcases h with h | h <;> omega
      · exact hmem
    · rintro ⟨h, hmem⟩
      constructor
      · exact hmem
      · rcases h with h | h <;> omega
  rw [hfilter]
  have hne : (r, c) ≠ (r, c - 1) := by
    intro h
    have := congrArg Prod.snd h
    omega
  by_cases ha : (r, c) ∈ cells <;> by_cases hb : (r, c - 1) ∈ cells <;>
    simp [ha, hb, hne]

/-- Exactly one selected cell meets a boundary edge. -/
theorem edge_cellIncidence_eq_one_iff_boundary (cells : Finset GridCell)
    (e : GridEdge) :
    (cells.filter (fun x => e ∈ edgesOfCell x)).card = 1 ↔
      e ∈ planeCellBoundary cells := by
  rcases e with ⟨b, ⟨r, c⟩⟩
  cases b
  · rw [horizontalEdge_cellIncidence_count]
    simp only [planeCellBoundary, Finset.mem_filter, horizontalEdge_mem_cellEdges_iff,
      Bool.false_eq_true, ↓reduceIte]
    by_cases ha : (r, c) ∈ cells <;> by_cases hb : (r - 1, c) ∈ cells <;>
      simp [ha, hb]
  · rw [verticalEdge_cellIncidence_count]
    simp only [planeCellBoundary, Finset.mem_filter, verticalEdge_mem_cellEdges_iff,
      ↓reduceIte]
    by_cases ha : (r, c) ∈ cells <;> by_cases hb : (r, c - 1) ∈ cells <;>
      simp [ha, hb]

/-- Exactly two selected cells meet an interior edge of the cell complex. -/
theorem edge_cellIncidence_eq_two_iff_interior (cells : Finset GridCell)
    (e : GridEdge) :
    (cells.filter (fun x => e ∈ edgesOfCell x)).card = 2 ↔
      e ∈ cellEdges cells \ planeCellBoundary cells := by
  rcases e with ⟨b, ⟨r, c⟩⟩
  cases b
  · rw [horizontalEdge_cellIncidence_count]
    simp only [Finset.mem_sdiff, planeCellBoundary, Finset.mem_filter,
      horizontalEdge_mem_cellEdges_iff, Bool.false_eq_true, ↓reduceIte]
    by_cases ha : (r, c) ∈ cells <;> by_cases hb : (r - 1, c) ∈ cells <;>
      simp [ha, hb]
  · rw [verticalEdge_cellIncidence_count]
    simp only [Finset.mem_sdiff, planeCellBoundary, Finset.mem_filter,
      verticalEdge_mem_cellEdges_iff, ↓reduceIte]
    by_cases ha : (r, c) ∈ cells <;> by_cases hb : (r, c - 1) ∈ cells <;>
      simp [ha, hb]

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

/-- The boundary and interior edges of an actual closed walk's interior cell
complex have one and two incident cells, respectively. -/
theorem interiorCellsOfWalk_edgeIncidence_classification {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0) :
    let cells := (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset
    ∀ e : GridEdge,
      ((cells.filter (fun x => e ∈ edgesOfCell x)).card = 1 ↔
        e ∈ planeCellBoundary cells) ∧
      ((cells.filter (fun x => e ∈ edgesOfCell x)).card = 2 ↔
        e ∈ cellEdges cells \ planeCellBoundary cells) := by
  dsimp only
  intro e
  exact ⟨edge_cellIncidence_eq_one_iff_boundary _ e,
    edge_cellIncidence_eq_two_iff_interior _ e⟩

/-- The cell-edge incidence total splits into one contribution per boundary edge
and two per interior edge of the actual walk's interior cell complex. -/
theorem interiorCellsOfWalk_edgeIncidence_boundary_interior {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0) :
    let cells := (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset
    4 * cells.card =
      (planeCellBoundary cells).card +
        2 * (cellEdges cells \ planeCellBoundary cells).card := by
  classical
  dsimp only
  let cells := (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset
  change 4 * cells.card =
    (planeCellBoundary cells).card +
      2 * (cellEdges cells \ planeCellBoundary cells).card
  have hboundary : planeCellBoundary cells ⊆ cellEdges cells :=
    Finset.filter_subset _ _
  have hsplit :
      (∑ e ∈ cellEdges cells,
        (cells.filter (fun x => e ∈ edgesOfCell x)).card) =
        (∑ e ∈ planeCellBoundary cells,
          (cells.filter (fun x => e ∈ edgesOfCell x)).card) +
        (∑ e ∈ cellEdges cells \ planeCellBoundary cells,
          (cells.filter (fun x => e ∈ edgesOfCell x)).card) := by
    rw [← Finset.sum_sdiff hboundary, add_comm]
  have hboundarySum :
      (∑ e ∈ planeCellBoundary cells,
        (cells.filter (fun x => e ∈ edgesOfCell x)).card) =
        (planeCellBoundary cells).card := by
    calc
      _ = ∑ _e ∈ planeCellBoundary cells, (1 : ℕ) :=
        Finset.sum_congr rfl (fun e he =>
          (edge_cellIncidence_eq_one_iff_boundary cells e).2 he)
      _ = (planeCellBoundary cells).card := by simp
  have hinteriorSum :
      (∑ e ∈ cellEdges cells \ planeCellBoundary cells,
        (cells.filter (fun x => e ∈ edgesOfCell x)).card) =
        2 * (cellEdges cells \ planeCellBoundary cells).card := by
    calc
      _ = ∑ _e ∈ cellEdges cells \ planeCellBoundary cells, (2 : ℕ) :=
        Finset.sum_congr rfl (fun e he =>
          (edge_cellIncidence_eq_two_iff_interior cells e).2 he)
      _ = 2 * (cellEdges cells \ planeCellBoundary cells).card := by
        simp [mul_comm]
  have htotal := interiorCellsOfWalk_edgeIncidence_sum γ hγ hh hv
  change (∑ e ∈ cellEdges cells,
    (cells.filter (fun x => e ∈ edgesOfCell x)).card) = 4 * cells.card at htotal
  rw [hsplit, hboundarySum, hinteriorSum] at htotal
  exact htotal.symm

/-- Count vertex incidences in the interior cells of an actual closed walk. -/
theorem interiorCellsOfWalk_vertexIncidence_sum {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0) :
    let cells := (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset
    (∑ v ∈ cellVertices cells, vertexCellIncidenceCount cells v) = 4 * cells.card := by
  exact cellVertexIncidence_sum _

/-- The incidence sum of an actual walk's interior cells is the weighted
number of vertices in each of its four incidence classes. -/
theorem interiorCellsOfWalk_vertexIncidence_by_class {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0) :
    let cells := (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset
    4 * cells.card =
      (verticesWithIncidence cells 1).card +
      2 * (verticesWithIncidence cells 2).card +
      3 * (verticesWithIncidence cells 3).card +
      4 * (verticesWithIncidence cells 4).card := by
  dsimp only
  calc
    4 * (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset.card =
        ∑ v ∈ cellVertices (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset,
          vertexCellIncidenceCount (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset v :=
      (interiorCellsOfWalk_vertexIncidence_sum γ hγ hh hv).symm
    _ = _ := cellVertexIncidence_sum_by_class _

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
