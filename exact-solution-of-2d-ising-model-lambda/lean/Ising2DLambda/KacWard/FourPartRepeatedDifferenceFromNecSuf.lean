/- 四部分反復差の必要十分版を、整数ベクトル列と整数の回転表へ特殊化する。 -/
import Ising2DLambda.KacWard.FourPartRepeatedDifference
import Ising2DLambda.NecSuf.KacWard.FourPartRepeatedDifference

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

theorem fourPartRepeated_cyclicTurning_difference_from_necSuf
    (m b n d c : ℕ)
    (u : Fin m → ℤ × ℤ) (v : Fin b → ℤ × ℤ)
    (r : Fin n → ℤ × ℤ) (x : Fin d → ℤ × ℤ)
    (hm : 0 < m) (hb : 0 < b) (hn : 0 < n) (hd : 0 < d) (hc : 0 < c) :
    let U := repeatedLatticeWord u
    let R := repeatedLatticeWord r
    let z := fun k => joinDirectionSequence
      (joinDirectionSequence
        (joinDirectionSequence U (extendLatticeWord v) (k * m)) R (k * m + b))
      (extendLatticeWord x) (k * m + b + k * n)
    let N := fun k => k * m + b + k * n + d
    (internalAdjacentSum latticeStepTurning (N (c + 1)) (z (c + 1)) +
        latticeStepTurning (z (c + 1) (N (c + 1) - 1)) (z (c + 1) 0)) -
      (internalAdjacentSum latticeStepTurning (N c) (z c) +
        latticeStepTurning (z c (N c - 1)) (z c 0)) =
      (internalAdjacentSum latticeStepTurning m (extendLatticeWord u) +
        latticeStepTurning (extendLatticeWord u (m - 1)) (extendLatticeWord u 0)) +
      (internalAdjacentSum latticeStepTurning n (extendLatticeWord r) +
        latticeStepTurning (extendLatticeWord r (n - 1)) (extendLatticeWord r 0)) := by
  exact fourPartRepeated_cyclicAdjacentSum_difference_necSuf latticeStepTurning
    (extendLatticeWord u) (extendLatticeWord v) (extendLatticeWord r) (extendLatticeWord x)
    m b n d c hm hb hn hd hc

end Ising2DLambda.KacWard
