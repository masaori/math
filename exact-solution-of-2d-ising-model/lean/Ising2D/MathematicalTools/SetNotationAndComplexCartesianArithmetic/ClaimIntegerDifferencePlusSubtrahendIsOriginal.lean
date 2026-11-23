/-
# 整数の差に引いた数を足すともとに戻る（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
（`calc_formulae_claim_integer_difference_plus_subtrahend_is_original`、ラベル **`int_difference_plus_subtrahend_is_original`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 4 行の鎖（`def_int_difference` → 加法の結合律 → 加法の逆元 `(−x)+x = 0` → 和の単位元 `x + 0 = x`） | `int_difference_plus_subtrahend_is_original` の `calc` の 4 段 |

- `def_int_difference` は `int_sub_eq_add_neg` で読む。
- `set_and_algebra_notation` の ℤ の行のうち、加法の結合律は `add_assoc`、加法の逆元 `(−x) + x = 0` は `neg_add_cancel`、
  和の単位元 `x + 0 = x` は `add_zero` で読む。
- mathlib の `sub_add_cancel`・`omega` は使わない（人手の鎖をそのまま書くため）。

必要十分版は `Ising2D/NecSuf/SubAddCancelOfAddGroup.lean`、具体版をその系として導くのは
`ClaimIntegerDifferencePlusSubtrahendIsOriginalFromNecSuf.lean`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.DefinitionIntegerDifference

namespace Ising2D

/-- **人手 `int_difference_plus_subtrahend_is_original`**: `x, y ∈ ℤ` について `(x − y) + y = x`
（人手の 4 行の鎖と 1 対 1 の `calc`）。 -/
theorem int_difference_plus_subtrahend_is_original (x y : ℤ) : (x - y) + y = x :=
  calc (x - y) + y
      = (x + -y) + y := by rw [int_sub_eq_add_neg x y]                      -- `def_int_difference`（`y → x, z → y`）
    _ = x + (-y + y) := add_assoc x (-y) y                                   -- ℤ の加法の結合律 `(x + y) + t = x + (y + t)`（`y → −y, t → y`）
    _ = x + 0 := by rw [neg_add_cancel y]                                    -- ℤ の加法の逆元 `(−x) + x = 0`（`x → y`）
    _ = x := add_zero x                                                      -- ℤ の和の単位元 `x + 0 = x`

end Ising2D
