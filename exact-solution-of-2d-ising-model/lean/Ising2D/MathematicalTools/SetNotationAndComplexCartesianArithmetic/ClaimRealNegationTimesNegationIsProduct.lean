/-
# 符号を反転した実数どうしの積は、もとの実数どうしの積に等しい（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_claim_real_negation_times_negation_is_product`、ラベル **`real_negation_times_negation_is_product`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 9 行の鎖（`real_minus_one_times_is_negation`（`a → a`）を右辺から左辺へ → 同（`a → b`）を右辺から左辺へ → 乗法の結合則 → 乗法の結合則 → 乗法の可換則 → 乗法の結合則 → `real_minus_one_times_is_negation`（`a → a·b`） → 同（`a → -(a·b)`） → `real_double_negation`（`a → a·b`）） | `real_negation_times_negation_is_product` の `calc` の 9 段 |

- 人手の `-z`（`def_real_difference` の加法の逆元）は mathlib の `-z`（`Neg ℝ`）で読む。
- mathlib の `neg_mul_neg` は使わない（人手の鎖をそのまま書くため）。

必要十分版は `Ising2D/NecSuf/NegMulNegOfRightDistrib.lean`、具体版をその系として導くのは
`ClaimRealNegationTimesNegationIsProductFromNecSuf.lean`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealMinusOneTimesIsNegation
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealDoubleNegation

namespace Ising2D

/-- **人手 `real_negation_times_negation_is_product`**: `a, b ∈ ℝ` について `(-a)·(-b) = a·b`
（人手の 9 行の鎖と 1 対 1 の `calc`）。 -/
theorem real_negation_times_negation_is_product (a b : ℝ) : (-a) * (-b) = a * b :=
  calc (-a) * (-b)
      = ((-1) * a) * (-b) := by rw [real_minus_one_times_is_negation a]                -- `a → a` を右辺から左辺へ
    _ = ((-1) * a) * ((-1) * b) := by rw [real_minus_one_times_is_negation b]          -- `a → b` を右辺から左辺へ
    _ = (-1) * (a * ((-1) * b)) := mul_assoc (-1) a ((-1) * b)                         -- 乗法の結合則
    _ = (-1) * ((a * (-1)) * b) := by rw [mul_assoc a (-1) b]                          -- 乗法の結合則
    _ = (-1) * (((-1) * a) * b) := by rw [mul_comm a (-1)]                             -- 乗法の可換則
    _ = (-1) * ((-1) * (a * b)) := by rw [mul_assoc (-1) a b]                          -- 乗法の結合則
    _ = (-1) * (-(a * b)) := by rw [real_minus_one_times_is_negation (a * b)]          -- `a → a·b`
    _ = -(-(a * b)) := real_minus_one_times_is_negation (-(a * b))                     -- `a → -(a·b)`
    _ = a * b := real_double_negation (a * b)                                          -- `real_double_negation`（`a → a·b`）

end Ising2D
