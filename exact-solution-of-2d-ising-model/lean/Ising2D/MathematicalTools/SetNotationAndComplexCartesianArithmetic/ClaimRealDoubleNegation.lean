/-
# 実数の符号を 2 度反転するともとに戻る（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_claim_real_double_negation`、ラベル **`real_double_negation`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 8 行の鎖（加法の単位元を右辺から左辺へ → 加法の逆元（`z → a`）を右辺から左辺へ → 加法の可換則 → 加法の結合則 → 加法の可換則 → 加法の逆元（`z → -a`） → 加法の可換則 → 加法の単位元） | `real_double_negation` の `calc` の 8 段 |

- 人手の `-z`（`def_real_difference` の加法の逆元）は mathlib の `-z`（`Neg ℝ`）で、`z + (-z) = 0` は `add_neg_cancel` で読む。
- mathlib の `neg_neg` は使わない（人手の鎖をそのまま書くため）。

必要十分版は `Ising2D/NecSuf/NegNegOfAddCommGroup.lean`、具体版をその系として導くのは
`ClaimRealDoubleNegationFromNecSuf.lean`。
-/
import Mathlib.Data.Real.Basic

namespace Ising2D

/-- **人手 `real_double_negation`**: `a ∈ ℝ` について `-(-a) = a`（人手の 8 行の鎖と 1 対 1 の `calc`）。 -/
theorem real_double_negation (a : ℝ) : -(-a) = a :=
  calc -(-a)
      = -(-a) + 0 := (add_zero (-(-a))).symm                                 -- `0` は加法の単位元を右辺から左辺へ
    _ = -(-a) + (a + -a) := by rw [add_neg_cancel a]                          -- `z + (-z) = 0`（`z → a`）を右辺から左辺へ
    _ = -(-a) + (-a + a) := by rw [add_comm a (-a)]                           -- 加法の可換則
    _ = (-(-a) + -a) + a := (add_assoc (-(-a)) (-a) a).symm                   -- 加法の結合則
    _ = (-a + -(-a)) + a := by rw [add_comm (-(-a)) (-a)]                     -- 加法の可換則
    _ = 0 + a := by rw [add_neg_cancel (-a)]                                  -- `z + (-z) = 0`（`z → -a`）
    _ = a + 0 := add_comm 0 a                                                 -- 加法の可換則
    _ = a := add_zero a                                                       -- `0` は加法の単位元

end Ising2D
