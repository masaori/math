/-
# 実数から 0 を引いても変わらない（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_claim_real_minus_zero_is_self`、ラベル **`real_minus_zero_is_self`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 3 行の鎖（`def_real_difference`（`y → a, z → 0`）→ `real_negation_of_zero_is_zero` → 加法の単位元） | `real_minus_zero_is_self` の `calc` の 3 段 |

- 人手の差 `y - z := y + (-z)`（`def_real_difference`）は mathlib の `sub_eq_add_neg` で読む。
- mathlib の `sub_zero` は使わない（人手の鎖をそのまま書くため）。

必要十分版は `Ising2D/NecSuf/SubZeroOfNegZero.lean`、具体版をその系として導くのは
`ClaimRealMinusZeroIsSelfFromNecSuf.lean`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealNegationOfZeroIsZero

namespace Ising2D

/-- **人手 `real_minus_zero_is_self`**: `a ∈ ℝ` について `a - 0 = a`（人手の 3 行の鎖と 1 対 1 の `calc`）。 -/
theorem real_minus_zero_is_self (a : ℝ) : a - 0 = a :=
  calc a - 0
      = a + -0 := sub_eq_add_neg a 0                          -- `def_real_difference`（`y → a, z → 0`）
    _ = a + 0 := by rw [real_negation_of_zero_is_zero]        -- `real_negation_of_zero_is_zero`
    _ = a := add_zero a                                       -- `0` は加法の単位元

end Ising2D
