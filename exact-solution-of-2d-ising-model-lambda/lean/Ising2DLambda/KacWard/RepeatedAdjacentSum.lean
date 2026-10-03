/-
「有限列を一回多く反復した内部隣接和の増分」の具体版。
入力は整数ベクトルの有限列。本文の余りによる反復、連結への書換え、
二列の内部和の分割、端点の代入、共通項の消去を同じ順で行う。
-/
import Ising2DLambda.KacWard.FourPartAdjacentSum
import Ising2DLambda.NecSuf.KacWard.RepeatedAdjacentSum

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

def repeatedLatticeWord {n : ℕ} (u : Fin n → ℤ × ℤ) : ℕ → ℤ × ℤ :=
  repeatDirectionSequence (extendLatticeWord u) n

theorem repeatedLatticeWord_period {n : ℕ} (u : Fin n → ℤ × ℤ) (c j : ℕ) :
    repeatedLatticeWord u (c * n + j) = repeatedLatticeWord u j := by
  simp [repeatedLatticeWord, repeatDirectionSequence, Nat.add_mod]

theorem repeatedLatticeWord_last {n : ℕ} (u : Fin n → ℤ × ℤ) (c : ℕ)
    (hn : 0 < n) (hc : 0 < c) :
    repeatedLatticeWord u (c * n - 1) = extendLatticeWord u (n - 1) := by
  have hc' : c - 1 + 1 = c := by omega
  have hlength : c * n = (c - 1) * n + n := by
    calc
      c * n = (c - 1 + 1) * n := congrArg (· * n) hc'.symm
      _ = (c - 1) * n + n := by rw [Nat.add_mul, one_mul]
  have hindex : c * n - 1 = (c - 1) * n + (n - 1) := by omega
  rw [hindex, repeatedLatticeWord_period]
  simp [repeatedLatticeWord, repeatDirectionSequence,
    Nat.mod_eq_of_lt (show n - 1 < n by omega)]

theorem repeatedLatticeWord_join {n : ℕ} (u : Fin n → ℤ × ℤ) (c : ℕ) :
    repeatedLatticeWord u =
      joinDirectionSequence (repeatedLatticeWord u) (repeatedLatticeWord u) (c * n) := by
  funext j
  by_cases hj : j < c * n
  · simp [joinDirectionSequence, hj]
  · have hindex : j = c * n + (j - c * n) := by omega
    simpa only [joinDirectionSequence, if_neg hj] using
      (show repeatedLatticeWord u j = repeatedLatticeWord u (j - c * n) by
        conv_lhs => rw [hindex]
        exact repeatedLatticeWord_period u c (j - c * n))

theorem latticeInternalTurning_repeat_base {n : ℕ} (u : Fin n → ℤ × ℤ) :
    internalAdjacentSum latticeStepTurning n (repeatedLatticeWord u) =
      internalAdjacentSum latticeStepTurning n (extendLatticeWord u) := by
  apply Finset.sum_congr rfl
  intro j hj
  have hj' := Finset.mem_range.mp hj
  simp only [repeatedLatticeWord, repeatDirectionSequence,
    Nat.mod_eq_of_lt (show j < n by omega), Nat.mod_eq_of_lt (show j + 1 < n by omega)]

/-- 二列の分割による一周期の追加。整数の回転表を展開する必要はない。 -/
theorem latticeInternalTurning_repeat_succ {n : ℕ} (u : Fin n → ℤ × ℤ) (c : ℕ)
    (hn : 0 < n) (hc : 0 < c) :
    internalAdjacentSum latticeStepTurning ((c + 1) * n) (repeatedLatticeWord u) =
      internalAdjacentSum latticeStepTurning (c * n) (repeatedLatticeWord u) +
        latticeStepTurning (extendLatticeWord u (n - 1)) (extendLatticeWord u 0) +
          internalAdjacentSum latticeStepTurning n (extendLatticeWord u) := by
  let r := repeatedLatticeWord u
  have hfirst : r 0 = extendLatticeWord u 0 := by
    simp [r, repeatedLatticeWord, repeatDirectionSequence]
  have hlast : r (c * n - 1) = extendLatticeWord u (n - 1) :=
    repeatedLatticeWord_last u c hn hc
  have hbase : internalAdjacentSum latticeStepTurning n r =
      internalAdjacentSum latticeStepTurning n (extendLatticeWord u) :=
    latticeInternalTurning_repeat_base u
  have hjoin : r = joinDirectionSequence r r (c * n) := repeatedLatticeWord_join u c
  calc
    internalAdjacentSum latticeStepTurning ((c + 1) * n) r =
        internalAdjacentSum latticeStepTurning (c * n + n) r := by rw [Nat.add_mul, one_mul]
    _ = internalAdjacentSum latticeStepTurning (c * n + n)
        (joinDirectionSequence r r (c * n)) := congrArg _ hjoin
    _ = internalAdjacentSum latticeStepTurning (c * n) r +
        latticeStepTurning (r (c * n - 1)) (r 0) + internalAdjacentSum latticeStepTurning n r :=
      latticeInternalTurning_join r r (c * n) n (Nat.mul_pos hc hn) hn
    _ = internalAdjacentSum latticeStepTurning (c * n) r +
        latticeStepTurning (extendLatticeWord u (n - 1)) (r 0) +
          internalAdjacentSum latticeStepTurning n r := by rw [hlast]
    _ = internalAdjacentSum latticeStepTurning (c * n) r +
        latticeStepTurning (extendLatticeWord u (n - 1)) (extendLatticeWord u 0) +
          internalAdjacentSum latticeStepTurning n r := by rw [hfirst]
    _ = internalAdjacentSum latticeStepTurning (c * n) r +
        latticeStepTurning (extendLatticeWord u (n - 1)) (extendLatticeWord u 0) +
          internalAdjacentSum latticeStepTurning n (extendLatticeWord u) := by rw [hbase]

theorem latticeInternalTurning_repeat_difference {n : ℕ} (u : Fin n → ℤ × ℤ) (c : ℕ)
    (hn : 0 < n) (hc : 0 < c) :
    internalAdjacentSum latticeStepTurning ((c + 1) * n) (repeatedLatticeWord u) -
        internalAdjacentSum latticeStepTurning (c * n) (repeatedLatticeWord u) =
      internalAdjacentSum latticeStepTurning n (extendLatticeWord u) +
        latticeStepTurning (extendLatticeWord u (n - 1)) (extendLatticeWord u 0) := by
  rw [latticeInternalTurning_repeat_succ u c hn hc]
  calc
    _ = latticeStepTurning (extendLatticeWord u (n - 1)) (extendLatticeWord u 0) +
        internalAdjacentSum latticeStepTurning n (extendLatticeWord u) := by omega
    _ = internalAdjacentSum latticeStepTurning n (extendLatticeWord u) +
        latticeStepTurning (extendLatticeWord u (n - 1)) (extendLatticeWord u 0) := add_comm _ _

end Ising2DLambda.KacWard
