import Ising2DLambda.KacWard.CellVertexGraphConnected
import Ising2DLambda.NecSuf.Tools.EvenEdgeSetCount
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- Apply the finite-graph count to the actual graph of cell corners. -/
theorem cellVertexGraph_evenEdgeSubset_count_from_necSuf
    (cells : Finset GridCell) (hnonempty : cells.Nonempty)
    (hconnected : EdgeConnectedCellSet (cells : Set GridCell)) :
    Nat.card {A : Finset (Sym2 (cellVertices cells)) //
      A ⊆ (cellVertexGraph cells).edgeFinset ∧
        Ising2DLambda.NecSuf.Tools.IsEvenIncidence (fun v e => v ∈ e) A} =
      2 ^ ((cellVertexGraph cells).edgeFinset.card + 1 -
        (cellVertices cells).card) := by
  classical
  have hgraph := edgeConnectedCellSet_actualVertexGraphConnected
    cells hnonempty hconnected
  obtain ⟨tree, htree_sub, htree⟩ := hgraph.exists_isTree_le
  let root : cellVertices cells := Classical.choice hgraph.nonempty
  have hfinset : (cellVertexGraph cells).edgeFinset =
      @SimpleGraph.edgeFinset _ (cellVertexGraph cells)
        (cellVertexGraph cells).fintypeEdgeSet := by
    ext e
    simp only [SimpleGraph.mem_edgeFinset]
  have hcount := Ising2DLambda.NecSuf.Tools.evenEdgeSet_count
    (cellVertexGraph cells) tree htree_sub htree root
  rw [← hfinset] at hcount
  simpa only [Fintype.card_coe] using hcount

end Ising2DLambda.KacWard
