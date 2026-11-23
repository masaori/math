/-
# 0 以上の整数との積の絶対値（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
（`calc_formulae_claim_integer_absolute_value_of_product_with_nonnegative`、ラベル **`int_absolute_value_of_product_with_nonnegative`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `0_ℤ ≤ x` の場合: 順序と乗法の両立で `0 ≤ x·y`、鎖 `|x·y| = x·y = |x|·y` | `hx` の場合の `hxy` と `calc` の 2 段 |
| `¬(0_ℤ ≤ x)` の場合の準備の鎖 `|x|·y = (−x)·y = −(x·y)` | `hxy_neg` の `calc` の 2 段 |
| `int_absolute_value_is_nonnegative` と順序と乗法の両立で `0 ≤ |x|·y`、上の式で `0 ≤ −(x·y)` | `hneg_nonneg` |
| 排中律で `0 ≤ x·y` かどうかに分ける（`¬(0 ≤ x·y)` の場合を先に書く） | `rcases (em (0 ≤ x * y)).symm` |
| `¬(0 ≤ x·y)` の場合の鎖 `|x·y| = −(x·y) = |x|·y` | `calc` の 2 段 |
| `0 ≤ x·y` の場合の鎖 `x·y = 0 + x·y ≤ (−(x·y)) + x·y = 0` と反対称律で `x·y = 0` | `hxy_le` の `calc` の 3 段と `hxy_zero` |
| 続く鎖 `|x·y| = x·y = 0 = x·y + (−(x·y)) = 0 + (−(x·y)) = −(x·y) = |x|·y` | `calc` の 6 段 |

- `set_and_algebra_notation` の ℤ の行のうち、順序と乗法の両立 `(0 ≤ x ∧ 0 ≤ y) ⇒ 0 ≤ x·y` は `mul_nonneg`、
  順序と加法の両立 `x ≤ y ⇒ x + t ≤ y + t` は `add_le_add_left`（この mathlib では `b ≤ c ⇒ b + a ≤ c + a`）、
  反対称律は `le_antisymm`、和の単位元 `0 + z = z` は `zero_add`、加法の逆元は `add_neg_cancel`・`neg_add_cancel`、排中律は `em`（`0 ≤ x` の場合分けは `by_cases`）で読む。
- `def_int_absolute_value` の二つの式は `int_abs_of_nonneg_and_of_not_nonneg` で読む。mathlib の `abs_mul`・`abs_of_nonneg` は使わない
  （人手の論法をそのまま書くため）。

必要十分版は `Ising2D/NecSuf/AbsMulOfNonnegRightOfCases.lean`、具体版をその系として導くのは
`ClaimIntegerAbsoluteValueOfProductWithNonnegativeFromNecSuf.lean`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimIntegerAbsoluteValueIsNonnegative
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimIntegerNegationTimesIsNegationOfProduct

namespace Ising2D

/-- **人手 `int_absolute_value_of_product_with_nonnegative`**: `x, y ∈ ℤ`、`0 ≤ y` なら `|x·y| = |x|·y`
（人手の論法: `0 ≤ x` かどうか、続けて `0 ≤ x·y` かどうかで分ける）。 -/
theorem int_absolute_value_of_product_with_nonnegative (x y : ℤ) (hy : 0 ≤ y) :
    |x * y| = |x| * y := by
  by_cases hx : 0 ≤ x
  · have hxy : 0 ≤ x * y := mul_nonneg hx hy                                 -- ℤ の順序と乗法の両立（`x → x, y → y`）
    calc |x * y|
        = x * y := (int_abs_of_nonneg_and_of_not_nonneg (x * y)).1 hxy        -- `def_int_absolute_value` の `0 ≤ x` の場合の式（`x → x·y`）
      _ = |x| * y := by rw [(int_abs_of_nonneg_and_of_not_nonneg x).1 hx]      -- 同じ式（`x → x`）を右辺から左辺へ
  · have hxy_neg : |x| * y = -(x * y) :=
      calc |x| * y
          = (-x) * y := by rw [(int_abs_of_nonneg_and_of_not_nonneg x).2 hx]   -- `def_int_absolute_value` の `¬(0 ≤ x)` の場合の式（`x → x`）
        _ = -(x * y) := int_negation_times_is_negation_of_product x y          -- `int_negation_times_is_negation_of_product`（`x → x, t → y`）
    have hneg_nonneg : 0 ≤ -(x * y) := by
      rw [← hxy_neg]
      exact mul_nonneg (int_absolute_value_is_nonnegative x) hy               -- `int_absolute_value_is_nonnegative` と順序と乗法の両立（`x → |x|, y → y`）
    rcases (em (0 ≤ x * y)).symm with hxy | hxy                -- 排中律
    · calc |x * y|
          = -(x * y) := (int_abs_of_nonneg_and_of_not_nonneg (x * y)).2 hxy   -- `def_int_absolute_value` の `¬(0 ≤ x)` の場合の式（`x → x·y`）
        _ = |x| * y := hxy_neg.symm                                           -- 上の `|x|·y = −(x·y)` を右辺から左辺へ
    · have hxy_le : x * y ≤ 0 :=
        calc x * y
            = 0 + x * y := (zero_add (x * y)).symm                            -- ℤ の和の単位元（`z → x·y`）を右辺から左辺へ
          _ ≤ -(x * y) + x * y := add_le_add_left hneg_nonneg (x * y)          -- ℤ の順序と加法の両立（`x → 0, y → −(x·y), t → x·y`）
          _ = 0 := neg_add_cancel (x * y)                                     -- ℤ の加法の逆元 `(−z)+z = 0`（`z → x·y`）
      have hxy_zero : x * y = 0 := le_antisymm hxy_le hxy                     -- ℤ の順序の反対称律（`x → x·y, y → 0`）
      calc |x * y|
          = x * y := (int_abs_of_nonneg_and_of_not_nonneg (x * y)).1 hxy      -- `def_int_absolute_value` の `0 ≤ x` の場合の式（`x → x·y`）
        _ = 0 := hxy_zero                                                     -- 上の `x·y = 0`
        _ = x * y + -(x * y) := (add_neg_cancel (x * y)).symm                 -- ℤ の加法の逆元（`z → x·y`）を右辺から左辺へ
        _ = 0 + -(x * y) := by rw [hxy_zero]                                  -- 上の `x·y = 0`
        _ = -(x * y) := zero_add (-(x * y))                                   -- ℤ の和の単位元（`z → −(x·y)`）
        _ = |x| * y := hxy_neg.symm                                           -- 上の `|x|·y = −(x·y)` を右辺から左辺へ

end Ising2D
