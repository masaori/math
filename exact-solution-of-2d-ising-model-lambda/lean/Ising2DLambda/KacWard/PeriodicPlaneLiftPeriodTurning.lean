/-
周期持ち上げの任意の一周期の回転和を、元の辺列の方向回転和へ同定する。
本文の整数除法、周期の端をまたぐ一歩の場合分け、方向表、巡回移動に対応する。
元の辺列が閉じた非後退辺列なら、右辺はその循環総回転数である。
-/
import Ising2DLambda.KacWard.PeriodicLiftStepRepetition
import Ising2DLambda.KacWard.PlaneProjectionCyclicTurning
import Ising2DLambda.KacWard.CyclicShiftAdjacentSum
import Ising2DLambda.NecSuf.KacWard.PeriodicPlaneLiftPeriodTurning
import Ising2DLambda.NecSuf.KacWard.PlaneDisplacement
import Ising2DLambda.KacWard.DirectionUnitVector

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- `def_plane_displacement` の行・列の二成分を、辺の種類と向きから読む。 -/
def orientedEdgeLatticeStep {L : ℕ} (e : OrientedEdge L) : ℤ × ℤ :=
  if e.1.val < L ^ 2 then (if e.2 then (0, -1) else (0, 1))
  else (if e.2 then (-1, 0) else (1, 0))

theorem orientedEdgeLatticeStep_from_necSuf {L : ℕ} (e : OrientedEdge L) :
    orientedEdgeLatticeStep e =
      Ising2DLambda.NecSuf.KacWard.planeDisplacement
        (fun edge => decide (edge.val < L ^ 2)) e := by
  simp only [orientedEdgeLatticeStep,
    Ising2DLambda.NecSuf.KacWard.planeDisplacement, decide_eq_true_eq]

theorem orientedEdgeLatticeStep_eq_directionUnitVector {L : ℕ}
    (e : OrientedEdge L) :
    orientedEdgeLatticeStep e = directionUnitVector (directionNumber e) := by
  rcases e with ⟨edge, reverse⟩
  by_cases hh : edge.val < L ^ 2 <;> cases reverse <;>
    simp [orientedEdgeLatticeStep, directionUnitVector, directionNumber, hh] <;> decide

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
    simp [periodicPlaneLift,
      Int.emod_eq_of_lt (by omega : (0 : ℤ) ≤ j) (by omega : (j : ℤ) < m),
      Int.ediv_eq_zero_of_lt (by omega : (0 : ℤ) ≤ j) (by omega : (j : ℤ) < m)]
  have hterminal : periodicPlaneLift m base L wv wh m = base m := by
    simp [periodicPlaneLift, Int.ediv_self hmz, hend]
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

/-- 一周期内の最後の項を剰余類の零番目へ戻す。 -/
private theorem cyclicAdjacentSum_latticeStep_zmod
    (m : ℕ) [NeZero m] (v : ZMod m → ℤ × ℤ) :
    cyclicAdjacentSum latticeStepTurning m (fun j => v (j : ZMod m)) =
      ∑ j : ZMod m, latticeStepTurning (v j) (v (j + 1)) := by
  let f : ℕ → ℤ := fun j => latticeStepTurning (v (j : ZMod m))
    (v ((j + 1 : ℕ) : ZMod m))
  have hcast (i : Fin m) : ZMod.finEquiv m i = (i.val : ZMod m) := by
    cases m with
    | zero => exact Fin.elim0 i
    | succ n => exact (ZMod.natCast_zmod_val (n := n + 1) i).symm
  have hsum : (∑ j : ZMod m, latticeStepTurning (v j) (v (j + 1))) =
      ∑ j ∈ Finset.range m, f j := by
    calc
      _ = ∑ i : Fin m, latticeStepTurning (v (ZMod.finEquiv m i))
          (v (ZMod.finEquiv m i + 1)) :=
        (Equiv.sum_comp (ZMod.finEquiv m).toEquiv
          (fun j => latticeStepTurning (v j) (v (j + 1)))).symm
      _ = ∑ i : Fin m, f i.val := by
        apply Finset.sum_congr rfl
        intro i _
        simp only [hcast, f, Nat.cast_add, Nat.cast_one]
      _ = ∑ j ∈ Finset.range m, f j := Fin.sum_univ_eq_sum_range f m
  have hm : m - 1 + 1 = m := Nat.sub_add_cancel (NeZero.one_le : 1 ≤ m)
  have hlast : f (m - 1) = latticeStepTurning (v ((m - 1 : ℕ) : ZMod m)) (v 0) := by
    dsimp only [f]
    rw [hm, ZMod.natCast_self]
  calc
    _ = (∑ j ∈ Finset.range (m - 1), f j) + f (m - 1) := by
      rw [hlast]
      simp only [cyclicAdjacentSum, f, Nat.cast_zero]
    _ = ∑ j ∈ Finset.range (m - 1 + 1), f j :=
      (Finset.sum_range_succ f (m - 1)).symm
    _ = ∑ j ∈ Finset.range m, f j := by rw [hm]
    _ = _ := hsum.symm

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
      cyclicAdjacentSum_latticeStep_zmod m
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
