/-
周期持ち上げの任意の一周期の回転和を、元の辺列の方向回転和へ同定する。
本文の整数除法、周期の端をまたぐ一歩の場合分け、方向表、巡回移動に対応する。
元の辺列が閉じた非後退辺列なら、右辺はその循環総回転数である。
-/
import Ising2DLambda.KacWard.PeriodicLiftStepRepetition
import Ising2DLambda.KacWard.PlaneProjectionCyclicTurning
import Ising2DLambda.KacWard.CyclicShiftAdjacentSum
import Ising2DLambda.NecSuf.KacWard.PeriodicPlaneLiftPeriodTurning

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- `def_plane_displacement` の行・列の二成分を、辺の種類と向きから読む。 -/
def orientedEdgeLatticeStep {L : ℕ} (e : OrientedEdge L) : ℤ × ℤ :=
  if e.1.val < L ^ 2 then (if e.2 then (0, -1) else (0, 1))
  else (if e.2 then (-1, 0) else (1, 0))

theorem orientedEdgeLatticeStep_unit {L : ℕ} (e : OrientedEdge L) :
    orientedEdgeLatticeStep e = (0, 1) ∨ orientedEdgeLatticeStep e = (1, 0) ∨
      orientedEdgeLatticeStep e = (0, -1) ∨ orientedEdgeLatticeStep e = (-1, 0) := by
  rcases e with ⟨edge, reverse⟩
  by_cases hh : edge.val < L ^ 2 <;> cases reverse <;>
    simp [orientedEdgeLatticeStep, hh]

theorem orientedEdgeLatticeStep_direction {L : ℕ} (e : OrientedEdge L) :
    unitStepDirection (orientedEdgeLatticeStep e) = directionNumber e := by
  rcases e with ⟨edge, reverse⟩
  by_cases hh : edge.val < L ^ 2 <;> cases reverse <;>
    norm_num [orientedEdgeLatticeStep, unitStepDirection, directionNumber, hh]

theorem orientedEdgeLatticeStep_turning {L : ℕ} (e f : OrientedEdge L) :
    latticeStepTurning (orientedEdgeLatticeStep e) (orientedEdgeLatticeStep f) =
      directionPairTurning (directionNumber e) (directionNumber f) := by
  calc
    _ = directionPairTurning (unitStepDirection (orientedEdgeLatticeStep e))
        (unitStepDirection (orientedEdgeLatticeStep f)) :=
      (unitStepDirection_turning _ _ (orientedEdgeLatticeStep_unit e)
        (orientedEdgeLatticeStep_unit f)).symm
    _ = _ := by rw [orientedEdgeLatticeStep_direction, orientedEdgeLatticeStep_direction]

/-- 漸化式の最後の一歩には、端点の周期並進を代入する。 -/
theorem periodicPlaneLift_step_edgeDisplacement
    (m L : ℕ) [NeZero m] (base : ℤ → ℤ × ℤ) (wv wh : ℤ)
    (γ : ZMod m → OrientedEdge L)
    (hstep : ∀ j : ℕ, j < m →
      base ((j : ℤ) + 1) = base j + orientedEdgeLatticeStep (γ (j : ZMod m)))
    (hend : base m = base 0 + windingShift L wv wh) (k : ℤ) :
    periodicPlaneLift m base L wv wh (k + 1) - periodicPlaneLift m base L wv wh k =
      orientedEdgeLatticeStep (γ (k : ZMod m)) := by
  have hm : 0 < m := NeZero.pos m
  have hmz : (m : ℤ) ≠ 0 := by omega
  have hbase (j : ℕ) (hj : j < m) : periodicPlaneLift m base L wv wh j = base j := by
    simp [periodicPlaneLift, periodicLiftCore,
      Int.emod_eq_of_lt (by omega : (0 : ℤ) ≤ j) (by omega : (j : ℤ) < m),
      Int.ediv_eq_zero_of_lt (by omega : (0 : ℤ) ≤ j) (by omega : (j : ℤ) < m)]
  have hterminal : periodicPlaneLift m base L wv wh m = base m := by
    simp [periodicPlaneLift, periodicLiftCore, Int.ediv_self hmz, hend]
  have hfinite (j : ℕ) (hj : j < m) :
      periodicPlaneLift m base L wv wh ((j : ℤ) + 1) -
          periodicPlaneLift m base L wv wh j = orientedEdgeLatticeStep (γ (j : ZMod m)) := by
    have hnext : periodicPlaneLift m base L wv wh ((j : ℤ) + 1) = base ((j : ℤ) + 1) := by
      by_cases hlt : j + 1 < m
      · exact_mod_cast hbase (j + 1) hlt
      · have heq : (j : ℤ) + 1 = m := by omega
        rw [heq, hterminal]
    rw [hnext, hbase j hj, hstep j hj]
    abel
  -- 既存の任意整数位置の余りへの同定を使うので、負の基点も含む。
  calc
    _ = periodicPlaneLift m base L wv wh (k % m + 1) -
        periodicPlaneLift m base L wv wh (k % m) := by
      simpa only [zero_add] using periodicPlaneLift_step_remainder m L hm base wv wh 0 k
    _ = periodicPlaneLift m base L wv wh (((k : ZMod m).val : ℤ) + 1) -
        periodicPlaneLift m base L wv wh ((k : ZMod m).val : ℤ) := by
      rw [ZMod.val_intCast]
    _ = orientedEdgeLatticeStep (γ ((k : ZMod m).val : ZMod m)) :=
      hfinite _ (ZMod.val_lt _)
    _ = orientedEdgeLatticeStep (γ (k : ZMod m)) := by rw [ZMod.natCast_zmod_val]

/-- `claim_periodic_plane_lift_period_turning`。元の辺そのものの同一視は使わない。 -/
theorem periodicPlaneLift_periodTurning
    (m L : ℕ) [NeZero m] (base : ℤ → ℤ × ℤ) (wv wh : ℤ)
    (γ : ZMod m → OrientedEdge L)
    (hstep : ∀ j : ℕ, j < m →
      base ((j : ℤ) + 1) = base j + orientedEdgeLatticeStep (γ (j : ZMod m)))
    (hend : base m = base 0 + windingShift L wv wh) (k₀ : ℤ) :
    cyclicAdjacentSum latticeStepTurning m
        (fun j => periodicPlaneLift m base L wv wh (k₀ + j + 1) -
          periodicPlaneLift m base L wv wh (k₀ + j)) =
      ∑ j : ZMod m, directionPairTurning (directionNumber (γ j)) (directionNumber (γ (j + 1))) := by
  have hsteps : (fun j : ℕ => periodicPlaneLift m base L wv wh (k₀ + j + 1) -
      periodicPlaneLift m base L wv wh (k₀ + j)) =
      (fun j : ℕ => orientedEdgeLatticeStep (γ ((j : ZMod m) + (k₀ : ZMod m)))) := by
    funext j
    rw [periodicPlaneLift_step_edgeDisplacement m L base wv wh γ hstep hend]
    simp [Int.cast_add, add_comm]
  calc
    _ = cyclicAdjacentSum latticeStepTurning m
        (fun j => orientedEdgeLatticeStep (γ ((j : ZMod m) + (k₀ : ZMod m)))) :=
      congrArg (cyclicAdjacentSum latticeStepTurning m) hsteps
    _ = ∑ j : ZMod m, latticeStepTurning (orientedEdgeLatticeStep (γ (j + (k₀ : ZMod m))))
        (orientedEdgeLatticeStep (γ ((j + 1) + (k₀ : ZMod m)))) :=
      cyclicAdjacentSum_zmod m latticeStepTurning
        (fun j => orientedEdgeLatticeStep (γ (j + (k₀ : ZMod m))))
    _ = ∑ j : ZMod m, latticeStepTurning (orientedEdgeLatticeStep (γ j))
        (orientedEdgeLatticeStep (γ (j + 1))) :=
      cyclicShift_adjacent_integer_sum (k₀ : ZMod m)
        (fun i j => latticeStepTurning (orientedEdgeLatticeStep (γ i)) (orientedEdgeLatticeStep (γ j)))
    _ = _ := by
      apply Finset.sum_congr rfl
      intro j _
      exact orientedEdgeLatticeStep_turning _ _

end Ising2DLambda.KacWard
