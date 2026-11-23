/-
# 0 を 0 でない実数で割ると 0 になる（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_claim_real_zero_divided_is_zero`、ラベル **`real_zero_divided_is_zero`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 2 行の鎖（`def_real_quotient`（`y → 0, z → x`）→ `real_zero_times_is_zero`（`x → x^{-1}`）） | `real_zero_divided_is_zero` の `calc` の 2 段 |

- 人手の商 `y/z := y z^{-1}`（`def_real_quotient`）は具体版 `real_div_eq_mul_inv`（`DefinitionRealQuotient.lean`）で読む。
- 仮定 `x ≠ 0` は人手の主張どおりに置く。人手では `def_real_quotient` が商を定めるために要り、Lean でも
  `real_div_eq_mul_inv` の仮定（商の定義域）へ渡す。
- mathlib の `zero_div` は使わない（人手の鎖をそのまま書くため）。

必要十分版は `Ising2D/NecSuf/ZeroDivOfZeroMul.lean`、具体版をその系として導くのは
`ClaimRealZeroDividedIsZeroFromNecSuf.lean`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.DefinitionRealQuotient
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealZeroTimesIsZero

namespace Ising2D

/-- **人手 `real_zero_divided_is_zero`**: `x ∈ ℝ`、`x ≠ 0` について `0/x = 0`（人手の 2 行の鎖と 1 対 1 の `calc`）。 -/
theorem real_zero_divided_is_zero (x : ℝ) (hx : x ≠ 0) : 0 / x = 0 :=
  calc 0 / x
      = 0 * x⁻¹ := real_div_eq_mul_inv 0 x hx      -- `def_real_quotient`（`y → 0, z → x`）
    _ = 0 := real_zero_times_is_zero x⁻¹            -- `real_zero_times_is_zero`（`x → x^{-1}`）

end Ising2D
