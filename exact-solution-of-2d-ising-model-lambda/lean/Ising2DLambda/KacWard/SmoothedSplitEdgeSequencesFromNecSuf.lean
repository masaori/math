/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.SmoothedSplitEdgeSequences
import Ising2DLambda.NecSuf.KacWard.SmoothedSplitEdgeSequences

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

theorem smoothingIndexSequenceA_from_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (k l : Fin (m + 1)) :
    smoothingIndexSequenceA γ hγ k l =
      Ising2DLambda.NecSuf.KacWard.smoothingIndexSequenceA k l := rfl

theorem smoothingIndexSequenceB_from_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (k l : Fin (m + 1)) :
    smoothingIndexSequenceB γ hγ k l =
      Ising2DLambda.NecSuf.KacWard.smoothingIndexSequenceB k l := rfl

theorem smoothedSplitEdgeSequenceA_from_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (k l : Fin (m + 1)) :
    smoothedSplitEdgeSequenceA γ hγ k l =
      Ising2DLambda.NecSuf.KacWard.smoothedSplitEdgeSequenceA γ k l := rfl

theorem smoothedSplitEdgeSequenceB_from_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (k l : Fin (m + 1)) :
    smoothedSplitEdgeSequenceB γ hγ k l =
      Ising2DLambda.NecSuf.KacWard.smoothedSplitEdgeSequenceB γ k l := rfl

end Ising2DLambda.KacWard
