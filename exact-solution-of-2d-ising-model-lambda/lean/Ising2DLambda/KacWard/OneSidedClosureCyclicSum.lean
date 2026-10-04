/-
一側閉包の循環隣接和を、固定した四つの有限語からなる反復列へ同定する。
三接合は具体的な点列の端点から導出し、四区間の歩、内部和、閉じ目の順に置換する。
-/
import Ising2DLambda.KacWard.OneSidedClosureStepSequence
import Ising2DLambda.KacWard.PeriodicLiftStepRepetition
import Ising2DLambda.KacWard.OneSidedParallelReturn
import Ising2DLambda.KacWard.OneSidedTransverseSteps
import Ising2DLambda.KacWard.FourPartRepeatedDifference
import Ising2DLambda.NecSuf.KacWard.OneSidedClosureCyclicSum

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

private theorem transverse_zero (wh wv : ℤ) (S : ℤ × ℤ) :
    iteratedTransverseStaircase wh wv S 0 = S := by
  simp [iteratedTransverseStaircase, iteratedStaircase,
    windingTransverseStaircase, twoPhaseStaircase]

private theorem transverse_multiple (wh wv : ℤ) (S : ℤ × ℤ) (t : ℕ)
    (h : 0 < wh.natAbs + wv.natAbs) :
    iteratedTransverseStaircase wh wv S (t * (wh.natAbs + wv.natAbs)) =
      S + t • (wh, -wv) := by
  simp [iteratedTransverseStaircase, iteratedStaircase, Nat.mul_div_cancel _ h,
    windingTransverseStaircase, twoPhaseStaircase]

/-- 本文の準備。具体的な点列の三接合と、固定有限語への四つの歩の同定。 -/
theorem oneSidedClosure_concrete_parts
    (m L : ℕ) (base : ℤ → ℤ × ℤ) (wv wh k₀ : ℤ) (t c : ℕ)
    (hm : 0 < m) (hn : 0 < L * wh.natAbs + L * wv.natAbs)
    (hb : 0 < t * (wh.natAbs + wv.natAbs)) :
    let p := fun i : ℕ => periodicPlaneLift m base L wv wh (k₀ + i)
    let S := p 0
    let b := t * (wh.natAbs + wv.natAbs)
    let n := L * wh.natAbs + L * wv.natAbs
    let q := iteratedTransverseStaircase wh wv (S + c • windingShift L wv wh)
    let r := oneSidedParallelReturn L wh wv (S + t • (wh, -wv)) c
    let s := iteratedTransverseStaircase wh wv S
    let D := iteratedTransverseStaircase wh wv 0
    let u : Fin m → ℤ × ℤ := fun i => p (i.val + 1) - p i.val
    let v : Fin b → ℤ × ℤ := fun i => D (i.val + 1) - D i.val
    let e : Fin n → ℤ × ℤ := fun i => negatedParallelStaircaseStep L wh wv i.val
    let x : Fin b → ℤ × ℤ := fun i => D (b - (i.val + 1)) - D (b - i.val)
    p (c * m) = q 0 ∧ q b = r 0 ∧ r (c * n) = s b ∧
      (∀ i < c * m, p (i + 1) - p i = repeatedLatticeWord u i) ∧
      (∀ i < b, q (i + 1) - q i = extendLatticeWord v i) ∧
      (∀ i < c * n, r (i + 1) - r i = repeatedLatticeWord e i) ∧
      (∀ i < b, s (b - (i + 1)) - s (b - i) = extendLatticeWord x i) := by
  dsimp only
  let p := fun i : ℕ => periodicPlaneLift m base L wv wh (k₀ + i)
  let S := p 0
  let b := t * (wh.natAbs + wv.natAbs)
  let n := L * wh.natAbs + L * wv.natAbs
  have htrans : 0 < wh.natAbs + wv.natAbs := by
    by_contra hz
    have hz' : wh.natAbs + wv.natAbs = 0 := by omega
    simp [hz'] at hb
  have h12 : p (c * m) =
      iteratedTransverseStaircase wh wv (S + c • windingShift L wv wh) 0 := by
    rw [transverse_zero]
    simpa [p, S, Nat.cast_mul] using
      periodicPlaneLift_translate m L hm base wv wh k₀ (c : ℤ)
  have h23 : iteratedTransverseStaircase wh wv (S + c • windingShift L wv wh) b =
      oneSidedParallelReturn L wh wv (S + t • (wh, -wv)) c 0 := by
    rw [transverse_multiple wh wv _ t htrans]
    simp only [oneSidedParallelReturn, Nat.zero_div, Nat.cast_zero, sub_zero,
      Nat.zero_mod, windingParallelStaircase_zero, sub_zero, windingShift]
    simp only [natCast_zsmul]
    abel
  have h34 : oneSidedParallelReturn L wh wv (S + t • (wh, -wv)) c (c * n) =
      iteratedTransverseStaircase wh wv S b := by
    rw [transverse_multiple wh wv S t htrans]
    simp [oneSidedParallelReturn, n, Nat.mul_div_cancel _ hn,
      windingParallelStaircase_zero]
  refine ⟨h12, h23, h34, ?_, ?_, ?_, ?_⟩
  · intro i _
    have hrem := periodicPlaneLift_step_remainder m L hm base wv wh k₀ (i : ℤ)
    have hir : i % m < m := Nat.mod_lt i hm
    simpa [repeatedLatticeWord, repeatDirectionSequence, extendLatticeWord, hir,
      Nat.cast_add, Int.natCast_mod, add_assoc] using hrem
  · intro i hi
    have h := oneSidedTransverseSteps_base_independent wh wv
      (S + c • windingShift L wv wh) t false i hi
    simpa [extendLatticeWord, hi, S, p] using h
  · intro i _
    have hir : i % n < n := Nat.mod_lt i hn
    simpa [repeatedLatticeWord, repeatDirectionSequence, extendLatticeWord, n, hir, S, p] using
      oneSidedParallelReturn_step L wh wv (S + t • (wh, -wv)) c hn i
  · intro i hi
    have h := oneSidedTransverseSteps_base_independent wh wv S t true i hi
    simpa [extendLatticeWord, hi, S, p] using h

/-- `claim_one_sided_closure_cyclic_sum`。閉包の実際の歩を固定四部分列へ移す。 -/
theorem oneSidedClosure_cyclicTurning_identification
    (m L : ℕ) (base : ℤ → ℤ × ℤ) (wv wh k₀ : ℤ) (t c : ℕ)
    (hm : 0 < m) (hn : 0 < L * wh.natAbs + L * wv.natAbs)
    (hb : 0 < t * (wh.natAbs + wv.natAbs)) (hc : 0 < c) :
    let p := fun i : ℕ => periodicPlaneLift m base L wv wh (k₀ + i)
    let S := p 0
    let b := t * (wh.natAbs + wv.natAbs)
    let n := L * wh.natAbs + L * wv.natAbs
    let q := iteratedTransverseStaircase wh wv (S + c • windingShift L wv wh)
    let r := oneSidedParallelReturn L wh wv (S + t • (wh, -wv)) c
    let s := iteratedTransverseStaircase wh wv S
    let D := iteratedTransverseStaircase wh wv 0
    let u : Fin m → ℤ × ℤ := fun i => p (i.val + 1) - p i.val
    let v : Fin b → ℤ × ℤ := fun i => D (i.val + 1) - D i.val
    let e : Fin n → ℤ × ℤ := fun i => negatedParallelStaircaseStep L wh wv i.val
    let x : Fin b → ℤ × ℤ := fun i => D (b - (i.val + 1)) - D (b - i.val)
    let W := oneSidedPeriodicLiftClosure p q r s (c * m) b (c * n)
    let z := joinDirectionSequence
      (joinDirectionSequence
        (joinDirectionSequence (repeatedLatticeWord u) (extendLatticeWord v) (c * m))
        (repeatedLatticeWord e) (c * m + b)) (extendLatticeWord x) (c * m + b + c * n)
    cyclicAdjacentSum latticeStepTurning (c * m + b + c * n + b)
        (fun j => W (j + 1) - W j) =
      cyclicAdjacentSum latticeStepTurning (c * m + b + c * n + b) z := by
  dsimp only
  let p := fun i : ℕ => periodicPlaneLift m base L wv wh (k₀ + i)
  let S := p 0
  let b := t * (wh.natAbs + wv.natAbs)
  let n := L * wh.natAbs + L * wv.natAbs
  let q := iteratedTransverseStaircase wh wv (S + c • windingShift L wv wh)
  let r := oneSidedParallelReturn L wh wv (S + t • (wh, -wv)) c
  let s := iteratedTransverseStaircase wh wv S
  let D := iteratedTransverseStaircase wh wv 0
  let u : Fin m → ℤ × ℤ := fun i => p (i.val + 1) - p i.val
  let v : Fin b → ℤ × ℤ := fun i => D (i.val + 1) - D i.val
  let e : Fin n → ℤ × ℤ := fun i => negatedParallelStaircaseStep L wh wv i.val
  let x : Fin b → ℤ × ℤ := fun i => D (b - (i.val + 1)) - D (b - i.val)
  let W := oneSidedPeriodicLiftClosure p q r s (c * m) b (c * n)
  let z := joinDirectionSequence
    (joinDirectionSequence
      (joinDirectionSequence (repeatedLatticeWord u) (extendLatticeWord v) (c * m))
      (repeatedLatticeWord e) (c * m + b)) (extendLatticeWord x) (c * m + b + c * n)
  change cyclicAdjacentSum latticeStepTurning (c * m + b + c * n + b)
      (fun j => W (j + 1) - W j) =
    cyclicAdjacentSum latticeStepTurning (c * m + b + c * n + b) z
  obtain ⟨h12, h23, h34, hu, hv, hr, hx⟩ :=
    oneSidedClosure_concrete_parts m L base wv wh k₀ t c hm hn hb
  -- 本文の四区間で、既存の閉包の歩の表示に固定列を代入する。
  have hstep (j : ℕ) (hj : j < c * m + b + c * n + b) :
      W (j + 1) - W j = z j := by
    calc
      W (j + 1) - W j = _ := oneSidedClosure_stepSequence p q r s
        (c * m) b (c * n) (Nat.mul_pos hc hm) hb (Nat.mul_pos hc hn)
        h12 h23 h34 j (by omega)
      _ = z j := fourPartSequence_congr_range _ _ _ _
        (repeatedLatticeWord u) (extendLatticeWord v) (repeatedLatticeWord e)
        (extendLatticeWord x) (c * m) b (c * n) b hu hv hr hx j hj
  -- 内部の隣接対は二つとも区間内にあり、閉じ目も最後と最初の歩だけを読む。
  unfold cyclicAdjacentSum
  apply congrArg₂ (· + ·)
  · apply Finset.sum_congr rfl
    intro j hj
    have hj' := Finset.mem_range.mp hj
    exact congrArg₂ latticeStepTurning (hstep j (by omega)) (hstep (j + 1) (by omega))
  · exact congrArg₂ latticeStepTurning
      (hstep (c * m + b + c * n + b - 1) (by omega)) (hstep 0 (by omega))

end Ising2DLambda.KacWard
