/-
# 実数に −1 を左から掛けると符号が反転する（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_claim_real_minus_one_times_is_negation`、ラベル **`real_minus_one_times_is_negation`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 10 行の鎖（加法の単位元を右辺から左辺へ → 加法の逆元（`z → a`）を右辺から左辺へ → 加法の結合則 → 乗法の単位元 `1·a = a` を右辺から左辺へ → 分配則 `(x+y)c = xc+yc` を右辺から左辺へ → 加法の可換則 → 加法の逆元（`z → 1`） → `real_zero_times_is_zero`（`x → a`） → 加法の可換則 → 加法の単位元） | `real_minus_one_times_is_negation` の `calc` の 10 段 |

- 人手の `-z`（`def_real_difference` の加法の逆元）は mathlib の `-z`（`Neg ℝ`）で、`z + (-z) = 0` は `add_neg_cancel` で読む。
  人手の `-1` は `def_real_difference` の `z → 1` で、Lean の `-1 : ℝ` は `-(1 : ℝ)` である。
- mathlib の `neg_one_mul`・`neg_mul`・`zero_mul` は使わない（人手の鎖をそのまま書くため）。

必要十分版は `Ising2D/NecSuf/NegOneMulOfRightDistrib.lean`、具体版をその系として導くのは
`ClaimRealMinusOneTimesIsNegationFromNecSuf.lean`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealZeroTimesIsZero

namespace Ising2D

/-- **人手 `real_minus_one_times_is_negation`**: `a ∈ ℝ` について `(-1)·a = -a`（人手の 10 行の鎖と 1 対 1 の `calc`）。 -/
theorem real_minus_one_times_is_negation (a : ℝ) : (-1) * a = -a :=
  calc (-1) * a
      = (-1) * a + 0 := (add_zero ((-1) * a)).symm                           -- `0` は加法の単位元を右辺から左辺へ
    _ = (-1) * a + (a + -a) := by rw [add_neg_cancel a]                       -- `z + (-z) = 0`（`z → a`）を右辺から左辺へ
    _ = ((-1) * a + a) + -a := (add_assoc ((-1) * a) a (-a)).symm             -- 加法の結合則
    _ = ((-1) * a + 1 * a) + -a := by rw [one_mul a]                          -- `1·a = a` を右辺から左辺へ
    _ = ((-1) + 1) * a + -a := by rw [add_mul (-1 : ℝ) 1 a]                   -- 分配則 `(x+y)c = xc+yc` を右辺から左辺へ
    _ = (1 + -1) * a + -a := by rw [add_comm (-1 : ℝ) 1]                      -- 加法の可換則
    _ = 0 * a + -a := by rw [add_neg_cancel (1 : ℝ)]                          -- `z + (-z) = 0`（`z → 1`）
    _ = 0 + -a := by rw [real_zero_times_is_zero a]                           -- `real_zero_times_is_zero`（`x → a`）
    _ = -a + 0 := add_comm 0 (-a)                                             -- 加法の可換則
    _ = -a := add_zero (-a)                                                   -- `0` は加法の単位元

end Ising2D
