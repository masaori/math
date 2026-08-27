/-
人手証明「有理点 2 では有限箱の量は末尾周期的にならない」
（ラベル `claim_eventually_periodic_at_two_is_impossible`）の Lean 必要十分版。

具体版から有限箱、分配多項式、点数、素数 2、法 4、自然数を落とすと、残るのは次の二つだけである。

1. 冪の上で加法的な指標（`v (x ^ k) = k * v x`）が二つの値でともに 1 を取ること。
2. 二つの指数が相異なること。

素数 2 も法 4 も残らない。具体版がそこで使っていたのは「素数 2 の指数がちょうど 1」という
結論だけであり、その結論の出所（法 4 で 2 であること）は交差冪等式の否定には効いていない。
台も `ℕ` である必要はなく、`ℕ` 冪が定義されていれば足りる（モノイド則も使わない）。
指標の値 1 は落とせない。`v a = v b = 0` なら `a ^ i` と `b ^ j` の指標は指数によらず 0 に
なり、この論法では両辺を区別できない。
-/
import Mathlib

namespace Ising3DCut.NecSuf

/-- 冪の上で加法的な指標がともに 1 を取る二つの値は、相異なる指数の冪として一致しない。 -/
theorem pow_ne_pow_of_pow_additive_index_eq_one {M : Type*} [Pow M ℕ]
    (v : M → ℕ) (hpow : ∀ (x : M) (k : ℕ), v (x ^ k) = k * v x)
    {a b : M} (ha : v a = 1) (hb : v b = 1)
    {i j : ℕ} (hij : i ≠ j) : a ^ i ≠ b ^ j := by
  intro heq
  have hindex := congrArg v heq
  rw [hpow, hpow, ha, hb] at hindex
  exact hij (by simpa using hindex)

/-- 閾値以後の交差冪等式は、指標が 1 で指数が相異なる限り成り立たない。 -/
theorem no_eventual_cross_power_identity_of_pow_additive_index_eq_one
    {M : Type*} [Pow M ℕ]
    (v : M → ℕ) (hpow : ∀ (x : M) (k : ℕ), v (x ^ k) = k * v x)
    (value : ℕ → M) (size : ℕ → ℕ) (threshold period : ℕ)
    (hindex : ∀ L, 2 ≤ L → v (value L) = 1)
    (hsize : ∀ L, 2 ≤ L → size (L + period) ≠ size L)
    (hcross : ∀ L, threshold ≤ L →
      value L ^ size (L + period) = value (L + period) ^ size L) : False := by
  have hthreshold : threshold ≤ max threshold 2 := le_max_left _ _
  have htwo : 2 ≤ max threshold 2 := le_max_right _ _
  refine pow_ne_pow_of_pow_additive_index_eq_one v hpow
    (hindex _ htwo)
    (hindex _ (le_trans htwo (Nat.le_add_right _ _)))
    (hsize _ htwo) (hcross _ hthreshold)

end Ising3DCut.NecSuf
