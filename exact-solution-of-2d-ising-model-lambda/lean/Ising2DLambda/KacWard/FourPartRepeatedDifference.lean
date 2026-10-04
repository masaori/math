/-
四部分列の反復二列を一回延ばした循環隣接和の差の具体版。
整数ベクトルの有限列を零延長する。本文と同じく、四部分分解、接合の端点評価、
二つの表示の差、反復内部和の増分の順に計算する。
-/
import Ising2DLambda.KacWard.RepeatedAdjacentSum

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- claim_four_part_repeated_difference。反復二列の一周期ずつの循環和が増分になる。 -/
theorem fourPartRepeated_cyclicTurning_difference
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
  dsimp only
  let U := repeatedLatticeWord u
  let V := extendLatticeWord v
  let R := repeatedLatticeWord r
  let X := extendLatticeWord x
  let z := fun k => joinDirectionSequence
    (joinDirectionSequence (joinDirectionSequence U V (k * m)) R (k * m + b))
    X (k * m + b + k * n)
  let N := fun k => k * m + b + k * n + d
  change (internalAdjacentSum latticeStepTurning (N (c + 1)) (z (c + 1)) +
      latticeStepTurning (z (c + 1) (N (c + 1) - 1)) (z (c + 1) 0)) -
    (internalAdjacentSum latticeStepTurning (N c) (z c) +
      latticeStepTurning (z c (N c - 1)) (z c 0)) = _
  have hparts (k : ℕ) (hk : 0 < k) :
      internalAdjacentSum latticeStepTurning (N k) (z k) +
          latticeStepTurning (z k (N k - 1)) (z k 0) =
        internalAdjacentSum latticeStepTurning (k * m) U +
          latticeStepTurning (extendLatticeWord u (m - 1)) (V 0) +
        internalAdjacentSum latticeStepTurning b V +
          latticeStepTurning (V (b - 1)) (extendLatticeWord r 0) +
        internalAdjacentSum latticeStepTurning (k * n) R +
          latticeStepTurning (extendLatticeWord r (n - 1)) (X 0) +
        internalAdjacentSum latticeStepTurning d X +
          latticeStepTurning (X (d - 1)) (extendLatticeWord u 0) := by
    have hkm : 0 < k * m := Nat.mul_pos hk hm
    have hkn : 0 < k * n := Nat.mul_pos hk hn
    -- 二列分割を三回使い、四つの内部和と四つの接合に分ける。
    have huv : joinDirectionSequence U V (k * m) (k * m + b - 1) = V (b - 1) := by
      simp [joinDirectionSequence, show ¬k * m + b - 1 < k * m by omega,
        show k * m + b - 1 - k * m = b - 1 by omega]
    have huvr : joinDirectionSequence (joinDirectionSequence U V (k * m)) R
        (k * m + b) (k * m + b + k * n - 1) = R (k * n - 1) := by
      simp [joinDirectionSequence, show ¬k * m + b + k * n - 1 < k * m + b by omega,
        show k * m + b + k * n - 1 - (k * m + b) = k * n - 1 by omega]
    have hlast : z k (N k - 1) = X (d - 1) := by
      simp [z, N, joinDirectionSequence,
        show ¬k * m + b + k * n + d - 1 < k * m + b + k * n by omega,
        show k * m + b + k * n + d - 1 - (k * m + b + k * n) = d - 1 by omega]
    have hfirst : z k 0 = U 0 := by
      simp [z, joinDirectionSequence, hkm, show 0 < k * m + b by omega,
        show 0 < k * m + b + k * n by omega]
    have hu0 : U 0 = extendLatticeWord u 0 := by
      simp [U, repeatedLatticeWord, repeatDirectionSequence]
    have hr0 : R 0 = extendLatticeWord r 0 := by
      simp [R, repeatedLatticeWord, repeatDirectionSequence]
    have hulast : U (k * m - 1) = extendLatticeWord u (m - 1) :=
      repeatedLatticeWord_last u k hm hk
    have hrlast : R (k * n - 1) = extendLatticeWord r (n - 1) :=
      repeatedLatticeWord_last r k hn hk
    calc
      _ = internalAdjacentSum latticeStepTurning (k * m) U +
            latticeStepTurning (U (k * m - 1)) (V 0) +
          internalAdjacentSum latticeStepTurning b V +
            latticeStepTurning (V (b - 1)) (R 0) +
          internalAdjacentSum latticeStepTurning (k * n) R +
            latticeStepTurning (R (k * n - 1)) (X 0) +
          internalAdjacentSum latticeStepTurning d X +
            latticeStepTurning (X (d - 1)) (U 0) := by
        rw [hlast, hfirst]
        dsimp only [N, z]
        rw [latticeInternalTurning_join _ X _ d (by omega) hd]
        rw [latticeInternalTurning_join _ R _ (k * n) (by omega) hkn]
        rw [latticeInternalTurning_join U V (k * m) b hkm hb]
        rw [huv, huvr]
      _ = _ := by rw [hulast, hr0, hrlast, hu0]
  -- 共通の内部和二つと接合四つを差から消す。
  calc
    _ = (internalAdjacentSum latticeStepTurning ((c + 1) * m) U -
          internalAdjacentSum latticeStepTurning (c * m) U) +
        (internalAdjacentSum latticeStepTurning ((c + 1) * n) R -
          internalAdjacentSum latticeStepTurning (c * n) R) := by
      rw [hparts (c + 1) (by omega), hparts c hc]
      omega
    _ = (internalAdjacentSum latticeStepTurning m (extendLatticeWord u) +
          latticeStepTurning (extendLatticeWord u (m - 1)) (extendLatticeWord u 0)) +
        (internalAdjacentSum latticeStepTurning ((c + 1) * n) R -
          internalAdjacentSum latticeStepTurning (c * n) R) := by
      rw [latticeInternalTurning_repeat_difference u c hm hc]
    _ = (internalAdjacentSum latticeStepTurning m (extendLatticeWord u) +
          latticeStepTurning (extendLatticeWord u (m - 1)) (extendLatticeWord u 0)) +
        (internalAdjacentSum latticeStepTurning n (extendLatticeWord r) +
          latticeStepTurning (extendLatticeWord r (n - 1)) (extendLatticeWord r 0)) := by
      rw [latticeInternalTurning_repeat_difference r c hn hc]

end Ising2DLambda.KacWard
