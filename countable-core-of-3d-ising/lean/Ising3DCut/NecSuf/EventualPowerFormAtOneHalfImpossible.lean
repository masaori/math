/-
人手証明「有理点 2 分の 1 では点数乗表示は末尾で成り立たない」
（ラベル `claim_eventual_power_form_at_one_half_is_impossible`）の Lean 必要十分版。

具体版から有限箱、分配多項式、多重度、回文性、点数、素数 2、法 4 を落とすと、
残るのは次の三つだけである。

1. 指数が 2 以上なら、`p` の冪に何を掛けても `p ^ 2` で割れる（整除の推移）。
2. `p ^ 2` で割った余りが `p` である数は、`0 < p` なら `p ^ 2` で割れない。
3. 上の二つを、尺度倍した値が自然数であるという仮定へ当てて矛盾を出す組み立て。

**点数乗という形は使っていない。** 具体版が仮定していた「2 分の 1 での値が底の点数乗である」は、
この論法では「2 分の 1 での値が自然数である」ことにしか使われていない（底も指数も現れない）。
点数乗表示はその十分条件を与えているだけである。

**素数性も落とせる。** 使うのは `0 < p` だけである（`p ^ 2 ∣ v` から `v % p ^ 2 = 0` を出し、
余りが `p` であることと突き合わせる段で `p ≠ 0` しか要らない）。
一方 `0 < p` は落とせない（`p = 0` なら `p ^ 2 = 0` で余りは常に `p` に等しく、矛盾が出ない）。
指数の下限 2 も落とせない（`weight = 1` なら `p ^ 1 * m` の余りが `p` になりうる。
例: `p = 2`, `m = 1`, `value = 2` で `2 % 4 = 2`）。
-/
import Mathlib

namespace Ising3DCut.NecSuf

/-- 指数が 2 以上なら、`p` の冪に何を掛けた数も `p ^ 2` で割り切れる。 -/
theorem prime_sq_dvd_pow_mul {p n m : ℕ} (hn : 2 ≤ n) : p ^ 2 ∣ p ^ n * m :=
  Dvd.dvd.mul_right (pow_dvd_pow p hn) m

/-- `p ^ 2` で割った余りが `p` である数は、`0 < p` なら `p ^ 2` で割り切れない。 -/
theorem not_prime_sq_dvd_of_mod_eq {p v : ℕ} (hp : 0 < p) (hmod : v % p ^ 2 = p) :
    ¬ p ^ 2 ∣ v := by
  intro hdvd
  rw [Nat.dvd_iff_mod_eq_zero.mp hdvd] at hmod
  exact hp.ne hmod

/-- 尺度倍した値が自然数であることと、法 `p ^ 2` の剰余が `p` であることの不両立。 -/
theorem no_scaled_natural_value_of_prime_sq_residue {p : ℕ} (hp : 0 < p)
    (value weight scaled : ℕ → ℕ) (threshold : ℕ)
    (hscaled : ∀ L, threshold ≤ L → p ^ weight L * scaled L = value L)
    (hweight : ∀ L, 2 ≤ L → 2 ≤ weight L)
    (hresidue : ∀ L, 2 ≤ L → value L % p ^ 2 = p) : False := by
  have hthreshold : threshold ≤ max threshold 2 := le_max_left _ _
  have htwo : 2 ≤ max threshold 2 := le_max_right _ _
  have hdvd : p ^ 2 ∣ value (max threshold 2) := by
    rw [← hscaled _ hthreshold]
    exact prime_sq_dvd_pow_mul (hweight _ htwo)
  exact not_prime_sq_dvd_of_mod_eq hp (hresidue _ htwo) hdvd

end Ising3DCut.NecSuf
