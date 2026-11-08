/-
# 同じ指数の冪の積は積の冪に等しい（**必要十分版**）

具体版: `Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimProductOfRealPowersIsPowerOfProduct.lean`
（人手 `product_of_real_powers_is_power_of_product`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimProductOfRealPowersIsPowerOfProductFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `m = 0` の 3 段（`a^0 = 1` を 2 箇所へ → `1·1 = 1` → `a^0 = 1` を右辺から左辺へ） | `pow_mul_pow_eq_mul_pow'` の `0` の節（同じ並び） |
| `m → m + 1` の 4 段（`a^{m+1} = a^m a` を 2 箇所へ → `(pq)(rs) = (pr)(qs)` → 帰納法の仮定 → `a^{m+1} = a^m a`） | `pow_mul_pow_eq_mul_pow'` の `m + 1` の節（同じ並び） |

## 何が効いているか / 効いていないか

- 効くのは、冪の定義の 2 つの式（`a^0 = 1`・`a^{m+1} = a^m a`）、`1·1 = 1`（`m = 0` の 2 段目）、
  明示の仮定 `hswap`: `(pq)(rs) = (pr)(qs)`（帰納法の段の 2 段目）だけである。
- `hswap` は `Monoid` の単位元と合わせると積の可換則と同値である（`hswap 1 q r 1` から `qr = rq`）。
  したがってこの版の仮定は実質「可換モノイド」であり、具体版は ℝ の乗法の可換性に本当に依存している。
  それでも `CommMonoid` と書かず `hswap` の形で置くのは、証明が使うのが 4 つの元の並べ替えのこの形だけであることを
  具体版の段（人手の「`(pq)(rs) = (pr)(qs)`（乗法の交換則と結合則）」）と同じ形で示すためである。
  削れない理由: `hswap` を外すと帰納法の段の 2 段目 `(a^m a)(b^m b) = (a^m b^m)(ab)` が出ない。和・順序・逆元は効いていない。
- `Monoid R` は mathlib の冪 `^`（`Monoid.npow`）と、その定義の式 `pow_zero`・`pow_succ` を使うためだけに要る。
  `1·1 = 1` は `Monoid` の `one_mul` で受ける。`Monoid` はその公理として積の結合則も含むが、証明は `hswap` の外では使わない
  （`FiniteProductOfConstantIsPower.lean` と同じ事情）。
-/
import Mathlib.Algebra.Group.Defs

namespace Ising2D.NecSuf

/-- **`product_of_real_powers_is_power_of_product`** の必要十分版: `a^m b^m = (ab)^m`。 -/
theorem pow_mul_pow_eq_mul_pow' {R : Type*} [Monoid R]
    (hswap : ∀ p q r s : R, (p * q) * (r * s) = (p * r) * (q * s)) :
    ∀ (m : ℕ) (a b : R), a ^ m * b ^ m = (a * b) ^ m
  | 0, a, b =>
    calc a ^ 0 * b ^ 0
        = 1 * 1 := by rw [pow_zero, pow_zero]                                 -- `a^0 = 1` を 2 箇所へ
      _ = 1 := one_mul 1                                                      -- `1·1 = 1`
      _ = (a * b) ^ 0 := (pow_zero (a * b)).symm                              -- `a^0 = 1` を右辺から左辺へ
  | m + 1, a, b =>
    calc a ^ (m + 1) * b ^ (m + 1)
        = (a ^ m * a) * (b ^ m * b) := by rw [pow_succ, pow_succ]             -- `a^{m+1} = a^m a` を 2 箇所へ
      _ = (a ^ m * b ^ m) * (a * b) := hswap _ _ _ _                          -- `(pq)(rs) = (pr)(qs)`
      _ = (a * b) ^ m * (a * b) := by rw [pow_mul_pow_eq_mul_pow' hswap m a b] -- 帰納法の仮定
      _ = (a * b) ^ (m + 1) := (pow_succ (a * b) m).symm                      -- `a^{m+1} = a^m a` を右辺から左辺へ

end Ising2D.NecSuf
