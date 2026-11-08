import Ising2DLambda.KacWard.PlaneHeightOneExteriorInclusion
import Ising2DLambda.NecSuf.KacWard.FiniteConnectedComplementInclusion

namespace Ising2DLambda.KacWard

/-- The abstract finite-region argument specializes to the ray height-one set. -/
theorem planeHeightOne_exterior_inclusion_from_necSuf (cells : Finset GridCell)
    (edges : Finset GridEdge)
    (heven : ∀ r c : ℤ,
      ((if (false, (r, c)) ∈ edges then (1 : ZMod 2) else 0) +
        (if (false, (r, c - 1)) ∈ edges then 1 else 0) +
        (if (true, (r, c)) ∈ edges then 1 else 0) +
        (if (true, (r - 1, c)) ∈ edges then 1 else 0)) = 0)
    (hsubset : edges ⊆ cellEdges cells)
    (hconnected : EdgeConnectedCellSet (↑cells : Set GridCell)ᶜ) :
    ∀ r c : ℤ, planeDualRayHeight edges r c = 1 → (r, c) ∈ cells := by
  obtain ⟨selected, hselected, hboundary⟩ := planeHeightOne_boundary edges heven
  have hfinite : selected ⊆ cells :=
    Ising2DLambda.NecSuf.KacWard.finiteRegion_subset_of_connected_complement
      cells selected CellEdgeAdjacent
      (by
        intro p hp q hq
        exact hconnected (show p ∈ (↑cells : Set GridCell)ᶜ from hp)
          (show q ∈ (↑cells : Set GridCell)ᶜ from hq))
      (by
        intro p q hp hq hadj
        exact same_height_one_across_missing_edge selected cells edges
          hboundary hsubset p q
          (exterior_adjacent_has_missing_shared_edge cells p q hp hq hadj))
  intro r c hh
  exact hfinite ((hselected r c).2 hh)

end Ising2DLambda.KacWard
