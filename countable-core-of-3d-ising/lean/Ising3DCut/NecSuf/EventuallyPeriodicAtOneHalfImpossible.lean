/-
人手証明「有理点 2 分の 1 では有限箱の量は末尾周期的にならない」
（ラベル `claim_eventually_periodic_at_one_half_is_impossible`）の Lean 必要十分版。

具体版から有限箱、分配多項式、回文性、素数 2、有理数、点数の立方を落とすと、残るのは次の二つだけである。

1. 各値の冪の上で加法的な `ℤ` 値の指標（`v (value L ^ k) = k * v (value L)`）。
2. 二つの箱の指標と指数の積が相異なること（`size (L+p) * v (value L) ≠ size L * v (value (L+p))`）。

有理点 2 の場合と違い、指標の値が 1 に等しいことは残らない。あちらは両辺の指標が指数そのものに
なるので指数の相異なることだけで閉じたが、こちらの指標は箱ごとに変わるため、比較すべきは
指数と指標の積である。指標の値域は `ℕ` では足りない（`1 - #E_L` は負になる）ので `ℤ` へ広げる。
台は `ℕ` 冪が定義されていれば足り、モノイド則も可換性も使わない。
加法性を全元へ課さず値の族の上だけで課すのは、具体版が使うのがそこだけだからである
（`padicValRat` の冪則は分母が消える点で崩れうるので、全元へ広げると余計な仮定が要る）。
-/
import Mathlib

namespace Ising3DCut.NecSuf

/-- 冪の上で加法的な `ℤ` 値の指標について、指数と指標の積が異なる二つの冪は一致しない。 -/
theorem pow_ne_pow_of_pow_additive_index_mul_ne {M : Type*} [Pow M ℕ]
    (v : M → ℤ) {a b : M} {i j : ℕ}
    (hpowa : v (a ^ i) = (i : ℤ) * v a) (hpowb : v (b ^ j) = (j : ℤ) * v b)
    (hne : (i : ℤ) * v a ≠ (j : ℤ) * v b) : a ^ i ≠ b ^ j := by
  intro heq
  apply hne
  rw [← hpowa, ← hpowb, heq]

/-- 閾値以後の交差冪等式は、指数と指標の積が二つの箱で相異なる限り成り立たない。 -/
theorem no_eventual_cross_power_identity_of_pow_additive_index_mul_ne
    {M : Type*} [Pow M ℕ]
    (v : M → ℤ) (value : ℕ → M) (size : ℕ → ℕ) (threshold period : ℕ)
    (hpow : ∀ L, 2 ≤ L → ∀ k : ℕ, v (value L ^ k) = (k : ℤ) * v (value L))
    (hbalance : ∀ L, 2 ≤ L →
      (size (L + period) : ℤ) * v (value L) ≠ (size L : ℤ) * v (value (L + period)))
    (hcross : ∀ L, threshold ≤ L →
      value L ^ size (L + period) = value (L + period) ^ size L) : False := by
  have hthreshold : threshold ≤ max threshold 2 := le_max_left _ _
  have htwo : 2 ≤ max threshold 2 := le_max_right _ _
  exact pow_ne_pow_of_pow_additive_index_mul_ne v
    (hpow _ htwo _)
    (hpow _ (le_trans htwo (Nat.le_add_right _ _)) _)
    (hbalance _ htwo) (hcross _ hthreshold)

end Ising3DCut.NecSuf
