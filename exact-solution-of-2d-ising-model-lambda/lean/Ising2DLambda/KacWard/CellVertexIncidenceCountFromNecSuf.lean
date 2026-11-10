import Ising2DLambda.KacWard.CellVertexIncidenceCount
import Ising2DLambda.NecSuf.KacWard.CellVertexIncidenceCount

namespace Ising2DLambda.KacWard

/-- The concrete count is the grid-cell specialization of the finite-weight
partition theorem. -/
theorem cellVertexIncidence_sum_by_class_from_necSuf
    (cells : Finset GridCell) :
    (∑ v ∈ cellVertices cells, vertexCellIncidenceCount cells v) =
      (verticesWithIncidence cells 1).card +
      2 * (verticesWithIncidence cells 2).card +
      3 * (verticesWithIncidence cells 3).card +
      4 * (verticesWithIncidence cells 4).card := by
  classical
  simpa only [verticesWithIncidence] using
    Ising2DLambda.NecSuf.KacWard.finiteWeightedSum_fourClasses
      (cellVertices cells) (vertexCellIncidenceCount cells)
      (fun v hv => vertexCellIncidenceCount_one_to_four cells v hv)

end Ising2DLambda.KacWard
