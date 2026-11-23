/-
# 整数の 0 は 1 以下（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
（`calc_formulae_claim_integer_zero_at_most_one`、ラベル **`int_zero_at_most_one`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| ℤ の全順序 `0 ≤ 1 ∨ 1 ≤ 0` で分ける。`0 ≤ 1` のときは主張そのもの | `rcases le_total 0 1` の一つ目の枝 |
| `1 ≤ 0` のときの鎖 `0 = 1 + (−1) ≤ 0 + (−1) = −1` | `hneg_one` の `calc` の 3 段 |
| 順序と乗法の両立（`x, y → −1`）で `0 ≤ (−1)·(−1)` | `hsq` |
| 鎖 `0 ≤ (−1)(−1) = −(1·(−1)) = −(−1) = −(−1) + 0 = −(−1) + ((−1) + 1) = (−(−1) + (−1)) + 1 = 0 + 1 = 1` | `calc` の 8 段 |

- `set_and_algebra_notation` の ℤ の行のうち、全順序は `le_total`、加法の逆元は `add_neg_cancel`・`neg_add_cancel`、
  順序と加法の両立 `x ≤ y ⇒ x + t ≤ y + t` は `add_le_add_left`（この mathlib では `b ≤ c ⇒ b + a ≤ c + a`）、
  和の単位元は `zero_add`・`add_zero`、乗法の単位元 `1·y = y` は `one_mul`、加法の結合律は `add_assoc`、
  順序と乗法の両立 `(0 ≤ x ∧ 0 ≤ y) ⇒ 0 ≤ x·y` は `mul_nonneg` で読む。
- mathlib の `zero_le_one`・`Int.zero_le_one`・`neg_neg`・`neg_mul_neg` は使わない（人手の論法をそのまま書くため）。

必要十分版は `Ising2D/NecSuf/ZeroLeOneOfCases.lean`、具体版をその系として導くのは
`ClaimIntegerZeroAtMostOneFromNecSuf.lean`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimIntegerNegationTimesIsNegationOfProduct
import Mathlib.Algebra.Order.Ring.Int

namespace Ising2D

/-- **人手 `int_zero_at_most_one`**: `0_ℤ ≤ 1_ℤ`
（人手の論法: 全順序で分け、`1 ≤ 0` の側では `0 ≤ (−1)·(−1) = 1`）。 -/
theorem int_zero_at_most_one : (0 : ℤ) ≤ 1 := by
  rcases le_total (0 : ℤ) 1 with h | h                                       -- ℤ の全順序（`x → 0, y → 1`）
  · exact h                                                                  -- `0 ≤ 1` のときは主張そのもの
  · have hneg_one : (0 : ℤ) ≤ -1 :=
      calc (0 : ℤ)
          = 1 + -1 := (add_neg_cancel (1 : ℤ)).symm                          -- ℤ の加法の逆元（`y → 1`）を右辺から左辺へ
        _ ≤ 0 + -1 := add_le_add_left h (-1)                                 -- `1 ≤ 0` に ℤ の順序と加法の両立（`t → −1`）
        _ = -1 := zero_add (-1)                                              -- ℤ の和の単位元 `0 + y = y`（`y → −1`）
    have hsq : (0 : ℤ) ≤ (-1) * (-1) := mul_nonneg hneg_one hneg_one          -- ℤ の順序と乗法の両立（`x, y → −1`）
    calc (0 : ℤ)
        ≤ (-1) * (-1) := hsq                                                 -- 上の `0 ≤ (−1)·(−1)`
      _ = -(1 * (-1)) := int_negation_times_is_negation_of_product 1 (-1)    -- `int_negation_times_is_negation_of_product`（`x → 1, t → −1`）
      _ = -(-1) := by rw [one_mul (-1 : ℤ)]                                  -- ℤ の乗法の単位元 `1·y = y`（`y → −1`）
      _ = -(-1) + 0 := (add_zero (-(-1) : ℤ)).symm                           -- ℤ の和の単位元（`y → −(−1)`）を右辺から左辺へ
      _ = -(-1) + ((-1) + 1) := by rw [neg_add_cancel (1 : ℤ)]               -- ℤ の加法の逆元 `(−y)+y = 0`（`y → 1`）を右辺から左辺へ
      _ = (-(-1) + (-1)) + 1 := (add_assoc (-(-1) : ℤ) (-1) 1).symm          -- ℤ の加法の結合律を右辺から左辺へ
      _ = 0 + 1 := by rw [neg_add_cancel (-1 : ℤ)]                           -- ℤ の加法の逆元 `(−y)+y = 0`（`y → −1`）
      _ = 1 := zero_add 1                                                    -- ℤ の和の単位元 `0 + y = y`（`y → 1`）

end Ising2D
