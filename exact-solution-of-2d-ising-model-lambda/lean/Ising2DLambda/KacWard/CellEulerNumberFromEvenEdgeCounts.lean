import Ising2DLambda.KacWard.CellSubsetGraphEvenEdgeCount
import Ising2DLambda.KacWard.CellGraphEvenEdgeCount
import Mathlib.Data.Finset.Powerset
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- The two counts of even edge sets determine the cell count and Euler number. -/
theorem cellEulerNumber_eq_one_of_even_edge_counts
    (cells : Finset GridCell) (evenEdgeCount : ℕ)
    (hboundary : evenEdgeCount = 2 ^ cells.card)
    (hgraph : evenEdgeCount =
      2 ^ ((cellEdges cells).card + 1 - (cellVertices cells).card))
    (hvertices : (cellVertices cells).card ≤ (cellEdges cells).card + 1) :
    cellEulerNumber cells = 1 := by
  have hpowers :
      2 ^ cells.card =
        2 ^ ((cellEdges cells).card + 1 - (cellVertices cells).card) := by
    calc
      2 ^ cells.card = evenEdgeCount := hboundary.symm
      _ = 2 ^ ((cellEdges cells).card + 1 - (cellVertices cells).card) := hgraph
  have hcells : cells.card =
      (cellEdges cells).card + 1 - (cellVertices cells).card :=
    Nat.pow_right_injective (by decide : 1 < 2) hpowers
  unfold cellEulerNumber
  omega

/-- The two counts of the actual graph's even edge sets give its cell Euler number. -/
theorem cellEulerNumber_eq_one_of_actual_even_edge_counts
    (cells : Finset GridCell) (hnonempty : cells.Nonempty)
    (hconnected : EdgeConnectedCellSet (cells : Set GridCell))
    (hexterior : EdgeConnectedCellSet (↑cells : Set GridCell)ᶜ) :
    cellEulerNumber cells = 1 := by
  classical
  letI : Fintype {T : Finset GridCell // T ∈ cells.powerset} :=
    cells.powerset.finite_toSet.fintype
  letI : Fintype {T : Finset GridCell // T ⊆ cells} :=
    Fintype.ofEquiv {T : Finset GridCell // T ∈ cells.powerset}
      (Equiv.subtypeEquiv (Equiv.refl _) (fun T => Finset.mem_powerset))
  have hsubsets : Nat.card {T : Finset GridCell // T ⊆ cells} = 2 ^ cells.card := by
    rw [Nat.card_eq_fintype_card]
    calc
      Fintype.card {T : Finset GridCell // T ⊆ cells} = cells.powerset.card := by
        simpa [Finset.mem_powerset] using (Fintype.card_coe cells.powerset)
      _ = 2 ^ cells.card := Finset.card_powerset cells
  have hboundary := cellSubset_graphEvenEdge_card cells hexterior
  have hgraph := cellVertexGraph_evenEdgeSubset_count cells hnonempty hconnected
  have hedges : (cellVertexGraph cells).edgeFinset.card = (cellEdges cells).card := by
    rw [cellVertexGraph_edgeFinset, Finset.card_image_of_injective]
    · exact Finset.card_attach
    · exact cellGraphEdge_injective cells
  have hpowers : 2 ^ cells.card =
      2 ^ ((cellEdges cells).card + 1 - (cellVertices cells).card) := by
    calc
      2 ^ cells.card = Nat.card {T : Finset GridCell // T ⊆ cells} := hsubsets.symm
      _ = Nat.card {B : Finset (cellVertexGraph cells).edgeFinset //
          IsEvenCellGraphEdgeSet cells B} := hboundary.symm
      _ = 2 ^ ((cellVertexGraph cells).edgeFinset.card + 1 -
            (cellVertices cells).card) := hgraph
      _ = 2 ^ ((cellEdges cells).card + 1 - (cellVertices cells).card) := by rw [hedges]
  have hcells : cells.card =
      (cellEdges cells).card + 1 - (cellVertices cells).card :=
    Nat.pow_right_injective (by decide : 1 < 2) hpowers
  have hG := edgeConnectedCellSet_actualVertexGraphConnected
    cells hnonempty hconnected
  have hbound := hG.card_vert_le_card_edgeSet_add_one
  have hvertices : (cellVertices cells).card ≤ (cellEdges cells).card + 1 := by
    rw [Nat.card_eq_fintype_card (α := (cellVertices cells)),
      Nat.card_eq_fintype_card (α := (cellVertexGraph cells).edgeSet),
      ← SimpleGraph.edgeFinset_card, Fintype.card_coe, hedges] at hbound
    exact hbound
  unfold cellEulerNumber
  omega

end Ising2DLambda.KacWard
