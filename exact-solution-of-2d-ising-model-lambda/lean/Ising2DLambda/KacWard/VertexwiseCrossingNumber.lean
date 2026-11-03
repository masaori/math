import Mathlib.Data.Finset.Prod
import Mathlib.Data.Fintype.Basic
import Ising2DLambda.KacWard.IndexPairCrossing
import Ising2DLambda.NecSuf.KacWard.VertexwiseCrossingNumber

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- `def_vertexwise_crossing_number` for an actual closed nonbacktracking walk. -/
noncomputable def vertexwiseCrossingNumber {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (v : Vertex L) : ℕ := by
  classical
  exact ((Finset.univ ×ˢ Finset.univ).filter fun p : Fin (m + 1) × Fin (m + 1) =>
    p.1 < p.2 ∧ indexPairCrossing γ hγ p.1 p.2 ∧
      closedWalkPassVertex γ hγ p.1 = v).card

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
