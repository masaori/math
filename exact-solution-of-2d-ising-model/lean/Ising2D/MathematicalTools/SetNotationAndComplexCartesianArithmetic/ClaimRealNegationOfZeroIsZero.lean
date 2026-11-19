/-
# 実数の 0 の符号を反転しても 0 である（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_claim_real_negation_of_zero_is_zero`、ラベル **`real_negation_of_zero_is_zero`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 3 行の鎖（加法の単位元を右辺から左辺へ → 加法の可換律 → 加法の逆元 `z + (-z) = 0`（`z → 0`）） | `real_negation_of_zero_is_zero` の `calc` の 3 段 |

- 人手の `-z`（`def_real_difference` の加法の逆元）は mathlib の `-z`（`Neg ℝ`）で、`z + (-z) = 0` は `add_neg_cancel` で読む。
- mathlib の `neg_zero` は使わない（人手の鎖をそのまま書くため）。

必要十分版は `Ising2D/NecSuf/NegZeroOfAddComm.lean`、具体版をその系として導くのは
`ClaimRealNegationOfZeroIsZeroFromNecSuf.lean`。
-/
import Mathlib.Data.Real.Basic

namespace Ising2D

/-- **人手 `real_negation_of_zero_is_zero`**: ℝ で `-0 = 0`（人手の 3 行の鎖と 1 対 1 の `calc`）。 -/
theorem real_negation_of_zero_is_zero : -(0 : ℝ) = 0 :=
  calc -(0 : ℝ)
      = -0 + 0 := (add_zero (-(0 : ℝ))).symm    -- `0` は加法の単位元を右辺から左辺へ
    _ = 0 + -0 := add_comm (-(0 : ℝ)) 0          -- 加法の可換律
    _ = 0 := add_neg_cancel (0 : ℝ)              -- `z + (-z) = 0`（`z → 0`）

end Ising2D
