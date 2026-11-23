/-
# 正の実数の加法の逆元は負（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_claim_real_negation_of_positive_is_negative`、ラベル **`real_negation_of_positive_is_negative`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 鎖の 1 行目 `−a = 0 + (−a)`（加法の単位元を右辺から左辺へ） | `calc` の 1 段目 `(zero_add (-a)).symm` |
| 鎖の 2 行目 `0 + (−a) < a + (−a)`（主張の仮定 `0 < a` と `real_less_than_preserved_by_adding_on_right` の `x < y ⇒ x + c < y + c`、`x → 0, y → a, c → −a`） | `calc` の 2 段目 `real_less_than_preserved_by_adding_on_right 0 a (-a) ha` |
| 鎖の 3 行目 `a + (−a) = 0`（`def_real_difference` の加法の逆元 `z + (−z) = 0`、`z → a`） | `calc` の 3 段目 `add_neg_cancel a` |

- 人手の狭義の順序と加法の両立 `x < y ⇒ x + c < y + c` は、順序体の公理ではなく本文の主張 `real_less_than_preserved_by_adding_on_right`（同じフォルダの `ClaimRealLessThanPreservedByAddingOnRight.lean`）で読む。
- mathlib の `neg_neg_of_pos`・`neg_lt_zero` は使わない（人手の鎖をそのまま書くため）。

必要十分版は `Ising2D/NecSuf/NegLtZeroOfZeroLt.lean`、具体版をその系として導くのは
`ClaimRealNegationOfPositiveIsNegativeFromNecSuf.lean`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealLessThanPreservedByAddingOnRight
import Mathlib.Data.Real.Basic

namespace Ising2D

/-- **人手 `real_negation_of_positive_is_negative`**: `a ∈ ℝ`、`0 < a` について `−a < 0`
（人手の鎖 `−a = 0 + (−a) < a + (−a) = 0`）。 -/
theorem real_negation_of_positive_is_negative (a : ℝ) (ha : 0 < a) : -a < 0 :=
  calc -a
      = 0 + -a := (zero_add (-a)).symm                      -- 加法の単位元を右辺から左辺へ
    _ < a + -a := real_less_than_preserved_by_adding_on_right 0 a (-a) ha                    -- 主張の仮定と `real_less_than_preserved_by_adding_on_right`（`x → 0, y → a, c → −a`）
    _ = 0 := add_neg_cancel a                                -- `def_real_difference` の加法の逆元（`z → a`）

end Ising2D
