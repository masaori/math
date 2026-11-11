import Ising2DLambda.KacWard.CellBoundaryVerticesOfWalk
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

private theorem gridEdgeEndpoints_mem_iff_count (e : GridEdge) (r c : ℤ) :
    (r, c) ∈ gridEdgeEndpoints e ↔
      e = (false, (r, c)) ∨ e = (false, (r, c - 1)) ∨
      e = (true, (r, c)) ∨ e = (true, (r - 1, c)) := by
  rcases e with ⟨b, ⟨i, j⟩⟩
  cases b <;> simp [gridEdgeEndpoints, Prod.mk.injEq] <;> omega

private theorem gridIncident_card_eq_local (A : Finset GridEdge) (r c : ℤ) :
    (A.filter fun e => (r, c) ∈ gridEdgeEndpoints e).card =
      (if (false, (r, c)) ∈ A then 1 else 0) +
      (if (false, (r, c - 1)) ∈ A then 1 else 0) +
      (if (true, (r, c)) ∈ A then 1 else 0) +
      (if (true, (r - 1, c)) ∈ A then 1 else 0) := by
  have hfilter : (A.filter fun e => (r, c) ∈ gridEdgeEndpoints e) =
      ({(false, (r, c)), (false, (r, c - 1)),
        (true, (r, c)), (true, (r - 1, c))} : Finset GridEdge).filter
        (fun e => e ∈ A) := by
    ext e
    simp only [Finset.mem_filter, Finset.mem_insert, Finset.mem_singleton]
    rw [gridEdgeEndpoints_mem_iff_count]
    tauto
  rw [hfilter]
  simp only [Finset.filter_insert, Finset.filter_singleton]
  have hr : r ≠ r - 1 := by omega
  have hc : c ≠ c - 1 := by omega
  by_cases h₁ : (false, (r, c)) ∈ A <;>
    by_cases h₂ : (false, (r, c - 1)) ∈ A <;>
    by_cases h₃ : (true, (r, c)) ∈ A <;>
    by_cases h₄ : (true, (r - 1, c)) ∈ A <;>
    simp [h₁, h₂, h₃, h₄, Prod.mk.injEq, hr, hc]

/-- The boundary vertices are exactly the vertices incident to one, two, or
three selected cells. -/
theorem cellBoundaryVertices_card_eq_incidenceClasses (cells : Finset GridCell) :
    (cellBoundaryVertices cells).card =
      (verticesWithIncidence cells 1).card +
      (verticesWithIncidence cells 2).card +
      (verticesWithIncidence cells 3).card := by
  classical
  have hsub : cellBoundaryVertices cells ⊆ cellVertices cells := by
    intro v hv
    rcases v with ⟨r, c⟩
    have hclass := (cellBoundaryVertices_iff_incidence_one_to_three cells r c).mp hv
    have hpos : 0 < vertexCellIncidenceCount cells (r, c) := by omega
    obtain ⟨x, hx⟩ := Finset.card_pos.mp hpos
    exact Finset.mem_biUnion.mpr ⟨x, (Finset.mem_filter.mp hx).1,
      (Finset.mem_filter.mp hx).2⟩
  calc
    (cellBoundaryVertices cells).card =
        ∑ v ∈ cellVertices cells, if v ∈ cellBoundaryVertices cells then (1 : ℕ) else 0 :=
          Finset.card_eq_sum_ite hsub
    _ = ∑ v ∈ cellVertices cells,
          ((if vertexCellIncidenceCount cells v = 1 then 1 else 0) +
            (if vertexCellIncidenceCount cells v = 2 then 1 else 0) +
            (if vertexCellIncidenceCount cells v = 3 then 1 else 0)) := by
          apply Finset.sum_congr rfl
          intro ⟨r, c⟩ hv
          have hiff := cellBoundaryVertices_iff_incidence_one_to_three cells r c
          rcases vertexCellIncidenceCount_one_to_four cells (r, c) hv with h | h | h | h <;>
            simp [hiff, h]
    _ = (verticesWithIncidence cells 1).card +
        (verticesWithIncidence cells 2).card +
        (verticesWithIncidence cells 3).card := by
          simp [Finset.sum_add_distrib, verticesWithIncidence]

/-- A finite planar cell boundary with two incident edges at every boundary
vertex has as many boundary vertices as boundary edges. -/
theorem cellBoundaryVertices_card_eq_boundary_card (cells : Finset GridCell)
    (hdegree : ∀ v ∈ cellBoundaryVertices cells,
      ((planeCellBoundary cells).filter fun e => v ∈ gridEdgeEndpoints e).card = 2) :
    (cellBoundaryVertices cells).card = (planeCellBoundary cells).card := by
  classical
  let edges := planeCellBoundary cells
  let vertices := cellBoundaryVertices cells
  have hends (e : GridEdge) (he : e ∈ edges) : (gridEdgeEndpoints e).card = 2 := by
    rcases e with ⟨b, ⟨r, c⟩⟩
    cases b <;> simp [gridEdgeEndpoints]
  have hsub (e : GridEdge) (he : e ∈ edges) : gridEdgeEndpoints e ⊆ vertices := by
    intro v hv
    exact Finset.mem_biUnion.mpr ⟨e, he, hv⟩
  have hleft : (∑ e ∈ edges, ∑ v ∈ vertices,
      if v ∈ gridEdgeEndpoints e then (1 : ℕ) else 0) = 2 * edges.card := by
    calc
      _ = ∑ e ∈ edges, (vertices.filter fun v => v ∈ gridEdgeEndpoints e).card := by
        simp only [Finset.sum_boole, Nat.cast_id]
      _ = ∑ e ∈ edges, (gridEdgeEndpoints e).card := by
        apply Finset.sum_congr rfl
        intro e he
        congr 1
        ext v
        simp only [Finset.mem_filter]
        exact and_iff_right_of_imp (fun hv => hsub e he hv)
      _ = ∑ _e ∈ edges, (2 : ℕ) := Finset.sum_congr rfl hends
      _ = 2 * edges.card := by simp [mul_comm]
  have hright : (∑ v ∈ vertices, ∑ e ∈ edges,
      if v ∈ gridEdgeEndpoints e then (1 : ℕ) else 0) = 2 * vertices.card := by
    calc
      _ = ∑ v ∈ vertices, (edges.filter fun e => v ∈ gridEdgeEndpoints e).card := by
        simp only [Finset.sum_boole, Nat.cast_id]
      _ = ∑ _v ∈ vertices, (2 : ℕ) := by
        apply Finset.sum_congr rfl
        intro v hv
        exact hdegree v hv
      _ = 2 * vertices.card := by simp [mul_comm]
  rw [Finset.sum_comm] at hleft
  change vertices.card = edges.card
  omega

/-- The boundary of the actual simple closed walk has equally many vertices
and edges, by double counting the vertex-edge incidences. -/
theorem interiorCellsOfWalk_boundaryVertex_card_eq_boundaryEdge_card
    {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (hdistinct : Function.Injective
      (fun i : Fin (m + 1) => planeLift γ i.castSucc)) :
    (cellBoundaryVertices
      (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset).card =
    (planeCellBoundary
      (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset).card := by
  apply cellBoundaryVertices_card_eq_boundary_card
  intro ⟨r, c⟩ hvertex
  rw [gridIncident_card_eq_local]
  exact interiorCellsOfWalk_boundaryVertex_two_incident_edges
    γ hγ hh hv hdistinct r c hvertex

/-- The boundary-edge count in the polygon calculation is the sum of the
three boundary-vertex incidence classes. -/
theorem interiorCellsOfWalk_boundaryEdge_card_eq_incidenceClasses
    {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (hdistinct : Function.Injective
      (fun i : Fin (m + 1) => planeLift γ i.castSucc)) :
    (planeCellBoundary
      (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset).card =
      (verticesWithIncidence
        (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset 1).card +
      (verticesWithIncidence
        (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset 2).card +
      (verticesWithIncidence
        (oddRayInteriorCellsOfWalk_finite γ hγ hh hv).toFinset 3).card := by
  rw [← interiorCellsOfWalk_boundaryVertex_card_eq_boundaryEdge_card
    γ hγ hh hv hdistinct]
  exact cellBoundaryVertices_card_eq_incidenceClasses _

end Ising2DLambda.KacWard
