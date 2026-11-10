import Ising2DLambda.KacWard.CellBoundaryEvenEdgeBijection
import Ising2DLambda.NecSuf.KacWard.CellBoundaryEvenEdgeCount
import Mathlib.Data.Finset.Powerset
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- The boundary bijection counts the even edge sets supported on a hole-free cell set. -/
theorem cellBoundary_evenEdge_count (cells : Finset GridCell)
    (hconnected : EdgeConnectedCellSet (↑cells : Set GridCell)ᶜ) :
    Nat.card {E : Finset GridEdge // IsEvenCellEdgeSubset cells E} =
      2 ^ cells.card := by
  classical
  letI : Fintype {T : Finset GridCell // T ∈ cells.powerset} :=
    cells.powerset.finite_toSet.fintype
  letI : Fintype {T : Finset GridCell // T ⊆ cells} :=
    Fintype.ofEquiv {T : Finset GridCell // T ∈ cells.powerset}
      (Equiv.subtypeEquiv (Equiv.refl _) (fun T => Finset.mem_powerset))
  have hbij := cellBoundary_evenEdge_bijective cells hconnected
  letI : Fintype {E : Finset GridEdge // IsEvenCellEdgeSubset cells E} :=
    Fintype.ofEquiv _ (Equiv.ofBijective _ hbij)
  have hcard := Fintype.card_congr (Equiv.ofBijective _ hbij)
  rw [Nat.card_eq_fintype_card, ← hcard]
  calc
    Fintype.card {T : Finset GridCell // T ⊆ cells} = cells.powerset.card := by
      simpa [Finset.mem_powerset] using (Fintype.card_coe cells.powerset)
    _ = 2 ^ cells.card := Finset.card_powerset cells

/-- The abstract count specializes to the planar cell boundary bijection. -/
theorem cellBoundary_evenEdge_count_from_necSuf (cells : Finset GridCell)
    (hconnected : EdgeConnectedCellSet (↑cells : Set GridCell)ᶜ) :
    Nat.card {E : Finset GridEdge // IsEvenCellEdgeSubset cells E} =
      2 ^ cells.card := by
  exact Ising2DLambda.NecSuf.KacWard.boundary_even_edge_count
    cells (IsEvenCellEdgeSubset cells) _
    (cellBoundary_evenEdge_bijective_from_necSuf cells hconnected)

end Ising2DLambda.KacWard
