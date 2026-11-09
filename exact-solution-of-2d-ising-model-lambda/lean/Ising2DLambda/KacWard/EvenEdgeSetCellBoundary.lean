import Ising2DLambda.KacWard.PlaneHeightOneExteriorInclusion
import Ising2DLambda.NecSuf.KacWard.BoundaryOfFiniteHeight

namespace Ising2DLambda.KacWard

/-- Every even edge set supported by a finite cell complex with connected
complement is the boundary of a subset of its cells. -/
theorem evenEdgeSet_cell_boundary (cells : Finset GridCell)
    (edges : Finset GridEdge)
    (heven : ∀ r c : ℤ,
      ((if (false, (r, c)) ∈ edges then (1 : ZMod 2) else 0) +
        (if (false, (r, c - 1)) ∈ edges then 1 else 0) +
        (if (true, (r, c)) ∈ edges then 1 else 0) +
        (if (true, (r - 1, c)) ∈ edges then 1 else 0)) = 0)
    (hsubset : edges ⊆ cellEdges cells)
    (hconnected : EdgeConnectedCellSet (↑cells : Set GridCell)ᶜ) :
    ∃ selected : Finset GridCell,
      selected ⊆ cells ∧ planeCellBoundary selected = edges := by
  obtain ⟨selected, hselected, hboundary⟩ := planeHeightOne_boundary edges heven
  refine ⟨selected, ?_, hboundary⟩
  intro p hp
  exact planeHeightOne_exterior_inclusion cells edges heven hsubset hconnected
    p.1 p.2 ((hselected p.1 p.2).mp hp)

/-- The generic finite-height argument specializes to the plane grid. -/
theorem evenEdgeSet_cell_boundary_from_necSuf (cells : Finset GridCell)
    (edges : Finset GridEdge)
    (heven : ∀ r c : ℤ,
      ((if (false, (r, c)) ∈ edges then (1 : ZMod 2) else 0) +
        (if (false, (r, c - 1)) ∈ edges then 1 else 0) +
        (if (true, (r, c)) ∈ edges then 1 else 0) +
        (if (true, (r - 1, c)) ∈ edges then 1 else 0)) = 0)
    (hsubset : edges ⊆ cellEdges cells)
    (hconnected : EdgeConnectedCellSet (↑cells : Set GridCell)ᶜ) :
    ∃ selected : Finset GridCell,
      selected ⊆ cells ∧ planeCellBoundary selected = edges := by
  apply Ising2DLambda.NecSuf.KacWard.boundary_of_finite_height
    planeCellBoundary cells edges
    (fun p => planeDualRayHeight edges p.1 p.2 = 1)
  · obtain ⟨selected, hselected, hboundary⟩ := planeHeightOne_boundary edges heven
    exact ⟨selected, (fun p => hselected p.1 p.2), hboundary⟩
  · intro p hp
    exact planeHeightOne_exterior_inclusion cells edges heven hsubset hconnected
      p.1 p.2 hp

end Ising2DLambda.KacWard
