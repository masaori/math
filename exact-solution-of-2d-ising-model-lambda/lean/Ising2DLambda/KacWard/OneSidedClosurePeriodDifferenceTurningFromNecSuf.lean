/-
周期数差の合成を、実際の一側閉包へ特殊化する。
射影の単位性、四部分の同定、元周期、戻り周期は、それぞれ具体的な既存補題から得る。
-/
import Ising2DLambda.KacWard.OneSidedClosurePeriodDifferenceTurning
import Ising2DLambda.KacWard.OneSidedClosureCyclicSumFromNecSuf
import Ising2DLambda.KacWard.PeriodicPlaneLiftPeriodTurningFromNecSuf

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

theorem oneSidedClosure_periodDifferenceTurning_from_necSuf
    (m L : ℕ) [NeZero m] [NeZero L] (base : ℤ → ℤ × ℤ) (wv wh k₀ : ℤ) (t c : ℕ)
    (γ : ZMod m → OrientedEdge L)
    (hstep : ∀ j : ℕ, j < m →
      base ((j : ℤ) + 1) = base j + orientedEdgeLatticeStep (γ (j : ZMod m)))
    (hend : base m = base 0 + windingShift L wv wh)
    (hn : 0 < L * wh.natAbs + L * wv.natAbs)
    (hb : 0 < t * (wh.natAbs + wv.natAbs)) (hc : 0 < c) :
    oneSidedClosureProjectedTurning m L base wv wh k₀ t (c + 1) -
        oneSidedClosureProjectedTurning m L base wv wh k₀ t c =
      ∑ j : ZMod m, directionPairTurning (directionNumber (γ j)) (directionNumber (γ (j + 1))) := by
  let p := fun i : ℕ => periodicPlaneLift m base L wv wh (k₀ + i)
  let b := t * (wh.natAbs + wv.natAbs)
  let n := L * wh.natAbs + L * wv.natAbs
  let D := iteratedTransverseStaircase wh wv 0
  let u : Fin m → ℤ × ℤ := fun i => p (i.val + 1) - p i.val
  let v : Fin b → ℤ × ℤ := fun i => D (i.val + 1) - D i.val
  let r : Fin n → ℤ × ℤ := fun i => negatedParallelStaircaseStep L wh wv i.val
  let x : Fin b → ℤ × ℤ := fun i => D (b - (i.val + 1)) - D (b - i.val)
  let N := oneSidedClosureLength m L wv wh t
  let W := oneSidedClosurePoint m L base wv wh k₀ t
  let C := fun k => cyclicAdjacentSum latticeStepTurning (N k) (fun j => W k (j + 1) - W k j)
  have hm : 0 < m := NeZero.pos m
  apply oneSidedClosure_periodDifferenceTurning_necSuf latticeStepTurning
    (extendLatticeWord u) (extendLatticeWord v) (extendLatticeWord r) (extendLatticeWord x)
    (oneSidedClosureProjectedTurning m L base wv wh k₀ t) C _ m b n c hm hb hn hc
  · intro k hk
    exact oneSidedClosureProjectedTurning_eq_lattice m L base wv wh k₀ t k γ hstep hend hn hb hk
  · intro k hk
    exact oneSidedClosure_cyclicTurning_identification_from_necSuf m L base wv wh k₀ t k hm hn hb hk
  · calc
      _ = cyclicAdjacentSum latticeStepTurning m (fun j => p (j + 1) - p j) :=
        cyclicTurning_extend_finite_word m hm _
      _ = _ := by
        simpa [p, Nat.cast_add, add_assoc] using
          periodicPlaneLift_periodTurning_from_necSuf m L base wv wh γ hstep hend k₀
  · calc
      _ = cyclicAdjacentSum latticeStepTurning n (negatedParallelStaircaseStep L wh wv) :=
        cyclicTurning_extend_finite_word n hn _
      _ = 0 := negatedParallelStaircase_turning_via_projection L wh wv hn

end Ising2DLambda.KacWard
