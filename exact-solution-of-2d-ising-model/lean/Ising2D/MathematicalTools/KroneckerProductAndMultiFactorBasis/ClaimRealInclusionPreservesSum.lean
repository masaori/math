/-
# 実数の和の包含は包含の和に等しい（具体版）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
（`calc_formulae_claim_real_inclusion_preserves_sum`、ラベル **`real_inclusion_preserves_sum`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 4 行の鎖（`inclusion_rr_to_cc` を 2 か所 → `definition_of_cc` の和 → ℝ で `0 + 0 = 0` → `inclusion_rr_to_cc`） | `real_inclusion_add` の `calc` の 4 段 |

- 人手の `r_ℂ := (r, 0)` は Lean の `(r : ℂ)`（`Complex.ofReal r`）で、1 段目と 4 段目は `complex_ofReal_eq_mk`（`inclusion_rr_to_cc`）、
  2 段目は `complex_mk_add_mk`（`definition_of_cc` の和）である（`DefinitionComplexNumbers.lean`）。
- 3 段目は、`𝐂 = 𝐑²` の元の等号を成分ごとに見る `complex_mk_eq_mk_iff`（`definition_of_cc`）で、第 1 成分は `a + b = a + b`、第 2 成分は ℝ の `0 + 0 = 0` である。

具体的な 2 つの実数の計算であり、主張に固有の構造は ℂ の和の定義の式だけなので、必要十分版は置かない
（`real_inclusion_preserves_product` の `real_inclusion_mul` と同じ扱い）。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.DefinitionComplexNumbers

namespace Ising2D

/-- **人手 `real_inclusion_preserves_sum`**: `a_ℂ + b_ℂ = (a + b)_ℂ`（`a, b ∈ ℝ`）。 -/
theorem real_inclusion_add (a b : ℝ) : (a : ℂ) + (b : ℂ) = ((a + b : ℝ) : ℂ) :=
  calc (a : ℂ) + (b : ℂ)
      = (⟨a, 0⟩ : ℂ) + ⟨b, 0⟩ := by rw [complex_ofReal_eq_mk a, complex_ofReal_eq_mk b] -- `inclusion_rr_to_cc` を 2 か所へ同時適用
    _ = ⟨a + b, 0 + 0⟩ := complex_mk_add_mk a 0 b 0                         -- `definition_of_cc` の和
    _ = ⟨a + b, 0⟩ := (complex_mk_eq_mk_iff _ _ _ _).mpr ⟨rfl, add_zero (0 : ℝ)⟩ -- ℝ で `0 + 0 = 0`
    _ = ((a + b : ℝ) : ℂ) := (complex_ofReal_eq_mk (a + b)).symm            -- `inclusion_rr_to_cc`

end Ising2D
