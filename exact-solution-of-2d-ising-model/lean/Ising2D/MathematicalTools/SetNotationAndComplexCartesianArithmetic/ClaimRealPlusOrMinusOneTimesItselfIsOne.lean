/-
# −1 か 1 の実数は、自分自身との積が 1（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_claim_real_plus_or_minus_one_times_itself_is_one`、ラベル **`real_plus_or_minus_one_times_itself_is_one`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `σ = 1` の 1 行（ℝ の乗法の単位元 `p·1 = p`（`p → 1`）） | `real_plus_or_minus_one_times_itself_is_one` の `σ = 1` の節の `calc` の 1 段 |
| `σ = -1` の 2 行（`real_negation_times_negation_is_product`（`a → 1`、`b → 1`） → ℝ の乗法の単位元 `p·1 = p`（`p → 1`）） | `σ = -1` の節の `calc` の 2 段 |
| 「`σ` は `-1` か `1` なので、どちらの場合も `σ·σ = 1`」 | 仮定 `hσ : σ = 1 ∨ σ = -1` の場合分け |

- 人手の `σ ∈ {-1,1} ⊂ ℝ` は、実数 `σ` と仮定 `σ = 1 ∨ σ = -1` で受ける（行の配置の値の型 `SpinVal` の条件と同じ形）。
- 人手の「ℝ の乗法の単位元 `p·1 = p`（`set_and_algebra_notation`）」は mathlib の `mul_one` である。
- mathlib の `neg_one_mul`・`neg_mul_neg`・`norm_num` は使わない。

必要十分版は `Ising2D/NecSuf/MulSelfEqOneOfEqOneOrEqNegOne.lean`、具体版をその系として導くのは
`ClaimRealPlusOrMinusOneTimesItselfIsOneFromNecSuf.lean`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealNegationTimesNegationIsProduct

namespace Ising2D

/-- **人手 `real_plus_or_minus_one_times_itself_is_one`**: `σ ∈ {-1,1} ⊂ ℝ` なら `σ·σ = 1`
（人手の `σ = 1` の 1 行と `σ = -1` の 2 行と 1 対 1 の `calc`）。 -/
theorem real_plus_or_minus_one_times_itself_is_one (σ : ℝ) (hσ : σ = 1 ∨ σ = -1) : σ * σ = 1 := by
  rcases hσ with h | h
  · rw [h]
    exact (calc (1 : ℝ) * 1 = 1 := mul_one 1)                                      -- ℝ の乗法の単位元 `p·1 = p`（`p → 1`）
  · rw [h]
    calc (-1 : ℝ) * (-1)
        = 1 * 1 := real_negation_times_negation_is_product 1 1                  -- `real_negation_times_negation_is_product`（`a → 1`、`b → 1`）
      _ = 1 := mul_one 1                                                     -- ℝ の乗法の単位元 `p·1 = p`（`p → 1`）

end Ising2D
