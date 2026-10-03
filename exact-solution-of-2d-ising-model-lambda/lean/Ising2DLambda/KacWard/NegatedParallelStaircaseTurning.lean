/- `claim_negated_parallel_staircase_turning_zero` の具体版。
正の平行階段の点を同じ順で符号反転する。二区間の順序は反転しない。
歩の単位性・平行座標の負値、回転表との照合、二区間の相殺を本文と対応させる。 -/
import Ising2DLambda.KacWard.ReversedParallelStaircaseTurning
import Ising2DLambda.NecSuf.KacWard.NegatedParallelStaircaseTurning

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

def negatedParallelStaircaseStep (L : ℕ) (wh wv : ℤ) (s : ℕ) : ℤ × ℤ :=
  -windingParallelStaircase L wh wv (s + 1) - (-windingParallelStaircase L wh wv s)

theorem negatedParallelStaircaseStep_difference (L : ℕ) (wh wv : ℤ) (s : ℕ) :
    negatedParallelStaircaseStep L wh wv s =
      -(windingParallelStaircase L wh wv (s + 1) - windingParallelStaircase L wh wv s) := by
  simp [negatedParallelStaircaseStep, sub_eq_add_neg, add_comm]

/-- 四つの単位歩の符号を反転し、同じ平行座標の差を読む。 -/
theorem negatedParallelStaircaseStep_unit_negative (L : ℕ) (wh wv : ℤ) (s : ℕ)
    (hs : s < L * wh.natAbs + L * wv.natAbs) :
    let u := negatedParallelStaircaseStep L wh wv s
    (u = (0, 1) ∨ u = (1, 0) ∨ u = (0, -1) ∨ u = (-1, 0)) ∧
      windingParallelCoordinate wv wh u < 0 := by
  have hstep := windingParallelStaircase_step_increase L wh wv s hs
  dsimp only at hstep ⊢
  rw [negatedParallelStaircaseStep_difference]
  constructor
  · rcases hstep.1 with h | h | h | h <;> rw [h] <;> norm_num
  · rw [map_neg, map_sub]
    omega

/-- 両歩の平行座標が負であることから、非後退性を得て回転表へ移す。 -/
theorem negatedParallelStaircaseStep_turn_spec (L : ℕ) (wh wv : ℤ) (s t : ℕ)
    (hs : s < L * wh.natAbs + L * wv.natAbs)
    (ht : t < L * wh.natAbs + L * wv.natAbs) :
    let u := negatedParallelStaircaseStep L wh wv s
    let v := negatedParallelStaircaseStep L wh wv t
    turnedLatticeStep u (latticeTurnOfSteps u v) = v ∧
      turnValue (latticeTurnOfSteps u v) = latticeStepTurning u v := by
  have hu := negatedParallelStaircaseStep_unit_negative L wh wv s hs
  have hv := negatedParallelStaircaseStep_unit_negative L wh wv t ht
  apply latticeTurnOfSteps_spec _ _ hu.1 hv.1
  intro hback
  have hnegative := hv.2
  rw [hback, map_neg] at hnegative
  have := hu.2
  omega

theorem negatedParallelStaircase_turnValue_sum_eq (L : ℕ) (wh wv : ℤ)
    (hn : 0 < L * wh.natAbs + L * wv.natAbs) :
    cyclicAdjacentSum (fun u v => turnValue (latticeTurnOfSteps u v))
      (L * wh.natAbs + L * wv.natAbs) (negatedParallelStaircaseStep L wh wv) =
    cyclicAdjacentSum latticeStepTurning (L * wh.natAbs + L * wv.natAbs)
      (negatedParallelStaircaseStep L wh wv) := by
  unfold cyclicAdjacentSum
  congr 1
  · apply Finset.sum_congr rfl
    intro s hs
    have hs' := Finset.mem_range.mp hs
    exact (negatedParallelStaircaseStep_turn_spec L wh wv s (s + 1)
      (by omega) (by omega)).2
  · exact (negatedParallelStaircaseStep_turn_spec L wh wv
      (L * wh.natAbs + L * wv.natAbs - 1) 0 (by omega) hn).2

/-- 本文の二区間の表。空区間の方向は実際の歩として使われない。 -/
theorem negatedParallelStaircaseStep_eq (L : ℕ) (wh wv : ℤ) (s : ℕ) :
    negatedParallelStaircaseStep L wh wv s =
      if 0 < wh * wv then
        twoBlockSequence (L * wh.natAbs) (- (0, Int.sign wh)) (- (Int.sign wv, 0)) s
      else
        twoBlockSequence (L * wv.natAbs) (- (Int.sign wv, 0)) (- (0, Int.sign wh)) s := by
  rw [negatedParallelStaircaseStep_difference]
  unfold windingParallelStaircase orderedTwoPhaseStaircase
  by_cases horder : 0 < wh * wv <;> simp only [horder, ite_true, ite_false]
  all_goals
    rw [twoPhaseStaircase_difference_necSuf]
    unfold twoBlockSequence
    split <;> rfl

theorem negatedParallelStaircase_cyclicSum_eq (L : ℕ) (wh wv : ℤ) :
    cyclicAdjacentSum latticeStepTurning (L * wh.natAbs + L * wv.natAbs)
      (negatedParallelStaircaseStep L wh wv) =
    if 0 < wh * wv then
      cyclicAdjacentSum latticeStepTurning (L * wh.natAbs + L * wv.natAbs)
        (twoBlockSequence (L * wh.natAbs) (- (0, Int.sign wh)) (- (Int.sign wv, 0)))
    else
      cyclicAdjacentSum latticeStepTurning (L * wv.natAbs + L * wh.natAbs)
        (twoBlockSequence (L * wv.natAbs) (- (Int.sign wv, 0)) (- (0, Int.sign wh))) := by
  have hsteps := funext (negatedParallelStaircaseStep_eq L wh wv)
  rw [hsteps]
  by_cases horder : 0 < wh * wv
  · simp only [if_pos horder]
  · simp only [if_neg horder, Nat.add_comm (L * wv.natAbs) (L * wh.natAbs)]

theorem negatedParallelStaircase_latticeTurning_zero (L : ℕ) (wh wv : ℤ) :
    cyclicAdjacentSum latticeStepTurning (L * wh.natAbs + L * wv.natAbs)
      (negatedParallelStaircaseStep L wh wv) = 0 := by
  rw [negatedParallelStaircase_cyclicSum_eq]
  split <;> exact twoBlock_latticeTurning_zero _ _ _ _

/-- 有効な一歩の回転数の循環和。長さの正値性は末歩と始歩の存在に必要。 -/
theorem negatedParallelStaircase_turning_zero (L : ℕ) (wh wv : ℤ)
    (hn : 0 < L * wh.natAbs + L * wv.natAbs) :
    cyclicAdjacentSum (fun u v => turnValue (latticeTurnOfSteps u v))
      (L * wh.natAbs + L * wv.natAbs) (negatedParallelStaircaseStep L wh wv) = 0 := by
  rw [negatedParallelStaircase_turnValue_sum_eq L wh wv hn]
  exact negatedParallelStaircase_latticeTurning_zero L wh wv

end Ising2DLambda.KacWard
