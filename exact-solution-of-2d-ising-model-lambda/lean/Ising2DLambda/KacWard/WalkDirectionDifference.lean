/-
「非後退辺列の両端の方向番号の差は総回転数の剰余類である」（`claim_walk_direction_difference`）と
「閉歩道の循環総回転数は 4 の倍数である」（`claim_cyclic_total_turning_multiple_of_four`）の、
実際の向き付き辺列についての具体版。

  人手証明                                    このファイル
  辺の本数についての帰納法                    `m` についての帰納法（辺の本数は `m + 1`）
  一歩は方向番号を回転数だけ進める             `step_advances_direction`
  π₄ の零元・加法性                            `directionResidueProjection`・`directionResidueProjection_add`
  総回転数の空和・末尾の項の分離               `edgeSequenceTotalTurning` と `Fin.sum_univ_castSucc`
  循環総回転数の定義                          `cyclicTotalTurning_eq`
  両辺から方向番号を引く                      `add_left_cancel`
  零剰余類との等号 ⇔ 4 の倍数                  `ZMod.intCast_zmod_eq_zero_iff_dvd`

住処は ℤ と ℤ/4ℤ だけであり、ℝ / ℂ は現れない。必要十分版は import しない。
-/
import Ising2DLambda.KacWard.CyclicTotalTurning

namespace Ising2DLambda.KacWard

/-- `claim_walk_direction_difference` の具体版。非後退辺列 `γ_0, …, γ_m` について
`dir(γ_m) = dir(γ_0) + π₄(t(γ))`。 -/
theorem walk_direction_difference {L : ℕ} [NeZero L] :
    ∀ (m : ℕ) (γ : Fin (m + 1) → OrientedEdge L),
      nonbacktrackingEdgeSequence γ →
        directionNumber (γ (Fin.last m)) =
          directionNumber (γ 0) + directionResidueProjection (edgeSequenceTotalTurning γ) := by
  intro m
  induction m with
  | zero =>
    intro γ _
    -- 底: 辺が一本なら総回転数は空和の零で、π₄(0) は零元である。
    have hsum : edgeSequenceTotalTurning γ = 0 := by
      simp [edgeSequenceTotalTurning]
    rw [hsum]
    simp [directionResidueProjection]
  | succ m ih =>
    intro γ hγ
    -- 短くした列 γ' は先頭の m + 1 本である。
    let γ' : Fin (m + 1) → OrientedEdge L := fun i => γ (Fin.castSucc i)
    have hγ' : nonbacktrackingEdgeSequence γ' := by
      intro k
      exact hγ (Fin.castSucc k)
    have hlast : γ (Fin.last (m + 1)) ∈
        nonbacktrackingSuccessors (γ (Fin.castSucc (Fin.last m))) := by
      simpa using hγ (Fin.last m)
    -- 総回転数の有限和から末尾の項を分離する。
    have hsplit : edgeSequenceTotalTurning γ =
        edgeSequenceTotalTurning γ' +
          stepTurning (γ (Fin.castSucc (Fin.last m))) (γ (Fin.last (m + 1))) := by
      simp only [edgeSequenceTotalTurning, γ']
      rw [Fin.sum_univ_castSucc]
      simp
    calc
      directionNumber (γ (Fin.last (m + 1)))
          = directionNumber (γ (Fin.castSucc (Fin.last m))) +
              directionResidueProjection
                (stepTurning (γ (Fin.castSucc (Fin.last m))) (γ (Fin.last (m + 1)))) :=
            step_advances_direction _ _ hlast
      _ = directionNumber (γ' 0) + directionResidueProjection (edgeSequenceTotalTurning γ') +
              directionResidueProjection
                (stepTurning (γ (Fin.castSucc (Fin.last m))) (γ (Fin.last (m + 1)))) := by
            rw [show γ (Fin.castSucc (Fin.last m)) = γ' (Fin.last m) from rfl, ih γ' hγ']
      _ = directionNumber (γ' 0) + directionResidueProjection
              (edgeSequenceTotalTurning γ' +
                stepTurning (γ (Fin.castSucc (Fin.last m))) (γ (Fin.last (m + 1)))) := by
            rw [directionResidueProjection_add, add_assoc]
      _ = directionNumber (γ 0) + directionResidueProjection (edgeSequenceTotalTurning γ) := by
            rw [hsplit]
            rfl

/-- `claim_cyclic_total_turning_multiple_of_four` の具体版。閉じた非後退辺列の
循環総回転数の剰余類は零である。 -/
theorem cyclicTotalTurning_residue_eq_zero {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ) :
    directionResidueProjection (cyclicTotalTurning γ hγ) = 0 := by
  have hchain : directionNumber (γ 0) + 0 =
      directionNumber (γ 0) + directionResidueProjection (cyclicTotalTurning γ hγ) :=
    calc
      directionNumber (γ 0) + 0 = directionNumber (γ 0) := add_zero _
      _ = directionNumber (γ (Fin.last m)) +
            directionResidueProjection (stepTurning (γ (Fin.last m)) (γ 0)) :=
          step_advances_direction _ _ hγ.2
      _ = directionNumber (γ 0) + directionResidueProjection (edgeSequenceTotalTurning γ) +
            directionResidueProjection (stepTurning (γ (Fin.last m)) (γ 0)) := by
          rw [walk_direction_difference m γ hγ.1]
      _ = directionNumber (γ 0) + directionResidueProjection
            (edgeSequenceTotalTurning γ + stepTurning (γ (Fin.last m)) (γ 0)) := by
          rw [directionResidueProjection_add, add_assoc]
      _ = directionNumber (γ 0) + directionResidueProjection (cyclicTotalTurning γ hγ) := by
          rw [cyclicTotalTurning_eq]
  exact (add_left_cancel hchain).symm

/-- 零剰余類との等号を整数の整除へ言い換える。 -/
theorem four_dvd_cyclicTotalTurning {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ) :
    (4 : ℤ) ∣ cyclicTotalTurning γ hγ :=
  (ZMod.intCast_zmod_eq_zero_iff_dvd (cyclicTotalTurning γ hγ) 4).mp
    (cyclicTotalTurning_residue_eq_zero γ hγ)

end Ising2DLambda.KacWard
