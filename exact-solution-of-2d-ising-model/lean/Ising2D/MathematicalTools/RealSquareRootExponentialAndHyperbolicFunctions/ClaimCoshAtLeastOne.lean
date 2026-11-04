/-
# `cosh x ≥ 1`（**具体版**）

人手証明（正本は `structured-latex/content/020_critical_point.ts`）:
- `critical_claim_cosh_at_least_one`（ラベル `cosh_at_least_one`）

人手の証明は、含意の鎖 `sinh²(x/2) ≥ 0 ⟹ 2sinh²(x/2) ≥ 2·0 ⟹ 1 + 2sinh²(x/2) ≥ 1 + 2·0` と、
`cosh x = 1 + 2sinh²(x/2) ≥ 1 + 2·0 = 1` の 3 行の鎖である。含意の鎖の 3 つの式は `cosh_at_least_one` の
`h0`・`h1`・`h2` と、続く鎖は `calc` の 3 段と 1 対 1 である。
`cosh_half_angle_formula` は `ClaimCoshAdditionAndHalfAngle.lean` の `cosh_eq_one_add_two_sinh_half_sq` で受ける。
必要十分版は `Ising2D/NecSuf/OnePlusTwiceNonnegativeIsAtLeastOne.lean` の `NecSuf.one_add_two_mul_sq_ge_one'`、
具体版をその特殊化として得る導出は `ClaimCoshAtLeastOneFromNecSuf.lean`。
-/
import Ising2D.MathematicalTools.RealSquareRootExponentialAndHyperbolicFunctions.ClaimCoshAdditionAndHalfAngle

namespace Ising2D

/-- **人手 `cosh_at_least_one`**: `x ∈ ℝ` について `cosh x ≥ 1`。 -/
theorem cosh_at_least_one (x : ℝ) : Real.cosh x ≥ 1 := by
  have h0 : Real.sinh (x / 2) ^ 2 ≥ 0 := sq_nonneg _    -- 実数の平方は非負
  have h1 : 2 * Real.sinh (x / 2) ^ 2 ≥ 2 * 0 :=
    mul_le_mul_of_nonneg_left h0 two_pos.le            -- 両辺に `2 > 0` を掛ける
  have h2 : 1 + 2 * Real.sinh (x / 2) ^ 2 ≥ 1 + 2 * 0 :=
    add_le_add_right h1 1                              -- 両辺に `1` を加える
  calc Real.cosh x
      = 1 + 2 * Real.sinh (x / 2) ^ 2 := cosh_eq_one_add_two_sinh_half_sq x
                                                        -- `cosh_half_angle_formula`
    _ ≥ 1 + 2 * 0 := h2                                 -- 上の含意の鎖
    _ = 1 := by rw [mul_zero, add_zero]                 -- ℝ の四則

end Ising2D
