/-
# `(r^{-1})_ℂ = (r_ℂ)^{-1}`（具体版）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calc_formulae_claim_real_inclusion_preserves_inverse`、ラベル **`real_inclusion_preserves_inverse`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 準備 `r_ℂ ∈ ℂ^×`（`r_ℂ = (r, 0)` の第 1 成分の背理法） | `real_inclusion_ne_zero` |
| 7 行の鎖（積の単位元 → 逆元 → 積の結合律 → `real_inclusion_preserves_product`（`a → r^{-1}`、`b → r`）→ ℝ で `r^{-1}r = 1` → `1_ℂ = (1)_ℂ` → 積の単位元） | `real_inclusion_inv` の `calc` の 7 段 |

- 人手の `r_ℂ` は Lean の `((r : ℝ) : ℂ)`、`(r_ℂ)^{-1}` は `((r : ℝ) : ℂ)⁻¹`（`multiplicative_group_of_cc` の逆元。Lean では
  mathlib の `ℂ` の体の構造の逆元）、`r^{-1}` は ℝ の逆数 `r⁻¹` である。
- 2 段目の逆元は `mul_inv_cancel₀` で、その仮定 `r_ℂ ≠ 0_ℂ` は人手の準備に当たる。5 段目の `r^{-1}r = 1` は ℝ の `inv_mul_cancel₀`。

`real_inclusion_half_eq_inv_two`（`ClaimRealInclusionOfOneHalfIsInverseOfTwo.lean`）と同じ鎖を一般の `r ≠ 0` で書いたもの。
calc が実際に使うのは、終域の積の結合律と単位元、終域での `r_ℂ` の右逆元、包含が積と `1` を保つこと、
始域での `r^{-1}` の左逆元だけで、可換性・加法は使っていない（モノイドの間の乗法的な写像の主張として述べ直せる）。
必要十分版は置かない。述べ直した主張は「左逆元の像は右逆元の像に等しい」というモノイドの一般論そのものになり、
この鎖の 7 段以外に効いている構造を示さない（効いている性質は上に挙げたとおりである）。
-/
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesProduct

namespace Ising2D

/-- 人手 `real_inclusion_preserves_inverse` の準備: `r ≠ 0` なら `r_ℂ ≠ 0_ℂ`（`(r, 0) ≠ (0, 0)`。実部が `r ≠ 0`）。 -/
theorem real_inclusion_ne_zero {r : ℝ} (hr : r ≠ 0) : ((r : ℝ) : ℂ) ≠ 0 := by
  intro h
  have hre : ((r : ℝ) : ℂ).re = (0 : ℂ).re := congrArg Complex.re h
  rw [Complex.ofReal_re, Complex.zero_re] at hre
  exact hr hre

/-- **人手 `real_inclusion_preserves_inverse`**: `r ≠ 0` なら `(r^{-1})_ℂ = (r_ℂ)^{-1}`。 -/
theorem real_inclusion_inv {r : ℝ} (hr : r ≠ 0) : ((r⁻¹ : ℝ) : ℂ) = ((r : ℝ) : ℂ)⁻¹ :=
  calc ((r⁻¹ : ℝ) : ℂ)
      = ((r⁻¹ : ℝ) : ℂ) * 1 := (mul_one _).symm                              -- 積の単位元
    _ = ((r⁻¹ : ℝ) : ℂ) * (((r : ℝ) : ℂ) * ((r : ℝ) : ℂ)⁻¹) := by
        rw [mul_inv_cancel₀ (real_inclusion_ne_zero hr)]                     -- `(r_ℂ)^{-1}` は `r_ℂ` の逆元
    _ = (((r⁻¹ : ℝ) : ℂ) * ((r : ℝ) : ℂ)) * ((r : ℝ) : ℂ)⁻¹ :=
        (mul_assoc _ _ _).symm                                               -- 積の結合律
    _ = ((r⁻¹ * r : ℝ) : ℂ) * ((r : ℝ) : ℂ)⁻¹ := by
        rw [real_inclusion_mul]                                              -- `real_inclusion_preserves_product`（`a → r^{-1}`、`b → r`）
    _ = ((1 : ℝ) : ℂ) * ((r : ℝ) : ℂ)⁻¹ := by
        rw [inv_mul_cancel₀ hr]                                              -- ℝ で `r^{-1}r = 1`
    _ = 1 * ((r : ℝ) : ℂ)⁻¹ := by rw [Complex.ofReal_one]                   -- `1_ℂ = (1)_ℂ`（`inclusion_rr_to_cc` の略記）
    _ = ((r : ℝ) : ℂ)⁻¹ := one_mul _                                         -- 積の単位元

end Ising2D
