import Ising2DLambda.KacWard.CellComplexOneCellIncrement
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- The number of cells of a finite set incident to a grid vertex. -/
def vertexCellIncidenceCount (cells : Finset GridCell) (v : GridVertex) : ℕ :=
  (cells.filter (fun x => v ∈ verticesOfCell x)).card

/-- Count incidences between the cells and vertices of a finite cell set in
both orders. -/
theorem cellVertexIncidence_sum (cells : Finset GridCell) :
    (∑ v ∈ cellVertices cells, vertexCellIncidenceCount cells v) =
      4 * cells.card := by
  classical
  calc
    (∑ v ∈ cellVertices cells, vertexCellIncidenceCount cells v) =
        ∑ v ∈ cellVertices cells, ∑ x ∈ cells, if v ∈ verticesOfCell x then 1 else 0 := by
          simp only [vertexCellIncidenceCount, Finset.card_filter]
    _ = ∑ x ∈ cells, ∑ v ∈ cellVertices cells, if v ∈ verticesOfCell x then 1 else 0 := by
          rw [Finset.sum_comm]
    _ = ∑ x ∈ cells, (verticesOfCell x).card := by
          apply Finset.sum_congr rfl
          intro x hx
          rw [← Finset.sum_subset (show verticesOfCell x ⊆ cellVertices cells by
            intro v hv
            exact Finset.mem_biUnion.mpr ⟨x, hx, hv⟩)]
          · simp
          · intro v hv hvx
            simp [hvx]
    _ = 4 * cells.card := by
          have hcard (x : GridCell) : (verticesOfCell x).card = 4 := by
            rcases x with ⟨r, c⟩
            simp [verticesOfCell]
          simp [hcard, mul_comm]

end Ising2DLambda.KacWard
