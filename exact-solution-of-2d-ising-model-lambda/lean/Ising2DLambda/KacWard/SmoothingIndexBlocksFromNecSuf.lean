/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.SmoothingIndexBlocks
import Ising2DLambda.NecSuf.KacWard.SmoothingIndexBlocks

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

theorem smoothingIndexBlockA_from_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (k l : Fin (m + 1)) :
    smoothingIndexBlockA γ hγ k l =
      Ising2DLambda.NecSuf.KacWard.smoothingIndexBlockA k l := by
  ext r
  change ((closedWalkTextIndex k).val < (closedWalkTextIndex r).val ∧
    (closedWalkTextIndex r).val ≤ (closedWalkTextIndex l).val) ↔ (k < r ∧ r ≤ l)
  rw [closedWalkTextIndex_lt_iff, closedWalkTextIndex_le_iff]

theorem smoothingIndexBlockB_from_necSuf {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (k l : Fin (m + 1)) :
    smoothingIndexBlockB γ hγ k l =
      Ising2DLambda.NecSuf.KacWard.smoothingIndexBlockB k l := by
  ext r
  change r ∉ smoothingIndexBlockA γ hγ k l ↔
    r ∉ Ising2DLambda.NecSuf.KacWard.smoothingIndexBlockA k l
  rw [smoothingIndexBlockA_from_necSuf]

end Ising2DLambda.KacWard
