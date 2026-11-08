/-
# 実数の二乗は、その実数を二つ掛けた積に等しい（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
（`calc_formulae_claim_square_of_real_number_is_product`、ラベル **`square_of_real_number_is_product`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 4 行の鎖（`a^{m+1} := a^m a`（`m → 1`）→ 同（`m → 0`）→ `a^0 := 1` → `1` は乗法の単位元） | `square_of_real_number_is_product` の `calc` の 4 段 |

- 人手の冪（`def_power_of_real_number`）は mathlib の `r ^ 2`（`Monoid.npow`）で、定義の 2 つの式は `pow_zero`・`pow_succ` で読む
  （`ClaimPowerOfRealOneIsOne.lean` と同じ）。mathlib の `sq`・`pow_two` は使わない。

必要十分版は `Ising2D/NecSuf/SquareIsProduct.lean`、具体版をその系として導くのは
`ClaimSquareOfRealNumberIsProductFromNecSuf.lean`。
-/
import Mathlib.Algebra.Group.Basic
import Mathlib.Data.Real.Basic

namespace Ising2D

/-- **人手 `square_of_real_number_is_product`**: `r ∈ ℝ` について `r^2 = r r`（人手の 4 行の鎖と 1 対 1 の `calc`）。 -/
theorem square_of_real_number_is_product (r : ℝ) : r ^ 2 = r * r :=
  calc r ^ 2
      = r ^ 1 * r := pow_succ r 1                                             -- `a^{m+1} := a^m a`（`a → r`, `m → 1`）
    _ = (r ^ 0 * r) * r := by rw [pow_succ r 0]                               -- `a^{m+1} := a^m a`（`a → r`, `m → 0`）
    _ = (1 * r) * r := by rw [pow_zero r]                                     -- `a^0 := 1`（`a → r`）
    _ = r * r := by rw [one_mul r]                                            -- `1` は ℝ の乗法の単位元

end Ising2D
