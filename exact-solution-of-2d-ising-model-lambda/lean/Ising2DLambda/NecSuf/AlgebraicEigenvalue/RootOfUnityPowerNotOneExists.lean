/-
主張「指数が根の次数の倍数でないとき、冪が 1 でない 1 の冪根が存在する」の必要十分版。

具体版と同じ論法（除法の分解を受け取り、背理法で全元の冪を 1 と仮定し、鎖で w^r = 1 へ落とし、
個数の上界と個数の値から n ≤ r < n の矛盾を出す）を、仮定を必要十分まで薄めて通す。

- 値の型 `M` に要るのは、単位元・積・自然数冪の**記号**と、鎖が使う 4 法則
  （積の単位元・単位元の冪・冪の法則の指数の積と指数の和）だけである。
  結合則・可換則・体・代数閉性は不要である。
- 除法そのものは行わず、分解 `m = n * q + r` と `r < n` を仮定として受け取る。
  具体版が除法から出していた `1 ≤ r` は**この論法には不要**である
  （`1 ≤ r` は、具体版が個数の上界を指数 `r` の主張として供給するときにだけ要る。
  上界を 1 つの仮定 `hbound` として受け取れば消える）。
- 集合の有限性・個数も直接は使わず、「すべての元の `r` 乗が 1 ならば `n ≤ r`」という
  境界 `hbound` を 1 つの仮定として受け取る（具体版では有限性・部分集合の上界・個数の値の
  3 つの主張の組み立てがこれを供給する）。
- 矛盾は自然数の狭義大小の非反射性だけで出る。

住処: 一般の型。ここに ℝ / ℂ は現れない。
-/
import Mathlib.Order.Basic
import Mathlib.Tactic.Common

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 除法の分解 `m = n * q + r`（`r < n`）と、鎖が使う 4 法則、根の条件、および
「すべての元の `r` 乗が 1 ならば `n ≤ r`」という境界だけから、
`w ^ m ≠ 1` を満たす `w ∈ μn` の存在が従う。 -/
theorem power_not_one_exists_necSuf {M : Type*} [One M] [Mul M] [Pow M ℕ]
    {μn : Set M} {n m q r : ℕ}
    (hm : m = n * q + r) (hrlt : r < n)
    (hone_mul : ∀ x : M, 1 * x = x)
    (hone_pow : ∀ k : ℕ, (1 : M) ^ k = 1)
    (hpow_mul : ∀ (w : M) (a b : ℕ), w ^ (a * b) = (w ^ a) ^ b)
    (hpow_add : ∀ (w : M) (a b : ℕ), w ^ (a + b) = w ^ a * w ^ b)
    (hroot : ∀ w ∈ μn, w ^ n = 1)
    (hbound : (∀ w ∈ μn, w ^ r = 1) → n ≤ r) :
    ∃ w ∈ μn, w ^ m ≠ 1 := by
  classical
  -- 背理法。結論を否定すると、すべての w ∈ μn が w ^ m = 1 を満たす。
  by_contra hexists
  push_neg at hexists
  -- 鎖。すべての w ∈ μn について w ^ r = 1。
  have hpow_r : ∀ w ∈ μn, w ^ r = 1 := by
    intro w hw
    calc w ^ r
        = 1 * w ^ r := (hone_mul (w ^ r)).symm
          -- 第 1 段。積の単位元。
      _ = (1 : M) ^ q * w ^ r := by rw [hone_pow q]
          -- 第 2 段。単位元の冪。
      _ = (w ^ n) ^ q * w ^ r := by rw [hroot w hw]
          -- 第 3 段。根の条件。
      _ = w ^ (n * q) * w ^ r := by rw [hpow_mul w n q]
          -- 第 4 段。冪の法則（指数の積）。
      _ = w ^ (n * q + r) := (hpow_add w (n * q) r).symm
          -- 第 5 段。冪の法則（指数の和）。
      _ = w ^ m := by rw [← hm]
          -- 第 6 段。除法の分解。
      _ = 1 := hexists w hw
          -- 第 7 段。背理法の仮定。
  -- 境界から n ≤ r。r < n と合わせて矛盾。
  have hnr : n ≤ r := hbound hpow_r
  omega

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
