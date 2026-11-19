/-
# 実数に 0 を右から掛けると 0 になる（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_claim_real_times_zero_is_zero`、ラベル **`real_times_zero_is_zero`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 6 行の鎖（加法の単位元を右辺から左辺へ → 加法の逆元を右辺から左辺へ → 加法の結合律 → 分配律 `a(b+c) = ab+ac` を右辺から左辺へ → `0 + 0 = 0` → 加法の逆元） | `real_times_zero_is_zero` の `calc` の 6 段 |

- 人手の `-z`（`def_real_difference` の加法の逆元）は mathlib の `-z`（`Neg ℝ`）で、`z + (-z) = 0` は `add_neg_cancel` で読む。
- mathlib の `mul_zero`・`MulZeroClass` は使わない（人手の鎖をそのまま書くため）。

必要十分版は `Ising2D/NecSuf/MulZeroOfLeftDistrib.lean`、具体版をその系として導くのは
`ClaimRealTimesZeroIsZeroFromNecSuf.lean`。
-/
import Mathlib.Data.Real.Basic

namespace Ising2D

/-- **人手 `real_times_zero_is_zero`**: `x ∈ ℝ` について `x·0 = 0`（人手の 6 行の鎖と 1 対 1 の `calc`）。 -/
theorem real_times_zero_is_zero (x : ℝ) : x * 0 = 0 :=
  calc x * 0
      = x * 0 + 0 := (add_zero (x * 0)).symm                                   -- `0` は加法の単位元を右辺から左辺へ
    _ = x * 0 + (x * 0 + -(x * 0)) := by rw [add_neg_cancel (x * 0)]            -- `z + (-z) = 0`（`z → x·0`）を右辺から左辺へ
    _ = (x * 0 + x * 0) + -(x * 0) := (add_assoc (x * 0) (x * 0) (-(x * 0))).symm  -- 加法の結合律
    _ = x * (0 + 0) + -(x * 0) := by rw [mul_add x (0 : ℝ) 0]                  -- 分配律 `a(b+c) = ab+ac` を右辺から左辺へ
    _ = x * 0 + -(x * 0) := by rw [add_zero (0 : ℝ)]                           -- `0 + 0 = 0`
    _ = 0 := add_neg_cancel (x * 0)                                            -- `z + (-z) = 0`（`z → x·0`）

end Ising2D
