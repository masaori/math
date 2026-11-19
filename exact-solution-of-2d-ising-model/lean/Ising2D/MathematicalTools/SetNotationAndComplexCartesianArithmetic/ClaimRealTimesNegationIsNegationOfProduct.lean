/-
# 実数に右から符号を反転した実数を掛けると、積の符号が反転する（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_claim_real_times_negation_is_negation_of_product`、ラベル **`real_times_negation_is_negation_of_product`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 3 行の鎖（乗法の可換律（`p → x, q → -t`） → `real_negation_times_is_negation_of_product`（文字を `p, q` に替え `p → t, q → x`） → 乗法の可換律（`p → t, q → x`）） | `real_times_negation_is_negation_of_product` の `calc` の 3 段 |

- 人手の `-z`（`def_real_difference` の加法の逆元）は mathlib の `-z`（`Neg ℝ`）で読む。
- mathlib の `mul_neg` は使わない（人手の鎖をそのまま書くため）。

必要十分版は `Ising2D/NecSuf/MulNegOfCommRightDistrib.lean`、具体版をその系として導くのは
`ClaimRealTimesNegationIsNegationOfProductFromNecSuf.lean`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealNegationTimesIsNegationOfProduct

namespace Ising2D

/-- **人手 `real_times_negation_is_negation_of_product`**: `x, t ∈ ℝ` について `x·(-t) = -(x·t)`
（人手の 3 行の鎖と 1 対 1 の `calc`）。 -/
theorem real_times_negation_is_negation_of_product (x t : ℝ) : x * (-t) = -(x * t) :=
  calc x * (-t)
      = (-t) * x := mul_comm x (-t)                                      -- 乗法の可換律（`p → x, q → -t`）
    _ = -(t * x) := real_negation_times_is_negation_of_product t x       -- 文字を `p, q` に替え `p → t, q → x`
    _ = -(x * t) := by rw [mul_comm t x]                                 -- 乗法の可換律（`p → t, q → x`）

end Ising2D
