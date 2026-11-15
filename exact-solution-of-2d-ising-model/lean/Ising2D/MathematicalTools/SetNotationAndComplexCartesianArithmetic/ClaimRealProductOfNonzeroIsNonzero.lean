/-
# 0 でない実数どうしの積は 0 でない（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_claim_real_product_of_nonzero_is_nonzero`、ラベル **`real_product_of_nonzero_is_nonzero`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 準備（`a·b = 0` と仮定して矛盾を導く。`a^{-1}` は `a` の乗法の逆元） | `intro hab`・`apply hb` |
| 5 行の鎖（乗法の単位元を右辺から左辺へ → 乗法の逆元 `a^{-1}·a = 1` を右辺から左辺へ → 乗法の結合則 → 仮定 `a·b = 0` → `real_times_zero_is_zero`（`x → a^{-1}`）） | `real_product_of_nonzero_is_nonzero` の `calc` の 5 段 |
| 結び（`b ≠ 0` に反する） | `apply hb` が `b = 0` を目標にしたこと |

- 人手の乗法の逆元 `a^{-1}`（体 `ℝ` の公理、`a ≠ 0`）は mathlib の `a⁻¹` と `inv_mul_cancel₀` で読む。
- mathlib の `mul_ne_zero` は使わない（人手の鎖をそのまま書くため）。

必要十分版は `Ising2D/NecSuf/MulNeZeroOfLeftInverse.lean`、具体版をその系として導くのは
`ClaimRealProductOfNonzeroIsNonzeroFromNecSuf.lean`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealTimesZeroIsZero

namespace Ising2D

/-- **人手 `real_product_of_nonzero_is_nonzero`**: `a, b ∈ ℝ`、`a ≠ 0`、`b ≠ 0` について `a·b ≠ 0`
（`a·b = 0` を仮定し、人手の 5 行の鎖と 1 対 1 の `calc` で `b = 0` を導く）。 -/
theorem real_product_of_nonzero_is_nonzero (a b : ℝ) (ha : a ≠ 0) (hb : b ≠ 0) : a * b ≠ 0 := by
  intro hab
  apply hb
  calc b
      = 1 * b := (one_mul b).symm                          -- 乗法の単位元を右辺から左辺へ
    _ = (a⁻¹ * a) * b := by rw [inv_mul_cancel₀ ha]          -- 乗法の逆元 `a^{-1}·a = 1` を右辺から左辺へ
    _ = a⁻¹ * (a * b) := mul_assoc a⁻¹ a b                    -- 乗法の結合則
    _ = a⁻¹ * 0 := by rw [hab]                                -- 仮定 `a·b = 0`
    _ = 0 := real_times_zero_is_zero a⁻¹                      -- `real_times_zero_is_zero`（`x → a^{-1}`）

end Ising2D
