import Ising2DLambda.KacWard.CellBoundaryEvenEdgeBijection
import Ising2DLambda.KacWard.CellGridEvenEdgeCorrespondence
import Ising2DLambda.KacWard.CellGraphEvenEdgeBijection
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- The cell subsets and the even edge subsets of their corner graph have the same cardinality. -/
theorem cellSubset_graphEvenEdge_card (cells : Finset GridCell)
    (hexterior : EdgeConnectedCellSet (↑cells : Set GridCell)ᶜ) :
    Nat.card {B : Finset (cellVertexGraph cells).edgeFinset //
      IsEvenCellGraphEdgeSet cells B} =
      Nat.card {T : Finset GridCell // T ⊆ cells} := by
  classical
  have hgraph : Nat.card {A : Finset (cellEdges cells) //
      IsEvenEncodedCellEdgeSet cells A} =
      Nat.card {B : Finset (cellVertexGraph cells).edgeFinset //
        IsEvenCellGraphEdgeSet cells B} :=
    Nat.card_congr (Equiv.ofBijective _ (cellGraphEvenEdge_bijective cells))
  have hboundary : Nat.card {T : Finset GridCell // T ⊆ cells} =
      Nat.card {E : Finset GridEdge // IsEvenCellEdgeSubset cells E} :=
    Nat.card_congr (Equiv.ofBijective _
      (cellBoundary_evenEdge_bijective cells hexterior))
  calc
    Nat.card {B : Finset (cellVertexGraph cells).edgeFinset //
        IsEvenCellGraphEdgeSet cells B} =
      Nat.card {A : Finset (cellEdges cells) //
        IsEvenEncodedCellEdgeSet cells A} := hgraph.symm
    _ = Nat.card {E : Finset GridEdge // IsEvenCellEdgeSubset cells E} :=
      (cellGridEvenEdge_card_encoded cells).symm
    _ = Nat.card {T : Finset GridCell // T ⊆ cells} := hboundary.symm

end Ising2DLambda.KacWard
