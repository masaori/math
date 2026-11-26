/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.WalkDirectionDifference
import Ising2DLambda.NecSuf.KacWard.CyclicTurningVanishes

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

theorem directionResidueProjection_from_necSuf (n : ℤ) :
    directionResidueProjection n =
      Ising2DLambda.NecSuf.KacWard.residueProjection 4 n := rfl

/-- 具体版 `cyclicTotalTurning_residue_eq_zero` が必要十分版の特殊化として得られることの記録。
`A = ZMod 4`（加法群なので左簡約を持つ）、`φ` を整数キャスト（`Int.cast_zero` と `Int.cast_add` が
π₄ の零の保存と加法性）、更新量の列を実際の辺列の一歩の回転数の列、閉じる更新量を終辺から始辺への
一歩の回転数と取る。一周して方向番号が戻ることは、具体版の端の方向番号の差と一歩の方向の更新から得る。 -/
theorem cyclicTotalTurning_residue_eq_zero_from_necSuf {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ) :
    directionResidueProjection (cyclicTotalTurning γ hγ) = 0 := by
  let steps : List ℤ :=
    List.ofFn (fun k : Fin m => stepTurning (γ (Fin.castSucc k)) (γ (Fin.succ k)))
  let closing : ℤ := stepTurning (γ (Fin.last m)) (γ 0)
  have hsum : steps.sum = edgeSequenceTotalTurning γ := by
    simp [steps, edgeSequenceTotalTurning, List.sum_ofFn]
  have hclosed :
      steps.foldl (fun (a : ZMod 4) (n : ℤ) => a + (n : ZMod 4)) (directionNumber (γ 0)) +
          ((closing : ℤ) : ZMod 4) = directionNumber (γ 0) := by
    rw [foldl_add_of_additive_necSuf (fun n : ℤ => (n : ZMod 4)) Int.cast_zero Int.cast_add,
      hsum]
    have hwalk := walk_direction_difference m γ hγ.1
    have hstep := step_advances_direction _ _ hγ.2
    simp only [directionResidueProjection] at hwalk hstep
    rw [← hwalk, ← hstep]
  have h := closed_walk_additive_vanishes_necSuf (fun n : ℤ => (n : ZMod 4))
    Int.cast_zero Int.cast_add (directionNumber (γ 0)) steps closing hclosed
  rw [cyclicTotalTurning_eq, ← hsum]
  exact h

end Ising2DLambda.KacWard
