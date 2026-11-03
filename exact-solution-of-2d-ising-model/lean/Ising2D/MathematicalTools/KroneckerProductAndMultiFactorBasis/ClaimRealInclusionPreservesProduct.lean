/-
# 実数の積の包含は包含の積に等しい（具体版）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
（`calc_formulae_claim_real_inclusion_preserves_product`、ラベル **`real_inclusion_preserves_product`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 5 行の鎖（`inclusion_rr_to_cc` → `definition_of_cc` の積 → ℝ で `x·0 = 0`・`0·x = 0` を 3 箇所 → ℝ で `x - 0 = x`・`0 + 0 = 0` → `inclusion_rr_to_cc`） | `real_inclusion_mul` の `calc` の 5 段 |

- 人手の `r_ℂ := (r, 0)` は Lean の `(r : ℂ)`（`Complex.ofReal r`。実部 `r`、虚部 `0` の構造体）である。
  1 段目と 5 段目はこの書き方の違いだけで `rfl`、2 段目は mathlib の ℂ の積の定義（`definition_of_cc` の積と同じ式）で `rfl` である。
- 3 段目・4 段目は、構造体の実部・虚部の ℝ の等式を `Complex.ext` で並べる。

具体的な 2 つの実数の計算であり、主張に固有の構造は ℂ の積の定義の式だけなので、必要十分版は置かない。
-/
import Mathlib.Data.Complex.Basic

namespace Ising2D

/-- **人手 `real_inclusion_preserves_product`**: `a_ℂ b_ℂ = (ab)_ℂ`（`a, b ∈ ℝ`）。 -/
theorem real_inclusion_mul (a b : ℝ) : (a : ℂ) * (b : ℂ) = ((a * b : ℝ) : ℂ) :=
  calc (a : ℂ) * (b : ℂ)
      = (⟨a, 0⟩ : ℂ) * ⟨b, 0⟩ := rfl                                        -- `inclusion_rr_to_cc`
    _ = ⟨a * b - 0 * 0, a * 0 + 0 * b⟩ := rfl                               -- `definition_of_cc` の積
    _ = ⟨a * b - 0, 0 + 0⟩ :=
        Complex.ext (by simp only [mul_zero]) (by simp only [mul_zero, zero_mul]) -- ℝ で `x·0 = 0` と `0·x = 0` を 3 箇所へ
    _ = ⟨a * b, 0⟩ := Complex.ext (sub_zero (a * b)) (add_zero (0 : ℝ))     -- ℝ で `x - 0 = x` と `0 + 0 = 0`
    _ = ((a * b : ℝ) : ℂ) := rfl                                            -- `inclusion_rr_to_cc`

end Ising2D
