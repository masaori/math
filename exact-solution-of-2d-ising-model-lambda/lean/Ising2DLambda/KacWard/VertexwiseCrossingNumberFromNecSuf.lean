/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.VertexwiseCrossingNumber
import Ising2DLambda.NecSuf.KacWard.VertexwiseCrossingNumber
import Ising2DLambda.KacWard.ClosedWalkPassesFromNecSuf

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

theorem vertexwiseCrossingNumber_from_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (v : Vertex L) :
    vertexwiseCrossingNumber γ hγ v =
      Ising2DLambda.NecSuf.KacWard.vertexwiseCrossingNumber
        edgeTransverseCrossing orientedTarget γ v := by
  classical
  simp only [vertexwiseCrossingNumber,
    Ising2DLambda.NecSuf.KacWard.vertexwiseCrossingNumber]
  congr 1
  ext p
  simp only [Finset.mem_filter, Finset.mem_product, Finset.mem_univ,
    true_and, closedWalkPassVertex, indexPairCrossing,
    Ising2DLambda.NecSuf.KacWard.indexPairCrossing,
    closedWalkSuccessor_from_necSuf]

end Ising2DLambda.KacWard
