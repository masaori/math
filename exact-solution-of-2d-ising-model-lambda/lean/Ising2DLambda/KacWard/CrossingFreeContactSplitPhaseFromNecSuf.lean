/-
「接触点分割の回転位相は交差形式で更新される」（`claim_crossing_free_contact_split_phase`）の具体版が、
必要十分版 `crossing_free_contact_split_phase_necSuf` の特殊化として得られることの記録。
位相の住処を `Qbar`、`s = −1`、一歩の回転数を `directionStepTurn 0`（方向番号の差による回転数）、
軸を `directionAxis`、方向番号を接触頂点の四つの辺の方向番号に取り、和の等式・混合横断数・交差形式は
具体版の各段（`contact_split_walk_turning_update`・`contact_split_mutual_crossing_eq_index`・
`contact_split_index_mutual_crossing_eq_indicator`・`closedWalkMutualCrossingNumber_eq_intersection`）で与える。
-/
import Ising2DLambda.KacWard.CrossingFreeContactSplitPhase
import Ising2DLambda.NecSuf.KacWard.CrossingFreeContactSplitPhase

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial
open Ising2DLambda.AlgebraicEigenvalue

variable {L m : ℕ} [NeZero L]

/-- 方向番号による一歩の回転数は、方向番号の差だけで決まる。 -/
theorem directionStepTurn_eq_sub (d d' : ZMod 4) :
    directionStepTurn d d' = directionStepTurn 0 (d' - d) := by
  revert d d'
  unfold directionStepTurn
  decide

/-- 具体版が必要十分版の特殊化として得られること。 -/
theorem crossing_free_contact_split_phase_from_necSuf {z : Qbar} (hz4 : z ^ 4 = -1)
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (hinj : Function.Injective fun r => (γ r).1)
    (hzero : closedWalkCrossingNumber γ hγ = 0)
    {k l : Fin (m + 1)} (hkl : k < l) (hcontact : orientedTarget (γ k) = orientedTarget (γ l)) :
    z ^ cyclicTotalTurning γ hγ =
      (-1 : Qbar) ^ (1 + evenEdgeChainIntersection L
          (closedWalkSupport (smoothedSplitWalkA γ hγ k l))
          (closedWalkSupport (smoothedSplitWalkB γ hγ k l))).val *
        z ^ (cyclicTotalTurning (smoothedSplitWalkA γ hγ k l)
              (contactSplitWalkA_closed γ hγ hinj hkl hcontact)
            + cyclicTotalTurning (smoothedSplitWalkB γ hγ k l)
              (contactSplitWalkB_closed γ hγ hinj hkl hcontact)) := by
  have hne : k ≠ l := ne_of_lt hkl
  have hA := contactSplitWalkA_closed γ hγ hinj hkl hcontact
  have hB := contactSplitWalkB_closed γ hγ hinj hkl hcontact
  have hz : z ≠ 0 := by
    intro h
    rw [h] at hz4
    norm_num at hz4
  have hturn1 : directionStepTurn 0 1 = 1 := by decide
  have hs : z ^ (4 * directionStepTurn 0 1) = -1 := by
    rw [hturn1, mul_one, show (4 : ℤ) = ((4 : ℕ) : ℤ) from rfl, zpow_natCast, hz4]
  obtain ⟨d1, d2, d3, d4, d5, d6⟩ := contact_halfEdge_directions_ne γ hγ hinj hne hcontact
  have hupdate := contact_split_walk_turning_update γ hγ hkl hA hB
  have hkk : stepTurning (γ k) (γ (closedWalkSuccessor k)) = directionStepTurn
      (directionNumber (γ k)) (directionNumber (γ (closedWalkSuccessor k))) :=
    stepTurning_eq_directionStepTurn (closedWalkPass_valid γ hγ k)
  have hll : stepTurning (γ l) (γ (closedWalkSuccessor l)) = directionStepTurn
      (directionNumber (γ l)) (directionNumber (γ (closedWalkSuccessor l))) :=
    stepTurning_eq_directionStepTurn (closedWalkPass_valid γ hγ l)
  rw [hkk, hll,
    stepTurning_eq_directionStepTurn
      (contactSwappedExit_mem_nonbacktrackingSuccessors γ hγ hinj hcontact),
    stepTurning_eq_directionStepTurn
      (contactSwappedExit_mem_nonbacktrackingSuccessors γ hγ hinj hcontact.symm),
    directionStepTurn_eq_sub (directionNumber (γ k)),
    directionStepTurn_eq_sub (directionNumber (γ l)),
    directionStepTurn_eq_sub (directionNumber (γ k)),
    directionStepTurn_eq_sub (directionNumber (γ l))] at hupdate
  have hc := (contact_split_mutual_crossing_eq_index γ hγ hinj hkl hcontact hA hB).trans
    (contact_split_index_mutual_crossing_eq_indicator γ hγ hinj hzero hkl hcontact)
  exact Ising2DLambda.NecSuf.KacWard.crossing_free_contact_split_phase_necSuf hz
    (fun x => directionStepTurn 0 x) (by decide) (by decide) hs (by norm_num)
    directionAxis (by unfold directionAxis; decide) (by unfold directionAxis; decide)
    _ _ _ _ d1 d2 d3 d4 d5 d6 (contact_not_straight_straight γ hγ hzero hne hcontact)
    _ _ _ hupdate _ hc _
    (closedWalkMutualCrossingNumber_eq_intersection
      (smoothedSplitWalkA γ hγ k l) hA (smoothedSplitWalkB γ hγ k l) hB
      (smoothedSplitWalkA_edge_injective γ hγ hinj hkl)
      (smoothedSplitWalkB_edge_injective γ hγ hinj hkl)
      (smoothedSplitWalks_edge_disjoint γ hγ hinj hkl))

end Ising2DLambda.KacWard
