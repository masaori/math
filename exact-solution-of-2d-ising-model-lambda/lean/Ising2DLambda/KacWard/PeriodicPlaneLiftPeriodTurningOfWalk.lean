/-
`claim_periodic_plane_lift_period_turning` を、実際の閉じた非後退辺列 `γ` の周期持ち上げについて述べる具体版。
本文の証明と同じ根拠を通る: 周期の継ぎ目の端点は巻き付き終点公式（`planeLift_endpoint_winding`）、
任意の一歩は整数除法による並進（`periodicPlaneLift_step_remainder`）で一周期内の歩へ戻し、
その変位を方向の単位ベクトルとして読み（`orientedEdgeLatticeStep_eq_directionUnitVector`）、
十二方向対の表（`planeProjection_cyclicTurning`）で隣接対の回転を方向対の回転へ移し、
巡回移動（`cyclicShift_adjacent_integer_sum`）で基点を零へ戻す。
-/
import Ising2DLambda.KacWard.PlaneLiftIntegerBaseEndpoint
import Ising2DLambda.KacWard.WalkBoundaryVertexTurnSum

namespace Ising2DLambda.KacWard

theorem unitStepDirection_directionUnitVector (d : ZMod 4) :
    unitStepDirection (directionUnitVector d) = d := by
  fin_cases d <;> decide

theorem directionUnitVector_unit (d : ZMod 4) :
    directionUnitVector d = (0, 1) ∨ directionUnitVector d = (1, 0) ∨
      directionUnitVector d = (0, -1) ∨ directionUnitVector d = (-1, 0) := by
  fin_cases d <;> decide

/-- 剰余類で添字付けた隣接方向対の回転数の和は、循環総回転数（`def_total_turning` の和と閉じ目の一歩、
`def_cyclic_total_turning`）である。各項は一歩の回転数（`def_step_turning`）を方向対で読んだもの。 -/
private theorem sum_zmod_directionPairTurning_eq_cyclicTotalTurning {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ) :
    (∑ j : ZMod (m + 1),
        directionPairTurning
          (directionNumber (γ ⟨j.val, ZMod.val_lt j⟩))
          (directionNumber (γ ⟨(j + 1).val, ZMod.val_lt (j + 1)⟩))) =
      cyclicTotalTurning γ hγ := by
  rw [cyclicTotalTurning_eq_sum_finRotate]
  change ∑ j : Fin (m + 1),
    directionPairTurning (directionNumber (γ ⟨j.val, j.isLt⟩))
      (directionNumber (γ ⟨(j + 1).val, (j + 1).isLt⟩)) = _
  refine Finset.sum_congr rfl (fun j _ => ?_)
  rw [stepTurning_eq_directionPairTurning _ _
    (closedNonbacktrackingWalk_finRotate_successor γ hγ j), finRotate_apply]

/-- `claim_periodic_plane_lift_period_turning`。実際の閉じた非後退辺列の周期持ち上げの
任意の一周期の循環隣接和は、その辺列の循環総回転数である。 -/
theorem periodicPlaneLiftFromWalk_periodTurning {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ) (k₀ : ℤ) :
    cyclicAdjacentSum latticeStepTurning (m + 1)
        (fun j => periodicPlaneLiftFromWalk γ (k₀ + j + 1) -
          periodicPlaneLiftFromWalk γ (k₀ + j)) =
      cyclicTotalTurning γ hγ := by
  let γz : ZMod (m + 1) → OrientedEdge L := fun j => γ ⟨j.val, ZMod.val_lt j⟩
  let W : ℕ → ℤ × ℤ := fun j => periodicPlaneLiftFromWalk γ (k₀ + j)
  -- 一周期内の有限漸化式（`def_plane_lift`）
  have hstep (j : ℕ) (hj : j < m + 1) :
      planeLiftIntegerBase γ ((j : ℤ) + 1) =
        planeLiftIntegerBase γ j + orientedEdgeLatticeStep (γz (j : ZMod (m + 1))) := by
    simpa [γz, ZMod.val_natCast, Nat.mod_eq_of_lt hj] using
      planeLiftIntegerBase_step γ j hj
  -- 周期の継ぎ目: `P_m = P_0 + B`（`claim_plane_lift_endpoint_winding`）
  have hend := planeLiftIntegerBase_endpoint γ hγ
  -- 任意の一歩は辺 `γ_{[k₀+j]}` の変位で、その方向の単位ベクトルである
  have hu (j : ℕ) : W (j + 1) - W j =
      directionUnitVector (directionNumber (γz ((j : ZMod (m + 1)) + (k₀ : ZMod (m + 1))))) := by
    have h := periodicPlaneLift_step_edgeDisplacement (m + 1) L (planeLiftIntegerBase γ)
      (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) γz hstep hend
      (k₀ + j)
    rw [← orientedEdgeLatticeStep_eq_directionUnitVector]
    have hk : ((k₀ + (j : ℤ) : ℤ) : ZMod (m + 1)) =
        (j : ZMod (m + 1)) + (k₀ : ZMod (m + 1)) := by
      push_cast
      ring
    rw [← hk]
    simpa [W, periodicPlaneLiftFromWalk, Nat.cast_add, add_assoc] using h
  have hunit (j : ℕ) (_ : j < m + 1) :
      let u := W (j + 1) - W j
      u = (0, 1) ∨ u = (1, 0) ∨ u = (0, -1) ∨ u = (-1, 0) := by
    simp only
    rw [hu j]
    exact directionUnitVector_unit _
  -- 射影辺の方向は、元の辺の方向である
  have hdir (j : ℕ) :
      directionNumber (projectedUnitStep L (W j) (W (j + 1) - W j)) =
        directionNumber (γz ((j : ZMod (m + 1)) + (k₀ : ZMod (m + 1)))) := by
    rw [projectedUnitStep_direction, hu j, unitStepDirection_directionUnitVector]
  calc
    _ = cyclicAdjacentSum latticeStepTurning (m + 1) (fun j => W (j + 1) - W j) := by
      congr 1
      funext j
      simp only [W, Nat.cast_add, Nat.cast_one, add_assoc]
    _ = cyclicAdjacentSum
        (fun e f => directionPairTurning (directionNumber e) (directionNumber f)) (m + 1)
        (fun j => projectedUnitStep L (W j) (W (j + 1) - W j)) :=
      (planeProjection_cyclicTurning L (m + 1) (by omega) W hunit).symm
    _ = cyclicAdjacentSum directionPairTurning (m + 1)
        (fun j : ℕ => directionNumber (γz ((j : ZMod (m + 1)) + (k₀ : ZMod (m + 1))))) := by
      unfold cyclicAdjacentSum
      simp only [hdir]
    _ = ∑ j : ZMod (m + 1), directionPairTurning (directionNumber (γz (j + (k₀ : ZMod (m + 1)))))
        (directionNumber (γz ((j + 1) + (k₀ : ZMod (m + 1))))) :=
      cyclicAdjacentSum_zmod directionPairTurning (m + 1)
        (fun j => directionNumber (γz (j + (k₀ : ZMod (m + 1)))))
    _ = ∑ j : ZMod (m + 1), directionPairTurning (directionNumber (γz j))
        (directionNumber (γz (j + 1))) :=
      cyclicShift_adjacent_integer_sum (k₀ : ZMod (m + 1))
        (fun i j => directionPairTurning (directionNumber (γz i)) (directionNumber (γz j)))
    _ = cyclicTotalTurning γ hγ :=
      sum_zmod_directionPairTurning_eq_cyclicTotalTurning γ hγ

end Ising2DLambda.KacWard
