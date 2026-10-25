import Ising2DLambda.KacWard.ShortPairRotationPhaseNonzero
import Ising2DLambda.NecSuf.KacWard.VertexPortBijection

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard
open Ising2DLambda.PartitionPolynomial Ising2DLambda.TransferMatrix

theorem vertexPort_bijective {L : ℕ} [NeZero L] (v : Vertex L) :
    Function.Bijective
      (fun e : {e : OrientedEdge L // orientedSource e = v} => directionNumber e.1) := by
  exact fiber_bijective
    (fun e : OrientedEdge L => (orientedSource e, directionNumber e))
    sourceDirection_bijective v

theorem selectedVertexPort_bijective {L : ℕ} [NeZero L]
    (v : Vertex L) (P : Finset (Edge L)) :
    Set.BijOn directionNumber
      {e : OrientedEdge L | orientedSource e = v ∧ e.1 ∈ P}
      {d : ZMod 4 | ∃ e : OrientedEdge L,
        orientedSource e = v ∧ e.1 ∈ P ∧ directionNumber e = d} := by
  exact selected_fiber_bijective
    (fun e : OrientedEdge L => (orientedSource e, directionNumber e))
    sourceDirection_bijective v (fun e => e.1 ∈ P)

end Ising2DLambda.KacWard
