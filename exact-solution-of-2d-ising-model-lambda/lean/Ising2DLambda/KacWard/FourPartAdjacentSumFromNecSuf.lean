/- 四部分の分割の必要十分版を、整数格子の歩と整数の回転表へ特殊化する。 -/
import Ising2DLambda.KacWard.FourPartAdjacentSum

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

theorem fourPart_latticeCyclicTurning_from_necSuf
    (a b c d : ℕ)
    (u : Fin a → ℤ × ℤ) (v : Fin b → ℤ × ℤ)
    (w : Fin c → ℤ × ℤ) (x : Fin d → ℤ × ℤ)
    (ha : 0 < a) (hb : 0 < b) (hc : 0 < c) (hd : 0 < d) :
    let uv := joinDirectionSequence (extendLatticeWord u) (extendLatticeWord v) a
    let uvw := joinDirectionSequence uv (extendLatticeWord w) (a + b)
    let z := joinDirectionSequence uvw (extendLatticeWord x) (a + b + c)
    internalAdjacentSum latticeStepTurning (a + b + c + d) z +
        latticeStepTurning (z (a + b + c + d - 1)) (z 0) =
      internalAdjacentSum latticeStepTurning a (extendLatticeWord u) +
        latticeStepTurning ((extendLatticeWord u) (a - 1)) ((extendLatticeWord v) 0) +
      internalAdjacentSum latticeStepTurning b (extendLatticeWord v) +
        latticeStepTurning ((extendLatticeWord v) (b - 1)) ((extendLatticeWord w) 0) +
      internalAdjacentSum latticeStepTurning c (extendLatticeWord w) +
        latticeStepTurning ((extendLatticeWord w) (c - 1)) ((extendLatticeWord x) 0) +
      internalAdjacentSum latticeStepTurning d (extendLatticeWord x) +
        latticeStepTurning ((extendLatticeWord x) (d - 1)) ((extendLatticeWord u) 0) := by
  exact fourPart_cyclicAdjacentSum_necSuf latticeStepTurning
    (extendLatticeWord u) (extendLatticeWord v) (extendLatticeWord w) (extendLatticeWord x)
    a b c d ha hb hc hd

end Ising2DLambda.KacWard
