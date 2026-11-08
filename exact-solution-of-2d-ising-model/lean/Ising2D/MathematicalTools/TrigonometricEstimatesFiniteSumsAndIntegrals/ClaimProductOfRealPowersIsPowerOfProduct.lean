/-
# 同じ指数の実数の冪の積は積の冪に等しい（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_claim_product_of_real_powers_is_power_of_product`、ラベル **`product_of_real_powers_is_power_of_product`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `m = 0` の 3 行（`a^0 := 1` を 2 箇所へ → `1` は乗法の単位元 → `a^0 := 1` を右辺から左辺へ） | `product_of_real_powers_is_power_of_product` の `0` の節の `calc` の 3 段 |
| `m → m+1` の 4 行（`a^{m+1} := a^m a` を 2 箇所へ → `(pq)(rs) = (pr)(qs)` → 帰納法の仮定 → `a^{m+1} := a^m a` を右辺から左辺へ） | `m + 1` の節の `calc` の 4 段 |

- 人手の `m ∈ ℤ_{≥0}` は Lean の `m : ℕ` である。
- 人手の冪（`def_power_of_real_number`）は mathlib の `a ^ m`（`Monoid.npow`）で、定義の 2 つの式は `pow_zero`・`pow_succ` で読む。
  mathlib の `mul_pow` は使わない。
- 人手の「`ℝ` で `(pq)(rs) = (pr)(qs)`（乗法の交換則と結合則）」は mathlib の `mul_mul_mul_comm` である
  （`ClaimFiniteProductOfRealProducts.lean` と同じ）。

必要十分版は `Ising2D/NecSuf/ProductOfPowersIsPowerOfProduct.lean`、具体版をその系として導くのは
`ClaimProductOfRealPowersIsPowerOfProductFromNecSuf.lean`。
-/
import Mathlib.Algebra.Group.Basic
import Mathlib.Data.Real.Basic

namespace Ising2D

/-- **人手 `product_of_real_powers_is_power_of_product`**: `a^m b^m = (ab)^m`（`m` についての帰納法）。 -/
theorem product_of_real_powers_is_power_of_product :
    ∀ (m : ℕ) (a b : ℝ), a ^ m * b ^ m = (a * b) ^ m
  | 0, a, b =>
    calc a ^ 0 * b ^ 0
        = 1 * 1 := by rw [pow_zero, pow_zero]                                 -- `a^0 := 1`（`a → a`、`a → b`）を 2 箇所へ同時に
      _ = 1 := one_mul 1                                                      -- `1` は ℝ の乗法の単位元
      _ = (a * b) ^ 0 := (pow_zero (a * b)).symm                              -- `a^0 := 1`（`a → ab`）を右辺から左辺へ
  | m + 1, a, b =>
    calc a ^ (m + 1) * b ^ (m + 1)
        = (a ^ m * a) * (b ^ m * b) := by rw [pow_succ, pow_succ]             -- `a^{m+1} := a^m a`（`a → a`、`a → b`）を 2 箇所へ同時に
      _ = (a ^ m * b ^ m) * (a * b) := mul_mul_mul_comm _ _ _ _               -- ℝ で `(pq)(rs) = (pr)(qs)`（乗法の交換則と結合則）
      _ = (a * b) ^ m * (a * b) := by rw [product_of_real_powers_is_power_of_product m a b]
                                                                              -- 帰納法の仮定
      _ = (a * b) ^ (m + 1) := (pow_succ (a * b) m).symm                      -- `a^{m+1} := a^m a`（`a → ab`）を右辺から左辺へ

end Ising2D
