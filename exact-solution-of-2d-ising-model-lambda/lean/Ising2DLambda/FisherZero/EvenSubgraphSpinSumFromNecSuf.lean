/-
必要十分版の有限積恒等式を、正方格子のスピン単項式和へ特殊化する導出。
`claim_even_subgraph_spin_sum` の具体版と同じ並べ替えのあと、局所和を
`sum_spinValue_pow`、頂点数を `card_vertex` で必要十分版の仮定へ戻す。
-/
import Ising2DLambda.FisherZero.EvenSubgraphSpinSum
import Ising2DLambda.NecSuf.FisherZero.EvenSubgraphSpinSum

namespace Ising2DLambda.FisherZero

open Finset Ising2DLambda.PartitionPolynomial

/-- 必要十分版から得る `S_L(A)` の二択値。 -/
theorem evenSubgraph_spinSum_from_necSuf (L : ℕ) [NeZero L]
    (A : Finset (Edge L)) :
    edgeSubsetSpinSum L A = if IsEvenEdgeSubset L A then 2 ^ L ^ 2 else 0 := by
  classical
  rw [edgeSubsetSpinSum]
  simp_rw [edgeSubsetMonomial_eq_vertexProduct L A]
  change (∑ σ : Vertex L → SpinValue,
    ∏ v : Vertex L, (σ v).1 ^ edgeSubsetIncidenceCount L A v) = _
  rw [Ising2DLambda.NecSuf.FisherZero.sum_product_piecewise_even_necSuf
    (fun v : Vertex L => edgeSubsetIncidenceCount L A v)
    (fun v : Vertex L => fun s : SpinValue =>
      s.1 ^ edgeSubsetIncidenceCount L A v)
    (2 : ℤ) (fun v => sum_spinValue_pow (edgeSubsetIncidenceCount L A v))]
  rw [card_vertex]
  rfl

end Ising2DLambda.FisherZero
