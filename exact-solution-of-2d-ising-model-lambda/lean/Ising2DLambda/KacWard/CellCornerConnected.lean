import Ising2DLambda.KacWard.CellComplexOneCellIncrement
import Ising2DLambda.NecSuf.KacWard.CellCornerConnected
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- The coordinate encoding of the two endpoints of a grid edge. -/
def gridEdgeEndpoints : GridEdge → Finset GridVertex
  | (false, (r, c)) => {(r, c), (r, c + 1)}
  | (true, (r, c)) => {(r, c), (r + 1, c)}

/-- One step along an edge belonging to a finite cell set. -/
def CellVertexStep (cells : Finset GridCell) (u v : GridVertex) : Prop :=
  ∃ e ∈ cellEdges cells, gridEdgeEndpoints e = {u, v}

/-- The four corners of an actual grid cell are connected through its four edges. -/
theorem cellCorners_connected (r c : ℤ) :
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
  have hbase : ∀ u ∈ verticesOfCell (r, c),
      Relation.EqvGen (CellVertexStep ({(r, c)} : Finset GridCell)) a u := by
    intro u hu
    simp only [verticesOfCell, Finset.mem_insert, Finset.mem_singleton] at hu
    rcases hu with rfl | rfl | rfl | rfl
    · exact Relation.EqvGen.refl _
    · exact Relation.EqvGen.rel _ _ hab
    · exact Relation.EqvGen.rel _ _ hap
    · exact Relation.EqvGen.trans _ _ _
        (Relation.EqvGen.rel _ _ hab) (Relation.EqvGen.rel _ _ hbd)
  intro u hu v hv
  exact Relation.EqvGen.trans _ _ _
    (Relation.EqvGen.symm _ _ (hbase u hu)) (hbase v hv)

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
