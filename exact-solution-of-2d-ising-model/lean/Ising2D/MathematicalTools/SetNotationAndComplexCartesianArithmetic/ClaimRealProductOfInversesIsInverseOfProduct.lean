/-
# 0 でない実数の逆元どうしの積は積の逆元（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_claim_real_product_of_inverses_is_inverse_of_product`、ラベル **`real_product_of_inverses_is_inverse_of_product`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 主張の前置き `a·b ≠ 0`（`real_product_of_nonzero_is_nonzero`） | `hab` |
| 準備の 7 行の鎖（結合律 → 結合律を右辺から左辺へ → 可換律 → 結合律 → 逆元 `z z^{-1} = 1`（`z → b`） → 単位元 `x·1 = x` → 逆元（`z → a`）） | `prep` の `calc` の 7 段 |
| 主鎖の 6 行（単位元 `1·x = x` を右辺から左辺へ → 逆元（`z → a·b`）を右辺から左辺へ → 可換律 → 結合律 → 準備 → 単位元 `x·1 = x`） | `real_product_of_inverses_is_inverse_of_product` の `calc` の 6 段 |

- 人手の乗法の逆元 `z^{-1}`（`def_real_quotient`、`z z^{-1} = 1_ℝ`）は mathlib の `z⁻¹` と、逆元の式の具体版 `real_mul_inv_cancel`（`DefinitionRealQuotient.lean`）で読む。
- mathlib の `mul_inv`・`mul_inv_rev` は使わない（人手の鎖をそのまま書くため）。

必要十分版は `Ising2D/NecSuf/MulOfRightInversesEqRightInverseOfMul.lean`、具体版をその系として導くのは
`ClaimRealProductOfInversesIsInverseOfProductFromNecSuf.lean`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.DefinitionRealQuotient
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealProductOfNonzeroIsNonzero

namespace Ising2D

/-- **人手 `real_product_of_inverses_is_inverse_of_product`**: `a, b ∈ ℝ`、`a ≠ 0`、`b ≠ 0` について
`a^{-1}·b^{-1} = (a·b)^{-1}`（準備の 7 行と主鎖の 6 行と 1 対 1 の `calc`）。 -/
theorem real_product_of_inverses_is_inverse_of_product (a b : ℝ) (ha : a ≠ 0) (hb : b ≠ 0) :
    a⁻¹ * b⁻¹ = (a * b)⁻¹ := by
  have hab : a * b ≠ 0 := real_product_of_nonzero_is_nonzero a b ha hb
                                              -- `real_product_of_nonzero_is_nonzero` より `a·b ≠ 0`
  have prep : (a * b) * (a⁻¹ * b⁻¹) = 1 :=
    calc (a * b) * (a⁻¹ * b⁻¹)
        = a * (b * (a⁻¹ * b⁻¹)) := mul_assoc a b (a⁻¹ * b⁻¹)       -- 乗法の結合律
      _ = a * ((b * a⁻¹) * b⁻¹) := by rw [mul_assoc b a⁻¹ b⁻¹]       -- 乗法の結合律を右辺から左辺へ
      _ = a * ((a⁻¹ * b) * b⁻¹) := by rw [mul_comm b a⁻¹]            -- 乗法の可換律
      _ = a * (a⁻¹ * (b * b⁻¹)) := by rw [mul_assoc a⁻¹ b b⁻¹]       -- 乗法の結合律
      _ = a * (a⁻¹ * 1) := by rw [real_mul_inv_cancel b hb]                -- `def_real_quotient` の逆元（`z → b`）
      _ = a * a⁻¹ := by rw [mul_one]                                 -- 単位元 `x·1 = x`（`x → a^{-1}`）
      _ = 1 := real_mul_inv_cancel a ha                                  -- `def_real_quotient` の逆元（`z → a`）
  calc a⁻¹ * b⁻¹
      = 1 * (a⁻¹ * b⁻¹) := (one_mul _).symm                          -- 単位元 `1·x = x` を右辺から左辺へ
    _ = ((a * b) * (a * b)⁻¹) * (a⁻¹ * b⁻¹) := by rw [real_mul_inv_cancel (a * b) hab]
                                              -- `def_real_quotient` の逆元（`z → a·b ≠ 0`）を右辺から左辺へ
    _ = ((a * b)⁻¹ * (a * b)) * (a⁻¹ * b⁻¹) := by rw [mul_comm (a * b) (a * b)⁻¹]
                                              -- 乗法の可換律
    _ = (a * b)⁻¹ * ((a * b) * (a⁻¹ * b⁻¹)) := mul_assoc _ _ _       -- 乗法の結合律
    _ = (a * b)⁻¹ * 1 := by rw [prep]                                -- 準備
    _ = (a * b)⁻¹ := mul_one _                                       -- 単位元 `x·1 = x`（`x → (a·b)^{-1}`）

end Ising2D
