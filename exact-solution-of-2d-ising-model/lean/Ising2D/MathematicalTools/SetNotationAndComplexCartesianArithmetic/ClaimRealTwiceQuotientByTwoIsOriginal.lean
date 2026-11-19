/-
# 実数を 2 で割った商に 2 を掛けるともとの実数に戻る（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_claim_real_twice_quotient_by_two_is_original`、ラベル **`real_twice_quotient_by_two_is_original`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 1 行目 `2·(b/2) = 2·(b·2^{-1})`（`def_real_quotient`（`y → b, z → 2`）） | `calc` の 1 段目（`div_eq_mul_inv`） |
| 2 行目 `= 2·(2^{-1}·b)`（乗法の交換則 `xy = yx`（`x → b, y → 2^{-1}`）） | 2 段目（`mul_comm`） |
| 3 行目 `= (2·2^{-1})·b`（乗法の結合則 `(xy)t = x(yt)` を右辺から左辺へ） | 3 段目（`mul_assoc` の逆向き） |
| 4 行目 `= 1·b`（乗法の逆元 `x·x^{-1} = 1`（`x → 2`。`2 ≠ 0` は `real_two_is_nonzero`）） | 4 段目（`mul_inv_cancel₀ real_two_is_nonzero`） |
| 5 行目 `= b`（乗法の単位元 `1·x = x`（`x → b`）） | 5 段目（`one_mul`） |

- 人手の商 `y/z := y z^{-1}`（`def_real_quotient`）は mathlib の `div_eq_mul_inv` で読む。
  順序体 `ℝ` の公理（`set_and_algebra_notation`）の段は mathlib の `mul_comm`・`mul_assoc`・`mul_inv_cancel₀`・`one_mul` を
  それぞれ 1 回引く。
- 4 行目が `2 ≠ 0` を使うので、`real_two_is_nonzero` を引く（mathlib の `two_ne_zero` は使わない）。
- mathlib の `mul_div_cancel₀` は使わない（人手の鎖をそのまま書くため）。

必要十分版は `Ising2D/NecSuf/MulDivCancelOfRightInverse.lean`、具体版をその系として導くのは
`ClaimRealTwiceQuotientByTwoIsOriginalFromNecSuf.lean`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealTwoIsNonzero

namespace Ising2D

/-- **人手 `real_twice_quotient_by_two_is_original`**: `ℝ` で `2·(b/2) = b`（人手の 5 行の鎖と 1 対 1 の `calc`）。 -/
theorem real_twice_quotient_by_two_is_original (b : ℝ) : 2 * (b / 2) = b :=
  calc 2 * (b / 2)
      = 2 * (b * 2⁻¹) := by
        rw [div_eq_mul_inv b 2]                                -- `def_real_quotient`（`y → b, z → 2`）
    _ = 2 * (2⁻¹ * b) := by
        rw [mul_comm b (2⁻¹ : ℝ)]                              -- 乗法の交換則 `xy = yx`（`x → b, y → 2^{-1}`）
    _ = (2 * 2⁻¹) * b := (mul_assoc (2 : ℝ) 2⁻¹ b).symm        -- 乗法の結合則（`x → 2, y → 2^{-1}, t → b`）を右辺から左辺へ
    _ = 1 * b := by
        rw [mul_inv_cancel₀ real_two_is_nonzero]               -- 乗法の逆元 `x·x^{-1} = 1`（`x → 2`。`real_two_is_nonzero`）
    _ = b := one_mul b                                         -- 乗法の単位元 `1·x = x`（`x → b`）

end Ising2D
