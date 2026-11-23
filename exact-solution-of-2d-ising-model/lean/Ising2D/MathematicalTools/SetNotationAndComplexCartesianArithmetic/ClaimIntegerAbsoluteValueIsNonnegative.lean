/-
# 整数の絶対値は 0 以上（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
（`calc_formulae_claim_integer_absolute_value_is_nonnegative`、ラベル **`int_absolute_value_is_nonnegative`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `0_ℤ ≤ x` の場合の鎖 `0 ≤ x = |x|`（場合の仮定、`def_int_absolute_value` の `0 ≤ x` の場合の式を右辺から左辺へ） | `hx` の場合の `calc` の 2 段 |
| `¬(0_ℤ ≤ x)` の場合、ℤ の全順序 `0 ≤ x ∨ x ≤ 0` の左が成り立たないので `x ≤ 0` | `(le_total 0 x).resolve_left hx` |
| 鎖 `0 = x + (−x) ≤ 0 + (−x) = −x = |x|` | `¬hx` の場合の `calc` の 4 段 |

- `set_and_algebra_notation` の ℤ の行のうち、加法の逆元は `add_neg_cancel`、順序と加法の両立 `x ≤ y ⇒ x + t ≤ y + t` は
  `add_le_add_left`（この mathlib では `b ≤ c ⇒ b + a ≤ c + a`）、和の単位元 `0 + x = x` は `zero_add`、全順序は `le_total` で読む。
- `def_int_absolute_value` の二つの式は `int_abs_of_nonneg_and_of_not_nonneg` で読む。mathlib の `abs_nonneg` は使わない（人手の論法をそのまま書くため）。

必要十分版は `Ising2D/NecSuf/AbsNonnegOfCases.lean`、具体版をその系として導くのは
`ClaimIntegerAbsoluteValueIsNonnegativeFromNecSuf.lean`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.DefinitionIntegerAbsoluteValue

namespace Ising2D

/-- **人手 `int_absolute_value_is_nonnegative`**: `x ∈ ℤ` について `0 ≤ |x|`
（人手の論法: `0 ≤ x` なら `|x| = x`、そうでなければ全順序で `x ≤ 0` とし、両辺に `−x` を足す）。 -/
theorem int_absolute_value_is_nonnegative (x : ℤ) : 0 ≤ |x| := by
  by_cases hx : 0 ≤ x
  · calc (0 : ℤ)
        ≤ x := hx                                                      -- 場合の仮定 `0 ≤ x`
      _ = |x| := ((int_abs_of_nonneg_and_of_not_nonneg x).1 hx).symm    -- `def_int_absolute_value` の `0 ≤ x` の場合の式を右辺から左辺へ
  · have hx0 : x ≤ 0 := (le_total 0 x).resolve_left hx                 -- ℤ の全順序（`x → 0, y → x`）の左が成り立たない
    calc (0 : ℤ)
        = x + -x := (add_neg_cancel x).symm                             -- ℤ の加法の逆元（`x → x`）を右辺から左辺へ
      _ ≤ 0 + -x := add_le_add_left hx0 (-x)                            -- ℤ の順序と加法の両立（`x → x, y → 0, t → −x`）
      _ = -x := zero_add (-x)                                           -- ℤ の和の単位元 `0 + x = x`（`x → −x`）
      _ = |x| := ((int_abs_of_nonneg_and_of_not_nonneg x).2 hx).symm    -- `def_int_absolute_value` の `¬(0 ≤ x)` の場合の式を右辺から左辺へ

end Ising2D
