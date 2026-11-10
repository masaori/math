/-
# 二乗は、その元を二つ掛けた積に等しい（**必要十分版**）

具体版: `Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimSquareOfRealNumberIsProduct.lean`
（人手 `square_of_real_number_is_product`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimSquareOfRealNumberIsProductFromNecSuf.lean`。
複素数の具体版 `Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimSquareOfComplexNumberIsProduct.lean`
（人手 `square_of_complex_number_is_product`）も同じ手順で、`R := ℂ` の系として
`Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimSquareOfComplexNumberIsProductFromNecSuf.lean` で導く。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `calc` の 4 段（`a^{m+1} = a^m a`（`m → 1`）→ 同（`m → 0`）→ `a^0 = 1` → `1·r = r`） | `sq_eq_mul_self'` の `calc` の 4 段（同じ並び） |

## 何が効いているか / 効いていないか

- 効くのは、冪の定義の 2 つの式と、`1` が左からの乗法の単位元であること（4 段目）だけである。
  積の結合則・可換則、和、順序、実数・複素数であることは効いていない。
- `Monoid R` は mathlib の冪 `^`（`Monoid.npow`）と、その定義の式 `pow_zero`・`pow_succ` を使うためだけに要る
  （`PowerOfOneIsOne.lean` と同じ事情）。
-/
import Mathlib.Algebra.Group.Defs

namespace Ising2D.NecSuf

/-- **`square_of_real_number_is_product`**・**`square_of_complex_number_is_product`** の必要十分版: `r^2 = r r`。 -/
theorem sq_eq_mul_self' {R : Type*} [Monoid R] (r : R) : r ^ 2 = r * r :=
  calc r ^ 2
      = r ^ 1 * r := pow_succ r 1                                             -- `a^{m+1} = a^m a`（`m → 1`）
    _ = (r ^ 0 * r) * r := by rw [pow_succ r 0]                               -- `a^{m+1} = a^m a`（`m → 0`）
    _ = (1 * r) * r := by rw [pow_zero r]                                     -- `a^0 = 1`
    _ = r * r := by rw [one_mul r]                                            -- `1·r = r`

end Ising2D.NecSuf
