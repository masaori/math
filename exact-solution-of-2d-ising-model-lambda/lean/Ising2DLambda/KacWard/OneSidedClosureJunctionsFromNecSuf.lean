/- 具体的な四部分の同定を行い、整数格子の固定列へ必要十分版を特殊化する。 -/
import Ising2DLambda.KacWard.OneSidedClosureJunctions

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

theorem oneSidedClosureJunctionPairs_eq_fixed_from_necSuf
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
  exact fourJunctionPairs_repetition_necSuf _ _ _ _ m _ _ _ c hm hn hc

end Ising2DLambda.KacWard
