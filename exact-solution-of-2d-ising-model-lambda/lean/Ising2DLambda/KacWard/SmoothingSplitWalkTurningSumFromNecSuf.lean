/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.SmoothingSplitWalkTurningSum
import Ising2DLambda.NecSuf.KacWard.SmoothingSplitWalkTurningSum

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.PartitionPolynomial

variable {L m : ℕ}

variable [NeZero L]

/-- 具体版が必要十分版 `split_cyclic_sum_necSuf` の特殊化として得られること。
添字を `Fin (m + 1)`、`A` を `def_smoothing_index_blocks` の `A`、位置の写像を
`smoothedSplitIndexA`・`smoothedSplitIndexB`、各項を一歩の回転数に取る。 -/
theorem smoothing_split_walk_turning_sum_from_necSuf (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)}
    (hcross : indexPairCrossing γ hγ k l) (hkl : k < l) :
    cyclicTotalTurning (smoothedSplitWalkA γ hγ k l) (smoothedSplitWalkA_closed γ hγ hcross hkl)
      + cyclicTotalTurning (smoothedSplitWalkB γ hγ k l)
          (smoothedSplitWalkB_closed γ hγ hcross hkl)
      = smoothedCyclicTotalTurning γ hγ k l := by
  classical
  rw [cyclicTotalTurning_eq, edgeSequenceTotalTurning_eq, cyclicTotalTurning_eq,
    edgeSequenceTotalTurning_eq]
  exact Ising2DLambda.NecSuf.KacWard.split_cyclic_sum_necSuf
    (univ.filter (fun r => r ∈ smoothingIndexBlockA γ hγ k l))
    (fun r => stepTurning (γ r) (smoothedExitEdge γ k l r))
    (smoothedSplitIndexA k l) (smoothedSplitIndexB k l)
    (smoothedSplitIndexA_injective hkl) (smoothedSplitIndexB_injective hkl)
    (smoothedSplitIndexA_image γ hγ hkl) (smoothedSplitIndexB_image γ hγ hkl)
    _ _ _ _
    (fun j => smoothedSplitWalkA_inner_turning γ hγ hkl j)
    (smoothedSplitWalkA_closing_turning γ hγ hkl)
    (fun j => smoothedSplitWalkB_inner_turning γ hγ hkl j)
    (smoothedSplitWalkB_closing_turning γ hγ hkl)

end Ising2DLambda.KacWard
