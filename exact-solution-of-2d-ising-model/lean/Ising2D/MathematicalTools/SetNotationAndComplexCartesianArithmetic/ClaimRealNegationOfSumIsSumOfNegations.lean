/-
# 実数の和の符号を反転すると、符号を反転した実数の和になる（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_claim_real_negation_of_sum_is_sum_of_negations`、ラベル **`real_negation_of_sum_is_sum_of_negations`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 3 行の鎖（`real_minus_one_times_is_negation`（`a → x+y`）を右辺から左辺へ → 分配則 `p(q+r) = pq+pr`（`p → -1, q → x, r → y`） → `real_minus_one_times_is_negation`（`a → x` と `a → y`）を 2 箇所へ） | `real_negation_of_sum_is_sum_of_negations` の `calc` の 3 段 |

- 人手の `-z`（`def_real_difference` の加法の逆元）は mathlib の `-z`（`Neg ℝ`）で読む。
- mathlib の `neg_add` は使わない（人手の鎖をそのまま書くため）。

必要十分版は `Ising2D/NecSuf/NegAddOfDistrib.lean`、具体版をその系として導くのは
`ClaimRealNegationOfSumIsSumOfNegationsFromNecSuf.lean`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealMinusOneTimesIsNegation

namespace Ising2D

/-- **人手 `real_negation_of_sum_is_sum_of_negations`**: `x, y ∈ ℝ` について `-(x+y) = (-x)+(-y)`
（人手の 3 行の鎖と 1 対 1 の `calc`）。 -/
theorem real_negation_of_sum_is_sum_of_negations (x y : ℝ) : -(x + y) = (-x) + (-y) :=
  calc -(x + y)
      = (-1) * (x + y) := (real_minus_one_times_is_negation (x + y)).symm   -- `a → x+y` を右辺から左辺へ
    _ = (-1) * x + (-1) * y := mul_add (-1) x y                           -- 分配則 `p(q+r) = pq+pr`（`p → -1, q → x, r → y`）
    _ = (-x) + (-y) := by
        rw [real_minus_one_times_is_negation x, real_minus_one_times_is_negation y]
                                                                          -- `a → x` と `a → y` を 2 箇所へ

end Ising2D
