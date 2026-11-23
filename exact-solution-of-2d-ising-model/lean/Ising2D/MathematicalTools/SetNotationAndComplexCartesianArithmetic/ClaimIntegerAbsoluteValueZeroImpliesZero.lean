/-
# 絶対値が 0 の整数は 0（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
（`calc_formulae_claim_integer_absolute_value_zero_implies_zero`、ラベル **`int_absolute_value_zero_implies_zero`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `0_ℤ ≤ x` の場合の鎖 `x = |x| = 0`（`def_int_absolute_value` の `0 ≤ x` の場合の式を右辺から左辺へ、主張の仮定） | `hx` の場合の `calc` の 2 段 |
| `¬(0_ℤ ≤ x)` の場合の準備 `−x = |x| = 0`（`¬(0 ≤ x)` の場合の式を右辺から左辺へ、主張の仮定） | `hneg` の `calc` の 2 段 |
| 鎖 `x = x + 0 = x + (−x) = 0` | `¬hx` の場合の `calc` の 3 段 |

- `set_and_algebra_notation` の ℤ の行のうち、和の単位元 `x + 0 = x` は `add_zero`、加法の逆元は `add_neg_cancel` で読む。
- `def_int_absolute_value` の二つの式は `int_abs_of_nonneg_and_of_not_nonneg` で読む。mathlib の `abs_eq_zero` は使わない（人手の論法をそのまま書くため）。

必要十分版は `Ising2D/NecSuf/EqZeroOfAbsCasesEqZero.lean`、具体版をその系として導くのは
`ClaimIntegerAbsoluteValueZeroImpliesZeroFromNecSuf.lean`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.DefinitionIntegerAbsoluteValue

namespace Ising2D

/-- **人手 `int_absolute_value_zero_implies_zero`**: `x ∈ ℤ` について `|x| = 0` なら `x = 0`
（人手の論法: `0 ≤ x` なら `x = |x|`、そうでなければ `−x = |x| = 0` を使って `x = x + 0 = x + (−x) = 0`）。 -/
theorem int_absolute_value_zero_implies_zero (x : ℤ) (h : |x| = 0) : x = 0 := by
  by_cases hx : 0 ≤ x
  · calc x
        = |x| := ((int_abs_of_nonneg_and_of_not_nonneg x).1 hx).symm   -- `def_int_absolute_value` の `0 ≤ x` の場合の式を右辺から左辺へ
      _ = 0 := h                                                       -- 主張の仮定 `|x| = 0`
  · have hneg : -x = 0 :=
      calc -x
          = |x| := ((int_abs_of_nonneg_and_of_not_nonneg x).2 hx).symm -- `def_int_absolute_value` の `¬(0 ≤ x)` の場合の式を右辺から左辺へ
        _ = 0 := h                                                     -- 主張の仮定 `|x| = 0`
    calc x
        = x + 0 := (add_zero x).symm                                   -- ℤ の和の単位元 `x + 0 = x`（`x → x`）を右辺から左辺へ
      _ = x + -x := by rw [hneg]                                       -- 上の `−x = 0` を右辺から左辺へ
      _ = 0 := add_neg_cancel x                                        -- ℤ の加法の逆元（`x → x`）

end Ising2D
