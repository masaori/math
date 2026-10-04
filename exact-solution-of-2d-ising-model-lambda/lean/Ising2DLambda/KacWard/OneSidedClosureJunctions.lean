/- 一側閉包の四接合の歩ベクトル対。
点列の各部分を既存の反復同定・基点不変性で固定列へ移し、
反復二列の先頭と末尾を計算する。平行移動した辺そのものは同一視しない。 -/
import Ising2DLambda.KacWard.PeriodicLiftStepRepetition
import Ising2DLambda.KacWard.OneSidedParallelReturn
import Ising2DLambda.KacWard.OneSidedTransverseSteps
import Ising2DLambda.NecSuf.KacWard.OneSidedClosureJunctions

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 一側閉包の各部分を局所添字で読んだ四つの接合対。 -/
def oneSidedClosureJunctionPairs (m L : ℕ) (base : ℤ → ℤ × ℤ)
    (wh wv k₀ : ℤ) (t c : ℕ) : List ((ℤ × ℤ) × (ℤ × ℤ)) :=
  let p := fun i : ℕ => periodicPlaneLift m base L wv wh (k₀ + i)
  let S := p 0
  let b := t * (wh.natAbs + wv.natAbs)
  let n := L * wh.natAbs + L * wv.natAbs
  let q := iteratedTransverseStaircase wh wv (S + c • windingShift L wv wh)
  let r := oneSidedParallelReturn L wh wv (S + t • (wh, -wv)) c
  let s := iteratedTransverseStaircase wh wv S
  fourJunctionPairs (c * m) b (c * n) b
    (fun i => p (i + 1) - p i) (fun i => q (i + 1) - q i)
    (fun i => r (i + 1) - r i) (fun i => s (b - (i + 1)) - s (b - i))

/-- 本文の準備: 四部分の既知の歩ベクトル表示を接合端点に代入する。 -/
theorem oneSidedClosureJunctionPairs_normalize
    (m L : ℕ) (base : ℤ → ℤ × ℤ) (wh wv k₀ : ℤ) (t c : ℕ)
    (hm : 0 < m) (hn : 0 < L * wh.natAbs + L * wv.natAbs)
    (hb : 0 < t * (wh.natAbs + wv.natAbs)) :
    let b := t * (wh.natAbs + wv.natAbs)
    let n := L * wh.natAbs + L * wv.natAbs
    let p := fun i : ℕ => periodicPlaneLift m base L wv wh (k₀ + i)
    let D := iteratedTransverseStaircase wh wv 0
    oneSidedClosureJunctionPairs m L base wh wv k₀ t c =
      fourJunctionPairs (c * m) b (c * n) b
        (repeatDirectionSequence (fun i => p (i + 1) - p i) m)
        (fun i => D (i + 1) - D i)
        (repeatDirectionSequence (negatedParallelStaircaseStep L wh wv) n)
        (fun i => D (b - (i + 1)) - D (b - i)) := by
  dsimp only
  let p := fun i : ℕ => periodicPlaneLift m base L wv wh (k₀ + i)
  let S := p 0
  let b := t * (wh.natAbs + wv.natAbs)
  have hp (i : ℕ) : p (i + 1) - p i =
      repeatDirectionSequence (fun j => p (j + 1) - p j) m i := by
    simpa [p, repeatDirectionSequence, Nat.cast_add, add_assoc] using
      periodicPlaneLift_step_remainder m L hm base wv wh k₀ (i : ℤ)
  have hq (i : ℕ) (hi : i < b) :=
    oneSidedTransverseSteps_base_independent wh wv
      (S + c • windingShift L wv wh) t false i hi
  have hs (i : ℕ) (hi : i < b) :=
    oneSidedTransverseSteps_base_independent wh wv S t true i hi
  dsimp only at hq hs
  simp only [Bool.false_eq_true, if_false, if_true] at hq hs
  have hr (i : ℕ) := oneSidedParallelReturn_step L wh wv
    (S + t • (wh, -wv)) c hn i
  change fourJunctionPairs (c * m) b (c * (L * wh.natAbs + L * wv.natAbs)) b
    (fun i => p (i + 1) - p i)
    (fun i => iteratedTransverseStaircase wh wv (S + c • windingShift L wv wh) (i + 1) -
      iteratedTransverseStaircase wh wv (S + c • windingShift L wv wh) i)
    (fun i => oneSidedParallelReturn L wh wv (S + t • (wh, -wv)) c (i + 1) -
      oneSidedParallelReturn L wh wv (S + t • (wh, -wv)) c i)
    (fun i => iteratedTransverseStaircase wh wv S (b - (i + 1)) -
      iteratedTransverseStaircase wh wv S (b - i)) = _
  unfold fourJunctionPairs
  dsimp only
  rw [hp, hp, hq 0 hb, hq (b - 1) (by omega), hr, hr,
    hs 0 hb, hs (b - 1) (by omega)]
  rfl

/-- `claim_one_sided_closure_junction_pairs`。実際の四部分の接合対を周期数に依らない列へ同定する。 -/
theorem oneSidedClosureJunctionPairs_eq_fixed
    (m L : ℕ) (base : ℤ → ℤ × ℤ) (wh wv k₀ : ℤ) (t c : ℕ)
    (hm : 0 < m) (hn : 0 < L * wh.natAbs + L * wv.natAbs)
    (hb : 0 < t * (wh.natAbs + wv.natAbs)) (hc : 0 < c) :
    let b := t * (wh.natAbs + wv.natAbs)
    let n := L * wh.natAbs + L * wv.natAbs
    let p := fun i : ℕ => periodicPlaneLift m base L wv wh (k₀ + i)
    let D := iteratedTransverseStaircase wh wv 0
    oneSidedClosureJunctionPairs m L base wh wv k₀ t c =
      fourJunctionPairs m b n b (fun i => p (i + 1) - p i)
        (fun i => D (i + 1) - D i) (negatedParallelStaircaseStep L wh wv)
        (fun i => D (b - (i + 1)) - D (b - i)) := by
  dsimp only
  rw [oneSidedClosureJunctionPairs_normalize m L base wh wv k₀ t c hm hn hb]
  let p := fun i : ℕ => periodicPlaneLift m base L wv wh (k₀ + i)
  let u := fun i => p (i + 1) - p i
  let w := negatedParallelStaircaseStep L wh wv
  have hu0 : repeatDirectionSequence u m 0 = u 0 := by simp [repeatDirectionSequence]
  have hw0 : repeatDirectionSequence w (L * wh.natAbs + L * wv.natAbs) 0 = w 0 := by
    simp [repeatDirectionSequence]
  have hulast := repeatDirectionSequence_last u m c hm hc
  have hwlast := repeatDirectionSequence_last w (L * wh.natAbs + L * wv.natAbs) c hn hc
  unfold fourJunctionPairs
  dsimp only
  rw [hulast, hw0, hwlast, hu0]

end Ising2DLambda.KacWard
