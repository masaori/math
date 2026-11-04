/-
# `(1/2)_ℂ = 2_ℂ^{-1}`（具体版）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calc_formulae_claim_real_inclusion_of_one_half_is_inverse_of_two`、ラベル **`real_inclusion_of_one_half_is_inverse_of_two`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 7 行の鎖（積の単位元 → 逆元 → 積の結合律 → `real_inclusion_preserves_product`（`a → 1/2`、`b → 2`）→ ℝ で `1/2·2 = 1` → `1_ℂ = (1)_ℂ` → 積の単位元） | `real_inclusion_half_eq_inv_two` の `calc` の 7 段 |

- 人手の `2_ℂ := (2)_ℂ` は Lean の `((2 : ℝ) : ℂ)`、`2_ℂ^{-1}` は `((2 : ℝ) : ℂ)⁻¹`（`complex_numbers_form_a_field` の逆元。Lean では
  mathlib の `ℂ` の体の構造の逆元）、`(1/2)_ℂ` は `((1 / 2 : ℝ) : ℂ)` である。
- 2 段目の逆元は `mul_inv_cancel₀` で、その仮定 `2_ℂ ≠ 0_ℂ` は人手の主張の前置き（`(2, 0) ≠ (0, 0)`）に当たる。

具体的な二つの数（`1/2` と `2`）の計算であり、`real_inclusion_preserves_product`（`real_inclusion_mul`）と同じく必要十分版は置かない。
calc が実際に使うのは、終域の積の結合律と単位元、終域での `2_ℂ` の右逆元、包含が積と `1` を保つこと、ℝ の `1/2·2 = 1` だけで、
体であること・可換性・加法は使っていない（モノイドの間の乗法的な写像の主張として述べ直せる）。
-/
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesProduct

namespace Ising2D

/-- 人手 `real_inclusion_of_one_half_is_inverse_of_two` の前置き: `2_ℂ ≠ 0_ℂ`（`(2, 0) ≠ (0, 0)`。実部が `2 ≠ 0`）。 -/
theorem real_inclusion_two_ne_zero : ((2 : ℝ) : ℂ) ≠ 0 := by
  intro h
  have hre : ((2 : ℝ) : ℂ).re = (0 : ℂ).re := congrArg Complex.re h
  rw [Complex.ofReal_re, Complex.zero_re] at hre
  exact two_ne_zero hre

/-- **人手 `real_inclusion_of_one_half_is_inverse_of_two`**: `(1/2)_ℂ = 2_ℂ^{-1}`。 -/
theorem real_inclusion_half_eq_inv_two : ((1 / 2 : ℝ) : ℂ) = ((2 : ℝ) : ℂ)⁻¹ :=
  calc ((1 / 2 : ℝ) : ℂ)
      = ((1 / 2 : ℝ) : ℂ) * 1 := (mul_one _).symm                          -- 積の単位元
    _ = ((1 / 2 : ℝ) : ℂ) * (((2 : ℝ) : ℂ) * ((2 : ℝ) : ℂ)⁻¹) := by
        rw [mul_inv_cancel₀ real_inclusion_two_ne_zero]                    -- `2_ℂ^{-1}` は `2_ℂ` の逆元
    _ = (((1 / 2 : ℝ) : ℂ) * ((2 : ℝ) : ℂ)) * ((2 : ℝ) : ℂ)⁻¹ :=
        (mul_assoc _ _ _).symm                                             -- 積の結合律
    _ = (((1 / 2) * 2 : ℝ) : ℂ) * ((2 : ℝ) : ℂ)⁻¹ := by
        rw [real_inclusion_mul]                                            -- `real_inclusion_preserves_product`（`a → 1/2`、`b → 2`）
    _ = ((1 : ℝ) : ℂ) * ((2 : ℝ) : ℂ)⁻¹ := by
        rw [show (1 / 2 : ℝ) * 2 = 1 by norm_num]                          -- ℝ で `1/2·2 = 1`
    _ = 1 * ((2 : ℝ) : ℂ)⁻¹ := by rw [Complex.ofReal_one]                 -- `1_ℂ = (1)_ℂ`（`inclusion_rr_to_cc` の略記）
    _ = ((2 : ℝ) : ℂ)⁻¹ := one_mul _                                       -- 積の単位元

end Ising2D
