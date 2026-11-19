/-
# 実数に 0 を左から掛けると 0 になる（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_claim_real_zero_times_is_zero`、ラベル **`real_zero_times_is_zero`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 6 行の鎖（加法の単位元を右辺から左辺へ → 加法の逆元を右辺から左辺へ → 加法の結合律 → 分配則 `(a+b)c = ac+bc` を右辺から左辺へ → `0 + 0 = 0` → 加法の逆元） | `real_zero_times_is_zero` の `calc` の 6 段 |

- 人手の `-z`（`def_real_difference` の加法の逆元）は mathlib の `-z`（`Neg ℝ`）で、`z + (-z) = 0` は `add_neg_cancel` で読む。
- mathlib の `zero_mul`・`MulZeroClass` は使わない（人手の鎖をそのまま書くため）。

必要十分版は `Ising2D/NecSuf/ZeroMulOfRightDistrib.lean`、具体版をその系として導くのは
`ClaimRealZeroTimesIsZeroFromNecSuf.lean`。
-/
import Mathlib.Data.Real.Basic

namespace Ising2D

/-- **人手 `real_zero_times_is_zero`**: `x ∈ ℝ` について `0·x = 0`（人手の 6 行の鎖と 1 対 1 の `calc`）。 -/
theorem real_zero_times_is_zero (x : ℝ) : 0 * x = 0 :=
  calc 0 * x
      = 0 * x + 0 := (add_zero (0 * x)).symm                                   -- `0` は加法の単位元を右辺から左辺へ
    _ = 0 * x + (0 * x + -(0 * x)) := by rw [add_neg_cancel (0 * x)]            -- `z + (-z) = 0`（`z → 0·x`）を右辺から左辺へ
    _ = (0 * x + 0 * x) + -(0 * x) := (add_assoc (0 * x) (0 * x) (-(0 * x))).symm  -- 加法の結合律
    _ = (0 + 0) * x + -(0 * x) := by rw [add_mul (0 : ℝ) 0 x]                  -- 分配則 `(a+b)c = ac+bc` を右辺から左辺へ
    _ = 0 * x + -(0 * x) := by rw [add_zero (0 : ℝ)]                           -- `0 + 0 = 0`
    _ = 0 := add_neg_cancel (0 * x)                                            -- `z + (-z) = 0`（`z → 0·x`）

end Ising2D
