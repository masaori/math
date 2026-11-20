/-
節「偶数の次数の対の個数」の必要十分版。
具体版 `Ising2DLambda.FisherZero.pairCountTwoAdicValuationDecrease` と同じ手順
（a := 2^{k'}·m ≥ 1 から a = b + 1 → d = (b+b+1)+1 → d の前者 e = b+b+1 →
m·e は奇数 → N + N = a·e + a·e → 倍の消去で N = a·e）を、手順が実際に使う仮定だけの上で行う。

要るのは次だけである。
- 可換半環 R（積の可換則・結合則・分配則）。減法は使わない。具体版の自然数の減法 d - 1 は、
  e + 1 = d を満たす元 e（d の前者）として受け取る。k - 1 も同じく k = k' + 1 の k' で受け取る。
- 全順序で、加法と正の元の積が順序を保つこと（`IsStrictOrderedRing`）。
  1 ≤ 2^{k'}・1 ≤ m から 1 ≤ 2^{k'}·m を出す段と、倍の消去（N < M なら N + N < M + M）で使う。
  全順序は倍の消去の三分法に要る。
- 加法が標準的に順序付けられていること（`CanonicallyOrderedAdd`: 全ての元が 0 以上で、
  x ≤ y なら y = x + c となる c がある）。0 ≤ j + j から 1 ≤ m を出す段と、
  1 ≤ a から a の前者 b を取り出す段で使う。主張そのものは整数でも成り立つが、整数では
  前者を a - 1 として加法の逆元で取ることになり、具体版と別の手順になる。具体版の手順
  （1 ≤ a から前者を取り出す）を保つために残す。

削れたもの: 自然数であること（帰納法・整除・素因数分解を使わない）、加法の逆元。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

/-- 倍の消去。`N + N = M + M` なら `N = M`（三分法と、加法が狭義の順序を保つこと）。 -/
theorem eq_of_add_self_eq_add_self_necSuf {R : Type*} [CommSemiring R] [LinearOrder R]
    [IsStrictOrderedRing R] (N M : R) (h : N + N = M + M) : N = M := by
  rcases lt_trichotomy N M with hlt | heq | hgt
  · exact absurd h (ne_of_lt (add_lt_add hlt hlt))
  · exact heq
  · exact absurd h (ne_of_gt (add_lt_add hgt hgt))

theorem pair_count_two_adic_valuation_decrease_necSuf {R : Type*} [CommSemiring R]
    [LinearOrder R] [IsStrictOrderedRing R] [CanonicallyOrderedAdd R]
    (k' : ℕ) (m d e N j : R) (hj : m = j + j + 1) (hd : d = 2 ^ (k' + 1) * m)
    (he : e + 1 = d) (hN : N + N = d * e) :
    N = 2 ^ k' * (m * e) ∧ ∃ j' : R, m * e = j' + j' + 1 := by
  -- 準備: a := 2^{k'}·m は 1 以上なので、a = b + 1 となる b がある。
  have hm1 : 1 ≤ m := by rw [hj]; exact le_add_self
  have ha1 : 1 ≤ 2 ^ k' * m :=
    one_le_mul_of_one_le_of_one_le (one_le_pow₀ one_le_two) hm1
  obtain ⟨b, hb⟩ : ∃ b : R, 2 ^ k' * m = b + 1 := by
    obtain ⟨c, hc⟩ := exists_add_of_le ha1
    exact ⟨c, by rw [hc, add_comm]⟩
  -- 第一の式鎖。
  have hd2 : d = 2 * (2 ^ k' * m) :=
    calc d = 2 ^ (k' + 1) * m := hd
      _ = 2 * (2 ^ k' * m) := by rw [pow_succ, mul_comm (2 ^ k') 2, mul_assoc]
  have hdchain : d = (b + b + 1) + 1 :=
    calc d = 2 * (2 ^ k' * m) := hd2
      _ = 2 * (b + 1) := by rw [hb]
      _ = (b + b + 1) + 1 := by ring
  -- d の前者 e = b + b + 1（e + 1 = d と加法の消去）。
  have he' : e = b + b + 1 := add_right_cancel (he.trans hdchain)
  -- 第二の式鎖: m·e は奇数。
  have hodd : m * e = (2 * j * b + j + b) + (2 * j * b + j + b) + 1 :=
    calc m * e = (j + j + 1) * (b + b + 1) := by rw [hj, he']
      _ = (2 * j * b + j + b) + (2 * j * b + j + b) + 1 := by ring
  -- 第三の式鎖と倍の消去。
  have hNN : N + N = 2 ^ k' * m * e + 2 ^ k' * m * e :=
    calc N + N = d * e := hN
      _ = 2 * (2 ^ k' * m) * e := congrArg (· * e) hd2
      _ = 2 ^ k' * m * e + 2 ^ k' * m * e := by ring
  have hNa : N = 2 ^ k' * m * e := eq_of_add_self_eq_add_self_necSuf N _ hNN
  refine ⟨?_, ⟨2 * j * b + j + b, hodd⟩⟩
  -- 第四の式鎖。
  calc N = 2 ^ k' * m * e := hNa
    _ = 2 ^ k' * (m * e) := mul_assoc _ _ _

end Ising2DLambda.NecSuf.FisherZero
