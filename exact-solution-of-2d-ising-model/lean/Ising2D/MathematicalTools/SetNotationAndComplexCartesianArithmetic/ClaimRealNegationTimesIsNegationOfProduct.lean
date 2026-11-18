/-
# 符号を反転した実数に右から実数を掛けると、積の符号が反転する（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_claim_real_negation_times_is_negation_of_product`、ラベル **`real_negation_times_is_negation_of_product`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 3 行の鎖（`real_minus_one_times_is_negation`（`a → x`）を右辺から左辺へ → 乗法の結合則（`p → -1, q → x, r → t`） → `real_minus_one_times_is_negation`（`a → x·t`）） | `real_negation_times_is_negation_of_product` の `calc` の 3 段 |

- 人手の `-z`（`def_real_difference` の加法の逆元）は mathlib の `-z`（`Neg ℝ`）で読む。
- mathlib の `neg_mul` は使わない（人手の鎖をそのまま書くため）。

必要十分版は `Ising2D/NecSuf/NegMulOfRightDistrib.lean`、具体版をその系として導くのは
`ClaimRealNegationTimesIsNegationOfProductFromNecSuf.lean`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealMinusOneTimesIsNegation

namespace Ising2D

/-- **人手 `real_negation_times_is_negation_of_product`**: `x, t ∈ ℝ` について `(-x)·t = -(x·t)`
（人手の 3 行の鎖と 1 対 1 の `calc`）。 -/
theorem real_negation_times_is_negation_of_product (x t : ℝ) : (-x) * t = -(x * t) :=
  calc (-x) * t
      = ((-1) * x) * t := by rw [real_minus_one_times_is_negation x]     -- `a → x` を右辺から左辺へ
    _ = (-1) * (x * t) := mul_assoc (-1) x t                             -- 乗法の結合則（`p → -1, q → x, r → t`）
    _ = -(x * t) := real_minus_one_times_is_negation (x * t)             -- `a → x·t`

end Ising2D
