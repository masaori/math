/-
# 実数に 1/2 を掛けると 2 で割った商になる（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_claim_real_times_half_is_quotient_by_two`、ラベル **`real_times_half_is_quotient_by_two`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 1 行目 `a·(1/2) = a·(1·2^{-1})`（`def_real_quotient`（`y → 1, z → 2`）） | `calc` の 1 段目（`div_eq_mul_inv`） |
| 2 行目 `= a·2^{-1}`（乗法の単位元 `1·x = x`（`x → 2^{-1}`）） | 2 段目（`one_mul`） |
| 3 行目 `= a/2`（`def_real_quotient`（`y → a, z → 2`）を右辺から左辺へ） | 3 段目（`div_eq_mul_inv` を右辺から左辺へ） |

- 人手の商 `y/z := y z^{-1}`（`def_real_quotient`）は mathlib の `div_eq_mul_inv` で読む。
  順序体 `ℝ` の公理（`set_and_algebra_notation`）の段は mathlib の `one_mul` を 1 回引く。
- 人手の主張は `2 ≠ 0`（`real_two_is_nonzero`）を商が定まる条件として挙げるが、鎖のどの行も `2 ≠ 0` を使わない。
  Lean の `/` は `0` の除算も定めるので、この定理は `2 ≠ 0` を引数に取らない。
- mathlib の `mul_one_div` は使わない（人手の鎖をそのまま書くため）。

必要十分版は `Ising2D/NecSuf/MulOneDivEqDiv.lean`、具体版をその系として導くのは
`ClaimRealTimesHalfIsQuotientByTwoFromNecSuf.lean`。
-/
import Mathlib.Data.Real.Basic

namespace Ising2D

/-- **人手 `real_times_half_is_quotient_by_two`**: `ℝ` で `a·(1/2) = a/2`（人手の 3 行の鎖と 1 対 1 の `calc`）。 -/
theorem real_times_half_is_quotient_by_two (a : ℝ) : a * (1 / 2) = a / 2 :=
  calc a * (1 / 2)
      = a * (1 * 2⁻¹) := by
        rw [div_eq_mul_inv (1 : ℝ) 2]                          -- `def_real_quotient`（`y → 1, z → 2`）
    _ = a * 2⁻¹ := by
        rw [one_mul (2⁻¹ : ℝ)]                                 -- 乗法の単位元 `1·x = x`（`x → 2^{-1}`）
    _ = a / 2 := (div_eq_mul_inv a 2).symm                     -- `def_real_quotient`（`y → a, z → 2`）を右辺から左辺へ

end Ising2D
