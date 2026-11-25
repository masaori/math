/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.CellCornerConnected
import Ising2DLambda.KacWard.CellComplexOneCellIncrementFromNecSuf
import Ising2DLambda.NecSuf.KacWard.CellCornerConnected

namespace Ising2DLambda.KacWard

/-- The four-corner argument can also be obtained from the necessary-sufficient version. -/
theorem cellCorners_connected_from_necSuf (r c : ℤ) :
    ∀ u ∈ verticesOfCell (r, c), ∀ v ∈ verticesOfCell (r, c),
      Relation.EqvGen (CellVertexStep ({(r, c)} : Finset GridCell)) u v := by
  let a : GridVertex := (r, c)
  let b : GridVertex := (r, c + 1)
  let d : GridVertex := (r + 1, c + 1)
  let p : GridVertex := (r + 1, c)
  have hab : CellVertexStep ({(r, c)} : Finset GridCell) a b := by
    refine ⟨(false, (r, c)), ?_, ?_⟩
    · simp [cellEdges, edgesOfCell]
    · simp [gridEdgeEndpoints, a, b]
  have hap : CellVertexStep ({(r, c)} : Finset GridCell) a p := by
    refine ⟨(true, (r, c)), ?_, ?_⟩
    · simp [cellEdges, edgesOfCell]
    · simp [gridEdgeEndpoints, a, p]
  have hbd : CellVertexStep ({(r, c)} : Finset GridCell) b d := by
    refine ⟨(true, (r, c + 1)), ?_, ?_⟩
    · simp [cellEdges, edgesOfCell]
    · simp [gridEdgeEndpoints, b, d]
  simpa [verticesOfCell, a, b, p, d] using
    (Ising2DLambda.NecSuf.KacWard.fourCorners_connected a b p d
      (CellVertexStep ({(r, c)} : Finset GridCell)) hab hap hbd)

end Ising2DLambda.KacWard
