import Ising2DLambda.KacWard.PlaneHeightOneExteriorInclusion

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

end Ising2DLambda.KacWard
