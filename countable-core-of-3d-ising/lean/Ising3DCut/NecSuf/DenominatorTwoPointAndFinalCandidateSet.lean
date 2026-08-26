/-
「分母 2 の有理点と整数の有理点を合わせた候補は三つに限られる」の
Lean 必要十分版。

具体版（`Ising3DCut.LimitQuantity.DenominatorTwoPointAndFinalCandidateSet`）から
分配多項式・素数 2・冪・自然数の減法を落とすと、残るのは次の四つだけである。

* 有限和の先頭の項を切り離し、残りの項が共通の因子を持つことだけを使う分離。
  冪 `a ^ m` も `2 ^ (E - m)` も、残りの項が `a` の倍数であるという性質しか使わない。
* 一つの等式の両辺へ同じ元を掛けて同じ元を引く書き換え。可換環の公理だけで通り、
  掛ける元が 2 であることも、掛かっている元が 2 の冪であることも使わない。
* 割る数が互いに素な数の冪を割るなら 1 であること。素数 2 であることは使わず、
  互いに素であることだけを使う。
* 正の約数が元の数以下であること。具体版の「1 か 2」はこれの `n = 2` での特殊化である。
-/
import Mathlib

namespace Ising3DCut.NecSuf

/-- 有限和の分離。先頭以外の各項が共通因子 `a` を持つことだけを仮定する。
可換半環で通るので、係数が自然数であることも、項が冪であることも本質的でない。 -/
theorem head_split_of_common_factor
    {R : Type*} [CommSemiring R] (u t : ℕ → R) (a : R) (n : ℕ)
    (hfactor : ∀ m, u (m + 1) = a * t m) :
    (∑ m ∈ Finset.range (n + 1), u m) = u 0 + a * ∑ m ∈ Finset.range n, t m := by
  rw [Finset.sum_range_succ']
  rw [Finset.mul_sum]
  rw [add_comm (∑ k ∈ Finset.range n, u (k + 1)) (u 0)]
  congr 1
  apply Finset.sum_congr rfl
  intro m _
  exact hfactor m

/-- 両辺へ同じ元 `c` を掛け、同じ元 `c * s` を引く書き換え。
具体版が使うのは可換環の公理だけであり、`c = 2` も `s` が 2 の冪であることも使わない。 -/
theorem scale_and_shift_of_linear_relation
    {R : Type*} [CommRing R] {s w omega a S c : R}
    (h : s * w = s * omega + a * S) :
    (c * s) * (w - 1) = (c * s) * (omega - 1) + c * (a * S) := by
  calc
    (c * s) * (w - 1) = c * (s * w - s) := by ring
    _ = c * (s * omega + a * S - s) := by rw [h]
    _ = (c * s) * (omega - 1) + c * (a * S) := by ring

/-- 互いに素な数の冪を割る数は 1 である。素数であることは使わない。 -/
theorem eq_one_of_dvd_coprime_pow
    {a b k : ℕ} (hcoprime : Nat.Coprime a b) (hdvd : a ∣ b ^ k) :
    a = 1 := by
  have hcoprimePower : Nat.Coprime a (b ^ k) := hcoprime.pow_right _
  exact Nat.eq_one_of_dvd_coprimes hcoprimePower dvd_rfl hdvd

/-- 正の数の約数はその数以下である。具体版の候補の枚挙はこれの特殊化で得る。 -/
theorem le_of_dvd_pos {q n : ℕ} (hn : 0 < n) (hdvd : q ∣ n) : q ≤ n :=
  Nat.le_of_dvd hn hdvd

end Ising3DCut.NecSuf
