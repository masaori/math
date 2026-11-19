/-
# 実数で 1 から 1/2 を引くと 1/2 になる（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_claim_real_one_minus_half_is_half`、ラベル **`real_one_minus_half_is_half`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 1 行目 `1 − 1/2 = 1 + (−1/2)`（`def_real_difference`（`y → 1, z → 1/2`）） | `calc` の 1 段目（`sub_eq_add_neg`） |
| 2 行目 `= 2·2^{-1} + (−1/2)`（乗法の逆元 `x·x^{-1} = 1`（`x → 2`）を右辺から左辺へ。`2 ≠ 0` は `real_two_is_nonzero`） | 2 段目（`mul_inv_cancel₀ real_two_is_nonzero`） |
| 3 行目 `= (1 + 1)·2^{-1} + (−1/2)`（`def_real_two` を左の因子の `2` だけへ） | 3 段目（`one_add_one_eq_two`） |
| 4 行目 `= (1·2^{-1} + 1·2^{-1}) + (−1/2)`（分配律 `(x + y)t = xt + yt`（`x, y → 1, t → 2^{-1}`）） | 4 段目（`add_mul`） |
| 5 行目 `= (1/2 + 1/2) + (−1/2)`（`def_real_quotient`（`y → 1, z → 2`）を右辺から左辺へ、2 箇所へ） | 5 段目（`div_eq_mul_inv` を右辺から左辺へ） |
| 6 行目 `= 1/2 + (1/2 + (−1/2))`（加法の結合律（`x, y, t → 1/2`）） | 6 段目（`add_assoc`） |
| 7 行目 `= 1/2 + 0`（加法の逆元 `x + (−x) = 0`（`x → 1/2`）） | 7 段目（`add_neg_cancel`） |
| 8 行目 `= 1/2`（加法の単位元 `x + 0 = x`（`x → 1/2`）） | 8 段目（`add_zero`） |

- 人手の差 `y − z := y + (−z)`（`def_real_difference`）は mathlib の `sub_eq_add_neg`、商 `y/z := y z^{-1}`
  （`def_real_quotient`）は `div_eq_mul_inv`、`2 := 1 + 1`（`def_real_two`）は `one_add_one_eq_two` で読む。
  順序体 `ℝ` の公理（`set_and_algebra_notation`）の段は mathlib の `mul_inv_cancel₀`・`add_mul`・`add_assoc`・
  `add_neg_cancel`・`add_zero` を 1 回ずつ引く。
- mathlib の `sub_half` は使わない（人手の鎖をそのまま書くため）。

必要十分版は `Ising2D/NecSuf/OneSubHalfEqHalf.lean`、具体版をその系として導くのは
`ClaimRealOneMinusHalfIsHalfFromNecSuf.lean`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealTwoIsNonzero

namespace Ising2D

/-- **人手 `real_one_minus_half_is_half`**: `ℝ` で `1 − 1/2 = 1/2`（人手の 8 行の鎖と 1 対 1 の `calc`）。 -/
theorem real_one_minus_half_is_half : (1 : ℝ) - 1 / 2 = 1 / 2 :=
  calc (1 : ℝ) - 1 / 2
      = 1 + -(1 / 2) := sub_eq_add_neg 1 (1 / 2)              -- `def_real_difference`（`y → 1, z → 1/2`）
    _ = 2 * 2⁻¹ + -(1 / 2) := by
        rw [mul_inv_cancel₀ real_two_is_nonzero]               -- 乗法の逆元 `x·x^{-1} = 1`（`x → 2`）を右辺から左辺へ
    _ = (1 + 1) * 2⁻¹ + -(1 / 2) := by
        rw [one_add_one_eq_two]                                -- `def_real_two` を左の因子の `2` だけへ
    _ = (1 * 2⁻¹ + 1 * 2⁻¹) + -(1 / 2) := by
        rw [add_mul (1 : ℝ) 1 2⁻¹]                             -- 分配律 `(x + y)t = xt + yt`（`x, y → 1, t → 2^{-1}`）
    _ = (1 / 2 + 1 / 2) + -(1 / 2) := by
        rw [← div_eq_mul_inv (1 : ℝ) 2]                        -- `def_real_quotient`（`y → 1, z → 2`）を右辺から左辺へ、2 箇所へ
    _ = 1 / 2 + (1 / 2 + -(1 / 2)) :=
        add_assoc (1 / 2) (1 / 2) (-(1 / 2))                   -- 加法の結合律（`x, y, t → 1/2`）
    _ = 1 / 2 + 0 := by
        rw [add_neg_cancel (1 / 2 : ℝ)]                        -- 加法の逆元 `x + (−x) = 0`（`x → 1/2`）
    _ = 1 / 2 := add_zero (1 / 2)                              -- 加法の単位元 `x + 0 = x`（`x → 1/2`）

end Ising2D
