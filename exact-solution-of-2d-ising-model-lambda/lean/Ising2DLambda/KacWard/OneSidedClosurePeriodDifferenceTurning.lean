/-
実際の周期持ち上げから作った一側閉包について、周期数を一つ増やした回転和の差を求める。
射影、固定四部分列、反復差、元の辺列の一周期、符号反転平行階段の零の順に合成する。
方向対の重みは逆向きにも零で定義しているため、等式には単純性を要しない。
-/
import Ising2DLambda.KacWard.OneSidedClosureCyclicSum
import Ising2DLambda.KacWard.PeriodicPlaneLiftPeriodTurning
import Ising2DLambda.NecSuf.KacWard.OneSidedClosurePeriodDifferenceTurning

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 周期数だけを変える一側閉包の、実際の格子点列。 -/
def oneSidedClosurePoint (m L : ℕ) (base : ℤ → ℤ × ℤ) (wv wh k₀ : ℤ)
    (t c : ℕ) : ℕ → ℤ × ℤ :=
  let p := fun i : ℕ => periodicPlaneLift m base L wv wh (k₀ + i)
  let S := p 0
  let b := t * (wh.natAbs + wv.natAbs)
  let n := L * wh.natAbs + L * wv.natAbs
  oneSidedPeriodicLiftClosure p
    (iteratedTransverseStaircase wh wv (S + c • windingShift L wv wh))
    (oneSidedParallelReturn L wh wv (S + t • (wh, -wv)) c)
    (iteratedTransverseStaircase wh wv S) (c * m) b (c * n)

def oneSidedClosureLength (m L : ℕ) (wv wh : ℤ) (t c : ℕ) : ℕ :=
  c * m + t * (wh.natAbs + wv.natAbs) +
    c * (L * wh.natAbs + L * wv.natAbs) + t * (wh.natAbs + wv.natAbs)

/-- 一側閉包の全歩を辺番号と向きへ射影した列の循環回転和。 -/
def oneSidedClosureProjectedTurning (m L : ℕ) [NeZero L]
    (base : ℤ → ℤ × ℤ) (wv wh k₀ : ℤ) (t c : ℕ) : ℤ :=
  let W := oneSidedClosurePoint m L base wv wh k₀ t c
  cyclicAdjacentSum (fun e f => directionPairTurning (directionNumber e) (directionNumber f))
    (oneSidedClosureLength m L wv wh t c)
    (fun j => projectedUnitStep L (W j) (W (j + 1) - W j))

/-- 各部分の単位歩と三接合から、閉包の全歩の単位性を導く。 -/
theorem oneSidedClosurePoint_unit_steps
    (m L : ℕ) [NeZero m] (base : ℤ → ℤ × ℤ) (wv wh k₀ : ℤ) (t c : ℕ)
    (γ : ZMod m → OrientedEdge L)
    (hstep : ∀ j : ℕ, j < m →
      base ((j : ℤ) + 1) = base j + orientedEdgeLatticeStep (γ (j : ZMod m)))
    (hend : base m = base 0 + windingShift L wv wh)
    (hn : 0 < L * wh.natAbs + L * wv.natAbs)
    (hb : 0 < t * (wh.natAbs + wv.natAbs)) (hc : 0 < c) :
    ∀ j < oneSidedClosureLength m L wv wh t c,
      let u := oneSidedClosurePoint m L base wv wh k₀ t c (j + 1) -
        oneSidedClosurePoint m L base wv wh k₀ t c j
      u = (0, 1) ∨ u = (1, 0) ∨ u = (0, -1) ∨ u = (-1, 0) := by
  let p := fun i : ℕ => periodicPlaneLift m base L wv wh (k₀ + i)
  let S := p 0
  let b := t * (wh.natAbs + wv.natAbs)
  let n := L * wh.natAbs + L * wv.natAbs
  let q := iteratedTransverseStaircase wh wv (S + c • windingShift L wv wh)
  let r := oneSidedParallelReturn L wh wv (S + t • (wh, -wv)) c
  let s := iteratedTransverseStaircase wh wv S
  let unit := fun u : ℤ × ℤ =>
    u = (0, 1) ∨ u = (1, 0) ∨ u = (0, -1) ∨ u = (-1, 0)
  have hm : 0 < m := NeZero.pos m
  have hwind : (wh, wv) ≠ (0, 0) := by
    intro h
    have hh : wh = 0 := congrArg Prod.fst h
    have hv : wv = 0 := congrArg Prod.snd h
    simp [hh, hv] at hb
  have hu (i : ℕ) : unit (p (i + 1) - p i) := by
    have h := periodicPlaneLift_step_edgeDisplacement m L base wv wh γ hstep hend (k₀ + i)
    have he : k₀ + ((i + 1 : ℕ) : ℤ) = k₀ + i + 1 := by push_cast; ring
    change unit (periodicPlaneLift m base L wv wh (k₀ + (i + 1 : ℕ)) -
      periodicPlaneLift m base L wv wh (k₀ + i))
    rw [he, h]
    exact orientedEdgeLatticeStep_unit _
  have hv (i : ℕ) : unit (q (i + 1) - q i) := by
    have h := iteratedTransverseStaircase_unit_step wh wv
      (S + c • windingShift L wv wh) hwind i
    rcases h with h | h | h | h
    · exact Or.inr (Or.inl h)
    · exact Or.inr (Or.inr (Or.inr h))
    · exact Or.inl h
    · exact Or.inr (Or.inr (Or.inl h))
  have hr (i : ℕ) : unit (r (i + 1) - r i) := by
    rw [oneSidedParallelReturn_step L wh wv (S + t • (wh, -wv)) c hn i]
    exact (negatedParallelStaircaseStep_unit_negative L wh wv (i % n)
      (Nat.mod_lt i hn)).1
  have hx (i : ℕ) (hi : i < b) : unit (s (b - (i + 1)) - s (b - i)) := by
    have he : b - i = b - (i + 1) + 1 := by omega
    rw [he, ← neg_sub]
    have h := iteratedTransverseStaircase_unit_step wh wv S hwind (b - (i + 1))
    rcases h with h | h | h | h <;> change unit (- _) <;> rw [h] <;> norm_num [unit]
  obtain ⟨h12, h23, h34, _, _, _, _⟩ :=
    oneSidedClosure_concrete_parts m L base wv wh k₀ t c hm hn hb
  intro j hj
  change unit (oneSidedPeriodicLiftClosure p q r s (c * m) b (c * n) (j + 1) -
    oneSidedPeriodicLiftClosure p q r s (c * m) b (c * n) j)
  change j < c * m + b + c * n + b at hj
  rw [oneSidedClosure_stepSequence p q r s (c * m) b (c * n)
    (Nat.mul_pos hc hm) hb (Nat.mul_pos hc hn) h12 h23 h34 j (by omega)]
  by_cases hja : j < c * m
  · simpa only [joinDirectionSequence, if_pos (show j < c * m + b + c * n by omega),
      if_pos (show j < c * m + b by omega), if_pos hja] using hu j
  · by_cases hjab : j < c * m + b
    · simpa only [joinDirectionSequence, if_pos (show j < c * m + b + c * n by omega),
        if_pos hjab, if_neg hja] using hv (j - c * m)
    · by_cases hjabc : j < c * m + b + c * n
      · simpa only [joinDirectionSequence, if_pos hjabc, if_neg hjab] using
          hr (j - (c * m + b))
      · simpa only [joinDirectionSequence, if_neg hjabc] using
          hx (j - (c * m + b + c * n)) (by omega)

/-- 射影の回転和を、実際の格子歩の回転和へ同定する。 -/
theorem oneSidedClosureProjectedTurning_eq_lattice
    (m L : ℕ) [NeZero m] [NeZero L] (base : ℤ → ℤ × ℤ) (wv wh k₀ : ℤ) (t c : ℕ)
    (γ : ZMod m → OrientedEdge L)
    (hstep : ∀ j : ℕ, j < m →
      base ((j : ℤ) + 1) = base j + orientedEdgeLatticeStep (γ (j : ZMod m)))
    (hend : base m = base 0 + windingShift L wv wh)
    (hn : 0 < L * wh.natAbs + L * wv.natAbs)
    (hb : 0 < t * (wh.natAbs + wv.natAbs)) (hc : 0 < c) :
    oneSidedClosureProjectedTurning m L base wv wh k₀ t c =
      cyclicAdjacentSum latticeStepTurning (oneSidedClosureLength m L wv wh t c)
        (fun j => oneSidedClosurePoint m L base wv wh k₀ t c (j + 1) -
          oneSidedClosurePoint m L base wv wh k₀ t c j) := by
  apply planeProjection_cyclicTurning L _ (by unfold oneSidedClosureLength; omega)
  exact oneSidedClosurePoint_unit_steps m L base wv wh k₀ t c γ hstep hend hn hb hc

/-- 有限語の零延長は、その長さの循環隣接和を変えない。 -/
theorem cyclicTurning_extend_finite_word (m : ℕ) (hm : 0 < m) (u : ℕ → ℤ × ℤ) :
    cyclicAdjacentSum latticeStepTurning m (extendLatticeWord (fun i : Fin m => u i.val)) =
      cyclicAdjacentSum latticeStepTurning m u := by
  apply cyclicAdjacentSum_congr_range latticeStepTurning m hm
  intro j hj
  simp [extendLatticeWord, hj]

/-- 符号反転平行階段の射影は、既存の有効な一歩の回転表で零を与える。 -/
theorem negatedParallelStaircase_projectedTurning_zero
    (L : ℕ) [NeZero L] (wh wv : ℤ)
    (hn : 0 < L * wh.natAbs + L * wv.natAbs) :
    cyclicAdjacentSum (fun e f => directionPairTurning (directionNumber e) (directionNumber f))
      (L * wh.natAbs + L * wv.natAbs)
      (fun j => projectedUnitStep L (-windingParallelStaircase L wh wv j)
        (negatedParallelStaircaseStep L wh wv j)) = 0 := by
  let n := L * wh.natAbs + L * wv.natAbs
  let u := negatedParallelStaircaseStep L wh wv
  let E := fun j => projectedUnitStep L (-windingParallelStaircase L wh wv j) (u j)
  have hpair (i j : ℕ) (hi : i < n) (hj : j < n) :
      directionPairTurning (directionNumber (E i)) (directionNumber (E j)) =
        turnValue (latticeTurnOfSteps (u i) (u j)) := by
    calc
      _ = latticeStepTurning (u i) (u j) := projectedUnitStep_turning L _ _ _ _
        (negatedParallelStaircaseStep_unit_negative L wh wv i hi).1
        (negatedParallelStaircaseStep_unit_negative L wh wv j hj).1
      _ = _ := (negatedParallelStaircaseStep_turn_spec L wh wv i j hi hj).2.symm
  change cyclicAdjacentSum
    (fun e f => directionPairTurning (directionNumber e) (directionNumber f)) n E = 0
  calc
    _ = cyclicAdjacentSum (fun a b => turnValue (latticeTurnOfSteps a b)) n u := by
      apply cyclicAdjacentSum_transport_necSuf
      · intro j hj
        exact hpair j (j + 1) (by omega) (by omega)
      · exact hpair (n - 1) 0 (by omega) hn
    _ = 0 := negatedParallelStaircase_turning_zero L wh wv hn

/-- 本文の準備の二行。射影同定を逆に読み、射影階段の回転数零を代入する。 -/
theorem negatedParallelStaircase_turning_via_projection
    (L : ℕ) [NeZero L] (wh wv : ℤ)
    (hn : 0 < L * wh.natAbs + L * wv.natAbs) :
    cyclicAdjacentSum latticeStepTurning (L * wh.natAbs + L * wv.natAbs)
      (negatedParallelStaircaseStep L wh wv) = 0 := by
  calc
    _ = cyclicAdjacentSum
        (fun e f => directionPairTurning (directionNumber e) (directionNumber f))
        (L * wh.natAbs + L * wv.natAbs)
        (fun j => projectedUnitStep L (-windingParallelStaircase L wh wv j)
          (negatedParallelStaircaseStep L wh wv j)) := by
      symm
      apply planeProjection_cyclicTurning L _ hn (fun j => -windingParallelStaircase L wh wv j)
      intro j hj
      exact (negatedParallelStaircaseStep_unit_negative L wh wv j hj).1
    _ = 0 := negatedParallelStaircase_projectedTurning_zero L wh wv hn

/-- `claim_one_sided_closure_period_difference_turning`。周期数差の八行の合成。 -/
theorem oneSidedClosure_periodDifferenceTurning
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
  let T := oneSidedClosureProjectedTurning m L base wv wh k₀ t
  let C := fun k => cyclicAdjacentSum latticeStepTurning (N k) (fun j => W k (j + 1) - W k j)
  let z := fun k => joinDirectionSequence
    (joinDirectionSequence (joinDirectionSequence (repeatedLatticeWord u) (extendLatticeWord v)
      (k * m)) (repeatedLatticeWord r) (k * m + b)) (extendLatticeWord x) (k * m + b + k * n)
  have hm : 0 < m := NeZero.pos m
  have hprojection (k : ℕ) (hk : 0 < k) : T k = C k :=
    oneSidedClosureProjectedTurning_eq_lattice m L base wv wh k₀ t k γ hstep hend hn hb hk
  have hword (k : ℕ) (hk : 0 < k) : C k = cyclicAdjacentSum latticeStepTurning (N k) (z k) :=
    oneSidedClosure_cyclicTurning_identification m L base wv wh k₀ t k hm hn hb hk
  have hperiod : cyclicAdjacentSum latticeStepTurning m (extendLatticeWord u) =
      ∑ j : ZMod m, directionPairTurning (directionNumber (γ j)) (directionNumber (γ (j + 1))) := by
    calc
      _ = cyclicAdjacentSum latticeStepTurning m (fun j => p (j + 1) - p j) :=
        cyclicTurning_extend_finite_word m hm _
      _ = _ := by
        simpa [p, Nat.cast_add, add_assoc] using
          periodicPlaneLift_periodTurning m L base wv wh γ hstep hend k₀
  have hreturn : cyclicAdjacentSum latticeStepTurning n (extendLatticeWord r) = 0 := by
    calc
      _ = cyclicAdjacentSum latticeStepTurning n (negatedParallelStaircaseStep L wh wv) :=
        cyclicTurning_extend_finite_word n hn _
      _ = 0 := negatedParallelStaircase_turning_via_projection L wh wv hn
  change T (c + 1) - T c = _
  calc
    T (c + 1) - T c = C (c + 1) - T c := by rw [hprojection (c + 1) (by omega)]
    _ = C (c + 1) - C c := by rw [hprojection c hc]
    _ = cyclicAdjacentSum latticeStepTurning (N (c + 1)) (z (c + 1)) - C c := by
      rw [hword (c + 1) (by omega)]
    _ = cyclicAdjacentSum latticeStepTurning (N (c + 1)) (z (c + 1)) -
        cyclicAdjacentSum latticeStepTurning (N c) (z c) := by rw [hword c hc]
    _ = cyclicAdjacentSum latticeStepTurning m (extendLatticeWord u) +
        cyclicAdjacentSum latticeStepTurning n (extendLatticeWord r) :=
      fourPartRepeated_cyclicTurning_difference m b n b c u v r x hm hb hn hb hc
    _ = (∑ j : ZMod m, directionPairTurning (directionNumber (γ j)) (directionNumber (γ (j + 1)))) +
        cyclicAdjacentSum latticeStepTurning n (extendLatticeWord r) := by rw [hperiod]
    _ = (∑ j : ZMod m, directionPairTurning (directionNumber (γ j)) (directionNumber (γ (j + 1)))) + 0 := by
      rw [hreturn]
    _ = _ := add_zero _

end Ising2DLambda.KacWard
