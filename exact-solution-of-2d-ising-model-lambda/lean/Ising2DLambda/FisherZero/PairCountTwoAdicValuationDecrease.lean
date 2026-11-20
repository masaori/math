/-
節「偶数の次数の対の個数」の具体版。
人手証明の正本は `claim_pair_count_two_adic_valuation_decrease` である。

  人手証明                                                    このファイル
  準備: k = (k-1)+1、a := 2^{k-1}·m ≥ 1・1 = 1、a = b + 1        本体の `ha1`・`hb`
  第一の式鎖（d = 2^k·m = 2·2^{k-1}·m = 2·a = (b+b+1)+1）        本体の `hdchain`
  d - 1 = b + b + 1（(d-1)+1 = d と加法の消去）                   本体の `he`
  第二の式鎖（m' = m·(d-1) = (j+j+1)(b+b+1) = j'+j'+1）           本体の `hodd`
  第三の式鎖（N+N = d·(d-1) = a·(d-1)+a·(d-1)）と倍の消去         本体の `hNN`・`hNa`
  第四の式鎖（N = a·(d-1) = 2^{k-1}·m·(d-1) = 2^{k-1}·m'）       本体の最後の calc

住処: N。ここに ℝ / ℂ は現れない。
-/
import Mathlib

namespace Ising2DLambda.FisherZero

/-- 自然数の倍の消去。`N + N = M + M` なら `N = M`（`N < M` なら `N + N < M + M`、逆も同じ）。 -/
theorem nat_eq_of_add_self_eq_add_self (N M : ℕ) (h : N + N = M + M) : N = M := by
  rcases lt_trichotomy N M with hlt | heq | hgt
  · exact absurd h (Nat.ne_of_lt (Nat.add_lt_add hlt hlt))
  · exact heq
  · exact absurd h (Nat.ne_of_gt (Nat.add_lt_add hgt hgt))

/-- `claim_pair_count_two_adic_valuation_decrease` の具体版。
`k ≥ 1`、`m = j + j + 1`、`d = 2^k·m`、`N + N = d·(d-1)` なら、
`N = 2^{k-1}·(m·(d-1))` かつ `m·(d-1)` は奇数。 -/
theorem pairCountTwoAdicValuationDecrease (k m d N : ℕ) (hk : 1 ≤ k)
    (hm : ∃ j : ℕ, m = j + j + 1) (hd : d = 2 ^ k * m) (hN : N + N = d * (d - 1)) :
    N = 2 ^ (k - 1) * (m * (d - 1)) ∧ ∃ j' : ℕ, m * (d - 1) = j' + j' + 1 := by
  obtain ⟨j, hj⟩ := hm
  -- 準備: a := 2^{k-1}·m は 1 以上なので、a = b + 1 となる b がある。
  have hk' : k = (k - 1) + 1 := (Nat.sub_add_cancel hk).symm
  have hm1 : 1 ≤ m := by rw [hj]; exact Nat.le_add_left 1 (j + j)
  have ha1 : 1 ≤ 2 ^ (k - 1) * m :=
    calc 1 = 1 * 1 := (Nat.mul_one 1).symm
      _ ≤ 2 ^ (k - 1) * m := Nat.mul_le_mul (Nat.one_le_two_pow) hm1
  obtain ⟨b, hb⟩ : ∃ b : ℕ, 2 ^ (k - 1) * m = b + 1 :=
    ⟨2 ^ (k - 1) * m - 1, (Nat.sub_add_cancel ha1).symm⟩
  -- 第一の式鎖。
  have hd2 : d = 2 * (2 ^ (k - 1) * m) :=
    calc d = 2 ^ k * m := hd
      _ = 2 ^ ((k - 1) + 1) * m := by rw [← hk']
      _ = 2 * (2 ^ (k - 1) * m) := by rw [Nat.pow_succ, Nat.mul_comm (2 ^ (k - 1)) 2, Nat.mul_assoc]
  have hdchain : d = (b + b + 1) + 1 :=
    calc d = 2 * (2 ^ (k - 1) * m) := hd2
      _ = 2 * (b + 1) := by rw [hb]
      _ = (b + b + 1) + 1 := by ring
  -- d - 1 = b + b + 1（(d-1)+1 = d と加法の消去）。
  have he : d - 1 = b + b + 1 := by
    have h1 : (d - 1) + 1 = (b + b + 1) + 1 := by
      rw [Nat.sub_add_cancel (by rw [hdchain]; exact Nat.le_add_left 1 _)]
      exact hdchain
    exact Nat.add_right_cancel h1
  -- 第二の式鎖: m' := m·(d-1) は奇数。
  have hodd : m * (d - 1) = (2 * j * b + j + b) + (2 * j * b + j + b) + 1 :=
    calc m * (d - 1) = (j + j + 1) * (b + b + 1) := by rw [hj, he]
      _ = (2 * j * b + j + b) + (2 * j * b + j + b) + 1 := by ring
  -- 第三の式鎖と倍の消去: N = a·(d-1)。
  have hNN : N + N = 2 ^ (k - 1) * m * (d - 1) + 2 ^ (k - 1) * m * (d - 1) :=
    calc N + N = d * (d - 1) := hN
      _ = 2 * (2 ^ (k - 1) * m) * (d - 1) := congrArg (· * (d - 1)) hd2
      _ = 2 ^ (k - 1) * m * (d - 1) + 2 ^ (k - 1) * m * (d - 1) := by ring
  have hNa : N = 2 ^ (k - 1) * m * (d - 1) :=
    nat_eq_of_add_self_eq_add_self N _ hNN
  refine ⟨?_, ⟨2 * j * b + j + b, hodd⟩⟩
  -- 第四の式鎖。
  calc N = 2 ^ (k - 1) * m * (d - 1) := hNa
    _ = 2 ^ (k - 1) * (m * (d - 1)) := Nat.mul_assoc _ _ _

end Ising2DLambda.FisherZero
