/-
# 実数を 2 で割った商を二つ足すともとの実数に戻る（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_claim_real_half_plus_half_is_original`、ラベル **`real_half_plus_half_is_original`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 1 行目 `b/2 + b/2 = 2·(b/2)`（`real_sum_of_two_equal_terms_is_twice`（`a → b/2`）） | `calc` の 1 段目（`real_sum_of_two_equal_terms_is_twice (b / 2)`） |
| 2 行目 `= b`（`real_twice_quotient_by_two_is_original`（`b → b`）） | 2 段目（`real_twice_quotient_by_two_is_original b`） |

- 人手の 2 行はどちらも本文の主張を引くだけなので、Lean も同じ 2 本の具体版を 1 回ずつ引く。

必要十分版は置かない。人手の 2 行は、必要十分版を持つ 2 つの主張（`NecSuf.add_self_eq_two_mul'`・
`NecSuf.mul_div_cancel_of_right_inverse'`）を続けて当てるだけで、新しく効く性質は無い（効くのは、`a + a = 2a` と
`2·(b/2) = b` の 2 つだけである）。取り払える構造をこの説明以上に示す計算が無いので、別のファイルを立てない。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealSumOfTwoEqualTermsIsTwice
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealTwiceQuotientByTwoIsOriginal

namespace Ising2D

/-- **人手 `real_half_plus_half_is_original`**: `ℝ` で `b/2 + b/2 = b`（人手の 2 行の鎖と 1 対 1 の `calc`）。 -/
theorem real_half_plus_half_is_original (b : ℝ) : b / 2 + b / 2 = b :=
  calc b / 2 + b / 2
      = 2 * (b / 2) := real_sum_of_two_equal_terms_is_twice (b / 2)   -- `real_sum_of_two_equal_terms_is_twice`（`a → b/2`）
    _ = b := real_twice_quotient_by_two_is_original b                  -- `real_twice_quotient_by_two_is_original`（`b → b`）

end Ising2D
