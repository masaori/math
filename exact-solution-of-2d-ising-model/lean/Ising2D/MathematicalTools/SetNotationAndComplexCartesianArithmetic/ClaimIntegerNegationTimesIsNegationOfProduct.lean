/-
# 符号を反転した整数に右から整数を掛けると、積の符号が反転する（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
（`calc_formulae_claim_integer_negation_times_is_negation_of_product`、ラベル **`int_negation_times_is_negation_of_product`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 7 行の鎖（和の単位元を右辺から左辺へ → 加法の逆元を右辺から左辺へ → 加法の結合律を右辺から左辺へ → 分配律 `(y+z)s = ys+zs` を右辺から左辺へ → 加法の逆元 `(−y)+y = 0` → `int_zero_times_is_zero` → 和の単位元 `0 + y = y`） | `int_negation_times_is_negation_of_product` の `calc` の 7 段 |

- `set_and_algebra_notation` の ℤ の行のうち、和の単位元は `add_zero`・`zero_add`、加法の逆元は `add_neg_cancel`・`neg_add_cancel`、
  加法の結合律は `add_assoc`、分配律 `(y + z)·s = y·s + z·s` は `add_mul` で読む。
- mathlib の `neg_mul` は使わない（人手の鎖をそのまま書くため）。

必要十分版は `Ising2D/NecSuf/NegMulOfAddGroupRightDistrib.lean`、具体版をその系として導くのは
`ClaimIntegerNegationTimesIsNegationOfProductFromNecSuf.lean`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimIntegerZeroTimesIsZero

namespace Ising2D

/-- **人手 `int_negation_times_is_negation_of_product`**: `x, t ∈ ℤ` について `(−x)·t = −(x·t)`
（人手の 7 行の鎖と 1 対 1 の `calc`）。 -/
theorem int_negation_times_is_negation_of_product (x t : ℤ) : (-x) * t = -(x * t) :=
  calc (-x) * t
      = (-x) * t + 0 := (add_zero ((-x) * t)).symm                             -- ℤ の和の単位元（`y → (−x)·t`）を右辺から左辺へ
    _ = (-x) * t + (x * t + -(x * t)) := by rw [add_neg_cancel (x * t)]        -- ℤ の加法の逆元（`y → x·t`）を右辺から左辺へ
    _ = ((-x) * t + x * t) + -(x * t) := (add_assoc ((-x) * t) (x * t) (-(x * t))).symm  -- ℤ の加法の結合律を右辺から左辺へ
    _ = ((-x) + x) * t + -(x * t) := by rw [add_mul (-x) x t]                  -- ℤ の分配律 `(y+z)s = ys+zs` を右辺から左辺へ
    _ = 0 * t + -(x * t) := by rw [neg_add_cancel x]                           -- ℤ の加法の逆元 `(−y)+y = 0`（`y → x`）
    _ = 0 + -(x * t) := by rw [int_zero_times_is_zero t]                       -- `int_zero_times_is_zero`（`x → t`）
    _ = -(x * t) := zero_add (-(x * t))                                        -- ℤ の和の単位元 `0 + y = y`（`y → −(x·t)`）

end Ising2D
