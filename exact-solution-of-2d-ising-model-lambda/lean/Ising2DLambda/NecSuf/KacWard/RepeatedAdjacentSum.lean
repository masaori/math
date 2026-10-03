/-
反復有限列の内部隣接和の増分の必要十分版。
列の値と二項の重みには構造を要求しない。増分を加法で書く部分は可換加法モノイド、
差を取る結論だけは可換加法群を使う。正の列長と正の反復回数は接合の末項を定めるために要る。
-/
import Ising2DLambda.NecSuf.KacWard.FourPartAdjacentSum

namespace Ising2DLambda.NecSuf.KacWard

/-- n > 0 のとき、u の先頭 n 項だけを余りの添字で反復する。 -/
def repeatDirectionSequence {α : Type*} (u : ℕ → α) (n j : ℕ) : α :=
  u (j % n)

theorem repeatDirectionSequence_period {α : Type*} (u : ℕ → α) (n c j : ℕ) :
    repeatDirectionSequence u n (c * n + j) = repeatDirectionSequence u n j := by
  simp [repeatDirectionSequence, Nat.add_mod]

theorem repeatDirectionSequence_last {α : Type*} (u : ℕ → α) (n c : ℕ)
    (hn : 0 < n) (hc : 0 < c) :
    repeatDirectionSequence u n (c * n - 1) = u (n - 1) := by
  have hc' : c - 1 + 1 = c := by omega
  have hlength : c * n = (c - 1) * n + n := by
    calc
      c * n = (c - 1 + 1) * n := congrArg (· * n) hc'.symm
      _ = (c - 1) * n + n := by rw [Nat.add_mul, one_mul]
  have hindex : c * n - 1 = (c - 1) * n + (n - 1) := by omega
  rw [hindex, repeatDirectionSequence_period]
  simp [repeatDirectionSequence, Nat.mod_eq_of_lt (show n - 1 < n by omega)]

theorem repeatDirectionSequence_join {α : Type*} (u : ℕ → α) (n c : ℕ) :
    repeatDirectionSequence u n =
      joinDirectionSequence (repeatDirectionSequence u n) (repeatDirectionSequence u n)
        (c * n) := by
  funext j
  by_cases hj : j < c * n
  · simp [joinDirectionSequence, hj]
  · have hindex : j = c * n + (j - c * n) := by omega
    simpa only [joinDirectionSequence, if_neg hj] using
      (show repeatDirectionSequence u n j = repeatDirectionSequence u n (j - c * n) by
        conv_lhs => rw [hindex]
        exact repeatDirectionSequence_period u n c (j - c * n))

theorem internalAdjacentSum_repeat_base_necSuf {α M : Type*} [AddCommMonoid M]
    (weight : α → α → M) (u : ℕ → α) (n : ℕ) :
    internalAdjacentSum weight n (repeatDirectionSequence u n) =
      internalAdjacentSum weight n u := by
  apply Finset.sum_congr rfl
  intro j hj
  have hj' := Finset.mem_range.mp hj
  simp only [repeatDirectionSequence, Nat.mod_eq_of_lt (show j < n by omega),
    Nat.mod_eq_of_lt (show j + 1 < n by omega)]

/-- 本文の連結への書換え・二列分割・端点と一周期の代入を順に行う。 -/
theorem internalAdjacentSum_repeat_succ_necSuf {α M : Type*} [AddCommMonoid M]
    (weight : α → α → M) (u : ℕ → α) (n c : ℕ)
    (hn : 0 < n) (hc : 0 < c) :
    internalAdjacentSum weight ((c + 1) * n) (repeatDirectionSequence u n) =
      internalAdjacentSum weight (c * n) (repeatDirectionSequence u n) +
        weight (u (n - 1)) (u 0) + internalAdjacentSum weight n u := by
  let r := repeatDirectionSequence u n
  have hfirst : r 0 = u 0 := by simp [r, repeatDirectionSequence]
  have hlast : r (c * n - 1) = u (n - 1) :=
    repeatDirectionSequence_last u n c hn hc
  have hbase : internalAdjacentSum weight n r = internalAdjacentSum weight n u :=
    internalAdjacentSum_repeat_base_necSuf weight u n
  have hjoin : r = joinDirectionSequence r r (c * n) :=
    repeatDirectionSequence_join u n c
  calc
    internalAdjacentSum weight ((c + 1) * n) r =
        internalAdjacentSum weight (c * n + n) r := by rw [Nat.add_mul, one_mul]
    _ = internalAdjacentSum weight (c * n + n)
        (joinDirectionSequence r r (c * n)) := congrArg _ hjoin
    _ = internalAdjacentSum weight (c * n) r + weight (r (c * n - 1)) (r 0) +
        internalAdjacentSum weight n r :=
      internalAdjacentSum_join_necSuf weight r r (c * n) n (Nat.mul_pos hc hn) hn
    _ = internalAdjacentSum weight (c * n) r + weight (u (n - 1)) (r 0) +
        internalAdjacentSum weight n r := by rw [hlast]
    _ = internalAdjacentSum weight (c * n) r + weight (u (n - 1)) (u 0) +
        internalAdjacentSum weight n r := by rw [hfirst]
    _ = internalAdjacentSum weight (c * n) r + weight (u (n - 1)) (u 0) +
        internalAdjacentSum weight n u := by rw [hbase]

/-- 差の結論にだけ加法逆元が必要である。 -/
theorem internalAdjacentSum_repeat_difference_necSuf {α M : Type*} [AddCommGroup M]
    (weight : α → α → M) (u : ℕ → α) (n c : ℕ)
    (hn : 0 < n) (hc : 0 < c) :
    internalAdjacentSum weight ((c + 1) * n) (repeatDirectionSequence u n) -
        internalAdjacentSum weight (c * n) (repeatDirectionSequence u n) =
      internalAdjacentSum weight n u + weight (u (n - 1)) (u 0) := by
  rw [internalAdjacentSum_repeat_succ_necSuf weight u n c hn hc]
  calc
    _ = weight (u (n - 1)) (u 0) + internalAdjacentSum weight n u := by abel
    _ = internalAdjacentSum weight n u + weight (u (n - 1)) (u 0) := add_comm _ _

end Ising2DLambda.NecSuf.KacWard
