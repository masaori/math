/-
# 実数の差の包含は包含の差に等しい（具体版）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
（`calc_formulae_claim_real_inclusion_preserves_difference`、ラベル **`real_inclusion_preserves_difference`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 6 行の鎖 `y_ℂ − z_ℂ = ⋯ = (y − z)_ℂ` | `real_inclusion_sub` の `calc` の 6 段 |

- 人手の `r_ℂ := (r, 0)` は Lean の `(r : ℂ)`（`Complex.ofReal r`）である。
- 1 段目の `def_complex_difference`（`z - w := z + (-w)`）は mathlib の `sub_eq_add_neg`、2 段目の `multiply_by_minus_one`（`-z := (-1_ℂ)z`）は `neg_one_mul` で受ける。
- 3 段目の `-1_ℂ = (-1)_ℂ` は `inclusion_rr_to_cc` の略記なので、`Complex.ofReal_neg`・`Complex.ofReal_one` で読む。
- `real_inclusion_preserves_product` は具体版 `real_inclusion_mul`、`real_inclusion_preserves_sum` は具体版 `real_inclusion_add`。

具体的な 2 つの実数の計算であり、使う構造は ℂ の差・符号反転の定義と包含の積・和の保存だけなので、必要十分版は置かない
（`real_inclusion_preserves_product` の `real_inclusion_mul`、`real_inclusion_preserves_sum` の `real_inclusion_add` と同じ扱い）。
-/
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesProduct
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesSum

namespace Ising2D

/-- **人手 `real_inclusion_preserves_difference`**: `y_ℂ − z_ℂ = (y − z)_ℂ`（`y, z ∈ ℝ`）。人手の 6 行と calc の 6 段が 1 対 1 である。 -/
theorem real_inclusion_sub (y z : ℝ) : (y : ℂ) - (z : ℂ) = ((y - z : ℝ) : ℂ) :=
  calc (y : ℂ) - (z : ℂ)
      = (y : ℂ) + -(z : ℂ) := sub_eq_add_neg _ _              -- `def_complex_difference`
    _ = (y : ℂ) + (-1 : ℂ) * (z : ℂ) := by rw [neg_one_mul]   -- `multiply_by_minus_one`
    _ = (y : ℂ) + ((-1 : ℝ) : ℂ) * (z : ℂ) := by
        rw [Complex.ofReal_neg, Complex.ofReal_one]           -- `inclusion_rr_to_cc` の `-1_ℂ = ι_{ℝ→ℂ}(-1) = (-1)_ℂ`
    _ = (y : ℂ) + (((-1) * z : ℝ) : ℂ) := by
        rw [real_inclusion_mul]                               -- `real_inclusion_preserves_product`
    _ = ((y + (-1) * z : ℝ) : ℂ) := real_inclusion_add _ _    -- `real_inclusion_preserves_sum`
    _ = ((y - z : ℝ) : ℂ) := by congr 1; ring                 -- 実数の四則（ℝ の式 `y + (-1)z = y - z`）

end Ising2D
