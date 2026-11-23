/-
# 整数の和の符号を反転すると、符号を反転した整数の和になる（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
（`calc_formulae_claim_integer_negation_of_sum_is_sum_of_negations`、ラベル **`int_negation_of_sum_is_sum_of_negations`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 10 行の鎖（和の単位元 → 加法の逆元 → 和の単位元 → 加法の逆元 → 加法の結合律 → 加法の結合律 → 加法の結合律 → 加法の逆元 → 和の単位元 → 加法の可換律） | `int_negation_of_sum_is_sum_of_negations` の `calc` の 10 段 |

- `set_and_algebra_notation` の ℤ の行のうち、和の単位元 `x + 0 = x`・`0 + x = x` は `add_zero`・`zero_add`、
  加法の逆元 `x + (−x) = 0`・`(−x) + x = 0` は `add_neg_cancel`・`neg_add_cancel`、加法の結合律は `add_assoc`、
  加法の可換律は `add_comm` で読む。
- mathlib の `neg_add`・`neg_add_rev`・`omega` は使わない（人手の鎖をそのまま書くため）。

必要十分版は `Ising2D/NecSuf/NegAddOfAddCommGroup.lean`、具体版をその系として導くのは
`ClaimIntegerNegationOfSumIsSumOfNegationsFromNecSuf.lean`。
-/
import Mathlib.Algebra.Group.Int.Defs

namespace Ising2D

/-- **人手 `int_negation_of_sum_is_sum_of_negations`**: `x, y ∈ ℤ` について `−(x + y) = (−x) + (−y)`
（人手の 10 行の鎖と 1 対 1 の `calc`）。 -/
theorem int_negation_of_sum_is_sum_of_negations (x y : ℤ) : -(x + y) = (-x) + (-y) :=
  calc -(x + y)
      = -(x + y) + 0 := (add_zero (-(x + y))).symm                           -- ℤ の和の単位元 `x + 0 = x`（`x → −(x + y)`）を右辺から左辺へ
    _ = -(x + y) + (x + -x) := by rw [add_neg_cancel x]                      -- ℤ の加法の逆元 `x + (−x) = 0` を右辺から左辺へ
    _ = -(x + y) + ((x + 0) + -x) := by rw [add_zero x]                      -- ℤ の和の単位元 `x + 0 = x` を右辺から左辺へ
    _ = -(x + y) + ((x + (y + -y)) + -x) := by rw [add_neg_cancel y]         -- ℤ の加法の逆元 `x + (−x) = 0`（`x → y`）を右辺から左辺へ
    _ = -(x + y) + (((x + y) + -y) + -x) := by rw [add_assoc x y (-y)]       -- ℤ の加法の結合律（`t → −y`）を右辺から左辺へ
    _ = -(x + y) + ((x + y) + (-y + -x)) := by rw [add_assoc (x + y) (-y) (-x)]
                                                                             -- ℤ の加法の結合律（`x → x + y`, `y → −y`, `t → −x`）
    _ = (-(x + y) + (x + y)) + (-y + -x) := (add_assoc (-(x + y)) (x + y) (-y + -x)).symm
                                                                             -- ℤ の加法の結合律（`x → −(x + y)`, `y → x + y`, `t → (−y) + (−x)`）を右辺から左辺へ
    _ = 0 + (-y + -x) := by rw [neg_add_cancel (x + y)]                      -- ℤ の加法の逆元 `(−x) + x = 0`（`x → x + y`）
    _ = -y + -x := zero_add (-y + -x)                                        -- ℤ の和の単位元 `0 + x = x`（`x → (−y) + (−x)`）
    _ = -x + -y := add_comm (-y) (-x)                                        -- ℤ の加法の可換律 `x + y = y + x`（`x → −y`, `y → −x`）

end Ising2D
