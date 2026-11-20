/-
具体版が必要十分版の特殊化として得られることの導出。
半環を ℕ、k' を k - 1、d の前者 e を自然数の減法 d - 1 とする
（k ≥ 1 と d = 2^k·m ≥ 1 から (k-1)+1 = k、(d-1)+1 = d）。
-/
import Ising2DLambda.FisherZero.PairCountTwoAdicValuationDecrease
import Ising2DLambda.NecSuf.FisherZero.PairCountTwoAdicValuationDecrease

namespace Ising2DLambda.FisherZero

theorem pairCountTwoAdicValuationDecrease_from_necSuf (k m d N : ℕ) (hk : 1 ≤ k)
    (hm : ∃ j : ℕ, m = j + j + 1) (hd : d = 2 ^ k * m) (hN : N + N = d * (d - 1)) :
    N = 2 ^ (k - 1) * (m * (d - 1)) ∧ ∃ j' : ℕ, m * (d - 1) = j' + j' + 1 := by
  obtain ⟨j, hj⟩ := hm
  have hk' : k - 1 + 1 = k := Nat.sub_add_cancel hk
  have hm1 : 1 ≤ m := by rw [hj]; exact Nat.le_add_left 1 (j + j)
  have hd1 : 1 ≤ d := by
    rw [hd]
    calc 1 = 1 * 1 := (Nat.mul_one 1).symm
      _ ≤ 2 ^ k * m := Nat.mul_le_mul Nat.one_le_two_pow hm1
  exact Ising2DLambda.NecSuf.FisherZero.pair_count_two_adic_valuation_decrease_necSuf
    (k - 1) m d (d - 1) N j hj (by rw [hk']; exact hd) (Nat.sub_add_cancel hd1) hN

end Ising2DLambda.FisherZero
