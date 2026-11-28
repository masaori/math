/-
# 実数の二乗は 0 以上（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
（`calc_formulae_claim_real_square_is_nonnegative`、ラベル **`real_square_is_nonnegative`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `0 ≤ r` の場合の鎖 `0 ≤ r r = r^2`（順序と乗法の両立、`square_of_real_number_is_product` を右辺から左辺へ） | `hr` の場合の `calc` の 2 段 |
| `¬(0 ≤ r)` の場合、ℝ の全順序 `0 ≤ r ∨ r ≤ 0` の左が成り立たないので `r ≤ 0` | `(le_total 0 r).resolve_left hr` |
| 鎖 `0 = r + (−r) ≤ 0 + (−r) = −r` | `hneg` の `calc` の 3 段 |
| 鎖 `0 ≤ (−r)(−r) = r r = r^2` | `¬hr` の場合の `calc` の 3 段 |

- `set_and_algebra_notation` の ℝ の行のうち、加法の逆元は `add_neg_cancel`、順序と加法の両立 `x ≤ y ⇒ x + t ≤ y + t` は
  `add_le_add_left`（この mathlib では `b ≤ c ⇒ b + a ≤ c + a`）、加法の単位元 `0 + x = x` は `zero_add`、全順序は `le_total`、
  順序と乗法の両立は `mul_nonneg` で読む。mathlib の `sq_nonneg`・`mul_self_nonneg` は使わない（人手の論法をそのまま書くため）。

必要十分版は `Ising2D/NecSuf/SqNonnegOfCases.lean`、具体版をその系として導くのは
`ClaimRealSquareIsNonnegativeFromNecSuf.lean`。
-/
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimSquareOfRealNumberIsProduct
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealNegationTimesNegationIsProduct

namespace Ising2D

/-- **人手 `real_square_is_nonnegative`**: `r ∈ ℝ` について `0 ≤ r^2`
（人手の論法: `0 ≤ r` なら順序と乗法の両立、そうでなければ全順序で `r ≤ 0` とし、両辺に `−r` を足して `0 ≤ −r` から同じく）。 -/
theorem real_square_is_nonnegative (r : ℝ) : 0 ≤ r ^ 2 := by
  by_cases hr : 0 ≤ r
  · calc (0 : ℝ)
        ≤ r * r := mul_nonneg hr hr                                     -- 場合の仮定に ℝ の順序と乗法の両立（`x → r, y → r`）
      _ = r ^ 2 := (square_of_real_number_is_product r).symm            -- `square_of_real_number_is_product`（`r → r`）を右辺から左辺へ
  · have hr0 : r ≤ 0 := (le_total 0 r).resolve_left hr                  -- ℝ の全順序（`x → 0, y → r`）の左が成り立たない
    have hneg : 0 ≤ -r :=
      calc (0 : ℝ)
          = r + -r := (add_neg_cancel r).symm                           -- ℝ の加法の逆元（`x → r`）を右辺から左辺へ
        _ ≤ 0 + -r := add_le_add_left hr0 (-r)                          -- ℝ の順序と加法の両立（`x → r, y → 0, t → −r`）
        _ = -r := zero_add (-r)                                         -- ℝ の加法の単位元 `0 + x = x`（`x → −r`）
    calc (0 : ℝ)
        ≤ (-r) * (-r) := mul_nonneg hneg hneg                           -- ℝ の順序と乗法の両立（`x → −r, y → −r`）
      _ = r * r := real_negation_times_negation_is_product r r          -- `real_negation_times_negation_is_product`（`a → r, b → r`）
      _ = r ^ 2 := (square_of_real_number_is_product r).symm            -- `square_of_real_number_is_product`（`r → r`）を右辺から左辺へ

end Ising2D
