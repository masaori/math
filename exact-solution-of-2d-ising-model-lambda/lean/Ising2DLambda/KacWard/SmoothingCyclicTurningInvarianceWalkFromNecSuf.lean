/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.SmoothingCyclicTurningInvarianceWalk
import Ising2DLambda.NecSuf.KacWard.SmoothingCyclicTurningInvarianceWalk
import Ising2DLambda.KacWard.CyclicTotalTurningFromNecSuf
import Ising2DLambda.KacWard.SmoothedCyclicTotalTurningFromNecSuf

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.PartitionPolynomial

variable {L m : ℕ}
variable [NeZero L]

/-- 具体版が必要十分版 `smoothing_cyclic_turning_invariance_walk_necSuf` の特殊化として得られること。
辺を向き付き辺、方向を `ZMod 4` の方向番号、`π` を剰余への射影に取る。 -/
theorem closedWalk_smoothing_cyclic_turning_invariance_from_necSuf
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)}
    (hcross : indexPairCrossing γ hγ k l) :
    smoothedCyclicTotalTurning γ hγ k l = cyclicTotalTurning γ hγ := by
  rw [smoothedCyclicTotalTurning_from_necSuf, cyclicTotalTurning_from_necSuf]
  obtain ⟨hkl, hcr⟩ := hcross
  exact Ising2DLambda.NecSuf.KacWard.smoothing_cyclic_turning_invariance_walk_necSuf
    (fun e f => f ∈ nonbacktrackingSuccessors e) stepTurning directionNumber
    (Int.castAddHom (ZMod 4))
    (fun D h => (ZMod.intCast_zmod_eq_zero_iff_dvd D 4).mp h)
    stepTurning_mem
    (fun e f hf => step_advances_direction e f hf)
    γ hkl hcr.1 hcr.2.1
    (swappedExit_mem_nonbacktrackingSuccessors hcr)
    (swappedExit_mem_nonbacktrackingSuccessors' hcr) hcr.2.2.2.1 hcr.2.2.2.2.1

end Ising2DLambda.KacWard
