/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.SmoothingSplitWalkSeamParity
import Ising2DLambda.NecSuf.KacWard.SmoothingSplitWalkSeamParity

namespace Ising2DLambda.KacWard

open Finset

variable {L m : ℕ}

/-- 具体版が必要十分版 `split_position_reading_pair_necSuf` の特殊化として得られること。
添字を `Fin (m + 1)`、`A` を `def_smoothing_index_blocks` の `A`、位置の写像を
`smoothedSplitIndexA`・`smoothedSplitIndexB`、値を ℕ、読み取りを二で割った余りに取る。 -/
theorem closedWalk_smoothing_split_seam_parity_from_necSuf (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) {k l : Fin (m + 1)} (hkl : k < l) :
    (((edgeSequenceSeamParities (List.ofFn (smoothedSplitWalkA γ hγ k l))).1
          + (edgeSequenceSeamParities (List.ofFn (smoothedSplitWalkB γ hγ k l))).1) % 2,
      ((edgeSequenceSeamParities (List.ofFn (smoothedSplitWalkA γ hγ k l))).2
          + (edgeSequenceSeamParities (List.ofFn (smoothedSplitWalkB γ hγ k l))).2) % 2)
      = edgeSequenceSeamParities (List.ofFn γ) := by
  classical
  simp only [edgeSequenceSeamParities, List.map_ofFn, List.sum_ofFn, Function.comp_apply,
    smoothedSplitWalkA_apply, smoothedSplitWalkB_apply]
  rw [← Nat.add_mod, ← Nat.add_mod]
  exact Ising2DLambda.NecSuf.KacWard.split_position_reading_pair_necSuf
    (univ.filter (fun r => r ∈ smoothingIndexBlockA γ hγ k l))
    (fun r => horizontalSeamParity (γ r)) (fun r => verticalSeamParity (γ r)) (· % 2)
    (smoothedSplitIndexA k l) (smoothedSplitIndexB k l)
    (smoothedSplitIndexA_injective hkl) (smoothedSplitIndexB_injective hkl)
    (smoothedSplitIndexA_image γ hγ hkl) (smoothedSplitIndexB_image γ hγ hkl)

end Ising2DLambda.KacWard
