/- 反転平行階段の循環総回転数零。整数格子の歩を用い、本文の一方向・二方向の二場合を保つ。 -/
import Ising2DLambda.KacWard.WindingParallelStaircase
import Ising2DLambda.NecSuf.KacWard.TotalTurning
import Ising2DLambda.NecSuf.KacWard.ReversedParallelStaircaseTurning

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 単位非後退歩では `def_step_turning` に一致する整数の表。 -/
def latticeStepTurning (u v : ℤ × ℤ) : ℤ := u.2 * v.1 - u.1 * v.2

def turnedLatticeStep (u : ℤ × ℤ) : Turn → ℤ × ℤ
  | .straight => u
  | .left => (u.2, -u.1)
  | .right => (-u.2, u.1)

theorem latticeStepTurning_eq_turnValue (u : ℤ × ℤ)
    (hu : u = (0, 1) ∨ u = (1, 0) ∨ u = (0, -1) ∨ u = (-1, 0))
    (turn : Turn) : latticeStepTurning u (turnedLatticeStep u turn) = turnValue turn := by
  rcases hu with rfl | rfl | rfl | rfl <;> cases turn <;>
    norm_num [latticeStepTurning, turnedLatticeStep, turnValue]

/-- 有効な単位歩対から、直進・左回転・右回転の型を読む。 -/
def latticeTurnOfSteps (u v : ℤ × ℤ) : Turn :=
  if v = u then .straight else if v = (u.2, -u.1) then .left else .right

theorem latticeTurnOfSteps_spec (u v : ℤ × ℤ)
    (hu : u = (0, 1) ∨ u = (1, 0) ∨ u = (0, -1) ∨ u = (-1, 0))
    (hv : v = (0, 1) ∨ v = (1, 0) ∨ v = (0, -1) ∨ v = (-1, 0))
    (hback : v ≠ -u) :
    turnedLatticeStep u (latticeTurnOfSteps u v) = v ∧
      turnValue (latticeTurnOfSteps u v) = latticeStepTurning u v := by
  have hturn : turnedLatticeStep u (latticeTurnOfSteps u v) = v := by
    rcases hu with rfl | rfl | rfl | rfl <;>
      rcases hv with rfl | rfl | rfl | rfl <;>
      norm_num [latticeTurnOfSteps, turnedLatticeStep] at *
  refine ⟨hturn, ?_⟩
  have hvalue := latticeStepTurning_eq_turnValue u hu (latticeTurnOfSteps u v)
  rw [hturn] at hvalue
  exact hvalue.symm

theorem latticeStepTurning_self (u : ℤ × ℤ) : latticeStepTurning u u = 0 := by
  unfold latticeStepTurning
  ring

theorem latticeStepTurning_reverse_cancel (u v : ℤ × ℤ) :
    latticeStepTurning u v + latticeStepTurning v u = 0 := by
  unfold latticeStepTurning
  ring

/-- 本文と同じく、空の区間を先に除き、唯一の内部接合を有限和から取り出す。 -/
theorem twoBlock_latticeTurning_zero (p q : ℕ) (a b : ℤ × ℤ) :
    cyclicAdjacentSum latticeStepTurning (p + q) (twoBlockSequence p a b) = 0 := by
  by_cases hp : p = 0
  · simp [cyclicAdjacentSum, twoBlockSequence, hp, latticeStepTurning_self]
  by_cases hq : q = 0
  · have hinternal : (∑ s ∈ Finset.range (p - 1),
        latticeStepTurning (twoBlockSequence p a b s)
          (twoBlockSequence p a b (s + 1))) = 0 := by
      apply Finset.sum_eq_zero
      intro s hs
      have hs' := Finset.mem_range.mp hs
      simp [twoBlockSequence, show s < p by omega, show s + 1 < p by omega,
        latticeStepTurning_self]
    simp only [hq, Nat.add_zero, cyclicAdjacentSum]
    rw [hinternal]
    simp [twoBlockSequence, show p - 1 < p by omega, show 0 < p by omega,
      latticeStepTurning_self]
  · have hinternal : (∑ s ∈ Finset.range (p + q - 1),
        latticeStepTurning (twoBlockSequence p a b s)
          (twoBlockSequence p a b (s + 1))) = latticeStepTurning a b := by
      rw [Finset.sum_eq_single (p - 1)]
      · simp [twoBlockSequence, show p - 1 < p by omega,
          show ¬p - 1 + 1 < p by omega]
      · intro s _ hs
        by_cases hsp : s < p
        · simp [twoBlockSequence, hsp, show s + 1 < p by omega, latticeStepTurning_self]
        · simp [twoBlockSequence, hsp, show ¬s + 1 < p by omega, latticeStepTurning_self]
      · intro hnot
        exact False.elim (hnot (Finset.mem_range.mpr (by omega)))
    unfold cyclicAdjacentSum
    rw [hinternal]
    simpa [twoBlockSequence, show ¬p + q - 1 < p by omega, show 0 < p by omega]
      using latticeStepTurning_reverse_cancel a b

def reversedParallelStaircaseStep (L : ℕ) (wh wv : ℤ) (s : ℕ) : ℤ × ℤ :=
  windingParallelStaircase L wh wv (L * wh.natAbs + L * wv.natAbs - 1 - s) -
    windingParallelStaircase L wh wv (L * wh.natAbs + L * wv.natAbs - s)

theorem reversedParallelStaircaseStep_unit_negative (L : ℕ) (wh wv : ℤ) (s : ℕ)
    (hs : s < L * wh.natAbs + L * wv.natAbs) :
    let u := reversedParallelStaircaseStep L wh wv s
    (u = (0, 1) ∨ u = (1, 0) ∨ u = (0, -1) ∨ u = (-1, 0)) ∧
      windingParallelCoordinate wv wh u < 0 := by
  have hindex : L * wh.natAbs + L * wv.natAbs - s =
      (L * wh.natAbs + L * wv.natAbs - 1 - s) + 1 := by omega
  have hstep := windingParallelStaircase_step_increase L wh wv
    (L * wh.natAbs + L * wv.natAbs - 1 - s) (by omega)
  dsimp only at hstep ⊢
  have heq : reversedParallelStaircaseStep L wh wv s =
      -(windingParallelStaircase L wh wv ((L * wh.natAbs + L * wv.natAbs - 1 - s) + 1) -
        windingParallelStaircase L wh wv (L * wh.natAbs + L * wv.natAbs - 1 - s)) := by
    unfold reversedParallelStaircaseStep
    rw [hindex, neg_sub]
  rw [heq]
  constructor
  · rcases hstep.1 with h | h | h | h <;> rw [h] <;> norm_num
  · rw [map_neg, map_sub]
    omega

/-- 共通の平行座標が各歩で減るので、二つの歩は逆向きにはならない。 -/
theorem reversedParallelStaircaseStep_turn_spec (L : ℕ) (wh wv : ℤ) (s t : ℕ)
    (hs : s < L * wh.natAbs + L * wv.natAbs)
    (ht : t < L * wh.natAbs + L * wv.natAbs) :
    let u := reversedParallelStaircaseStep L wh wv s
    let v := reversedParallelStaircaseStep L wh wv t
    turnedLatticeStep u (latticeTurnOfSteps u v) = v ∧
      turnValue (latticeTurnOfSteps u v) = latticeStepTurning u v := by
  have hu := reversedParallelStaircaseStep_unit_negative L wh wv s hs
  have hv := reversedParallelStaircaseStep_unit_negative L wh wv t ht
  apply latticeTurnOfSteps_spec _ _ hu.1 hv.1
  intro hback
  have hnegative := hv.2
  rw [hback, map_neg] at hnegative
  have := hu.2
  omega

/-- 本文の循環総回転数の各項を、整数の表の各項へ移す。 -/
theorem reversedParallelStaircase_turnValue_sum_eq (L : ℕ) (wh wv : ℤ)
    (hn : 0 < L * wh.natAbs + L * wv.natAbs) :
    cyclicAdjacentSum (fun u v => turnValue (latticeTurnOfSteps u v))
      (L * wh.natAbs + L * wv.natAbs) (reversedParallelStaircaseStep L wh wv) =
    cyclicAdjacentSum latticeStepTurning (L * wh.natAbs + L * wv.natAbs)
      (reversedParallelStaircaseStep L wh wv) := by
  unfold cyclicAdjacentSum
  congr 1
  · apply Finset.sum_congr rfl
    intro s hs
    have hs' := Finset.mem_range.mp hs
    exact (reversedParallelStaircaseStep_turn_spec L wh wv s (s + 1)
      (by omega) (by omega)).2
  · exact (reversedParallelStaircaseStep_turn_spec L wh wv
      (L * wh.natAbs + L * wv.natAbs - 1) 0 (by omega) hn).2

/-- 反転すると区間の順序と各歩の符号がともに反転する。 -/
theorem reversedParallelStaircaseStep_eq (L : ℕ) (wh wv : ℤ) (s : ℕ)
    (hs : s < L * wh.natAbs + L * wv.natAbs) :
    reversedParallelStaircaseStep L wh wv s =
      if 0 < wh * wv then
        twoBlockSequence (L * wv.natAbs) (- (Int.sign wv, 0)) (- (0, Int.sign wh)) s
      else
        twoBlockSequence (L * wh.natAbs) (- (0, Int.sign wh)) (- (Int.sign wv, 0)) s := by
  unfold reversedParallelStaircaseStep windingParallelStaircase orderedTwoPhaseStaircase
  by_cases horder : 0 < wh * wv
  · simp only [if_pos horder]
    exact reversedTwoPhaseStaircase_difference_necSuf _ _ _ _ _ hs
  · simp only [if_neg horder]
    have hs' : s < L * wv.natAbs + L * wh.natAbs := by omega
    simpa only [Nat.add_comm] using
      reversedTwoPhaseStaircase_difference_necSuf
        (L * wv.natAbs) (L * wh.natAbs) (Int.sign wv, 0) (0, Int.sign wh) s hs'

theorem reversedParallelStaircase_cyclicSum_eq (L : ℕ) (wh wv : ℤ)
    (hn : 0 < L * wh.natAbs + L * wv.natAbs) :
    cyclicAdjacentSum latticeStepTurning (L * wh.natAbs + L * wv.natAbs)
      (reversedParallelStaircaseStep L wh wv) =
    if 0 < wh * wv then
      cyclicAdjacentSum latticeStepTurning (L * wv.natAbs + L * wh.natAbs)
        (twoBlockSequence (L * wv.natAbs) (- (Int.sign wv, 0)) (- (0, Int.sign wh)))
    else
      cyclicAdjacentSum latticeStepTurning (L * wh.natAbs + L * wv.natAbs)
        (twoBlockSequence (L * wh.natAbs) (- (0, Int.sign wh)) (- (Int.sign wv, 0))) := by
  have hlast : L * wh.natAbs + L * wv.natAbs - 1 <
      L * wh.natAbs + L * wv.natAbs := by omega
  unfold cyclicAdjacentSum
  rw [reversedParallelStaircaseStep_eq _ _ _ _ hlast,
    reversedParallelStaircaseStep_eq _ _ _ _ hn]
  by_cases horder : 0 < wh * wv
  · simp only [if_pos horder]
    rw [Nat.add_comm (L * wv.natAbs) (L * wh.natAbs)]
    congr 1
    apply Finset.sum_congr rfl
    intro s hs
    have hs' := Finset.mem_range.mp hs
    rw [reversedParallelStaircaseStep_eq _ _ _ _ (by omega),
      reversedParallelStaircaseStep_eq _ _ _ _ (by omega)]
    simp only [if_pos horder]
  · simp only [if_neg horder]
    congr 1
    apply Finset.sum_congr rfl
    intro s hs
    have hs' := Finset.mem_range.mp hs
    rw [reversedParallelStaircaseStep_eq _ _ _ _ (by omega),
      reversedParallelStaircaseStep_eq _ _ _ _ (by omega)]
    simp only [if_neg horder]

/-- `claim_reversed_parallel_staircase_turning_zero`。長さの正値性は末歩と始歩を読むために使う。 -/
theorem reversedParallelStaircase_latticeTurning_zero (L : ℕ) (wh wv : ℤ)
    (hn : 0 < L * wh.natAbs + L * wv.natAbs) :
    cyclicAdjacentSum latticeStepTurning (L * wh.natAbs + L * wv.natAbs)
      (reversedParallelStaircaseStep L wh wv) = 0 := by
  rw [reversedParallelStaircase_cyclicSum_eq L wh wv hn]
  split <;> exact twoBlock_latticeTurning_zero _ _ _ _

/-- `claim_reversed_parallel_staircase_turning_zero`。有効な回転の型の整数値の循環和。 -/
theorem reversedParallelStaircase_turning_zero (L : ℕ) (wh wv : ℤ)
    (hn : 0 < L * wh.natAbs + L * wv.natAbs) :
    cyclicAdjacentSum (fun u v => turnValue (latticeTurnOfSteps u v))
      (L * wh.natAbs + L * wv.natAbs) (reversedParallelStaircaseStep L wh wv) = 0 := by
  rw [reversedParallelStaircase_turnValue_sum_eq L wh wv hn]
  exact reversedParallelStaircase_latticeTurning_zero L wh wv hn

end Ising2DLambda.KacWard
