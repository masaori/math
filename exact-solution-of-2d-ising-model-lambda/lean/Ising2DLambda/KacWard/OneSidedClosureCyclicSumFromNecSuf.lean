/- 一側閉包の循環隣接和の同定を必要十分版から具体化する。 -/
import Ising2DLambda.KacWard.OneSidedClosureCyclicSum

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

theorem oneSidedClosure_cyclicTurning_identification_from_necSuf
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
  obtain ⟨h12, h23, h34, hu, hv, hr, hx⟩ :=
    oneSidedClosure_concrete_parts m L base wv wh k₀ t c hm hn hb
  -- 点の型を整数格子、歩の写像を差、重みを整数の回転表へ特殊化する。
  exact oneSidedClosure_cyclicAdjacentSum_necSuf
    (fun x y : ℤ × ℤ => y - x) latticeStepTurning _ _ _ _ _ _ _ _
    (c * m) (t * (wh.natAbs + wv.natAbs)) (c * (L * wh.natAbs + L * wv.natAbs))
    hb (Nat.mul_pos hc hn) h12 h23 h34 hu hv hr hx

end Ising2DLambda.KacWard
