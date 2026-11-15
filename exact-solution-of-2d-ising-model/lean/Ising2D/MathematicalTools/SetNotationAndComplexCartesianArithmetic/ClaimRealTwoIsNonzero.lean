/-
# 実数の 2 は 0 でない（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_claim_real_two_is_nonzero`、ラベル **`real_two_is_nonzero`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 1 行目 `0 < 2 ⇒ 0 ≠ 2`（`real_zero_less_than_two` と、`x < y` は `x ≤ y` かつ `x ≠ y` のことの後半（`x → 0, y → 2`）） | `h02` |
| 2 行目 `0 ≠ 2 ⇒ 2 ≠ 0`（等号の対称律 `x = y ⇒ y = x`（`x → 2, y → 0`）の対偶） | `fun h20 => h02 h20.symm` |

- 人手の `<` の意味（`x ≤ y` かつ `x ≠ y`）は、mathlib の `lt_iff_le_and_ne` で読む。
- 人手の `def_real_two`（`2 := 1 + 1`）は、`real_zero_less_than_two` の中で mathlib の `one_add_one_eq_two` で読んでいる。
- mathlib の `two_ne_zero`・`ne_of_gt` は使わない（人手の 2 行をそのまま書くため）。

必要十分版は `Ising2D/NecSuf/NeZeroOfZeroLt.lean`、具体版をその系として導くのは
`ClaimRealTwoIsNonzeroFromNecSuf.lean`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealZeroLessThanTwo

namespace Ising2D

/-- **人手 `real_two_is_nonzero`**: `ℝ` で `2 ≠ 0`（`real_zero_less_than_two` の `0 < 2` から
`<` の意味の後半で `0 ≠ 2`、等号の対称律の対偶で `2 ≠ 0`）。 -/
theorem real_two_is_nonzero : (2 : ℝ) ≠ 0 := by
  have h02 : (0 : ℝ) ≠ 2 :=
    (lt_iff_le_and_ne.mp real_zero_less_than_two).2        -- 1 行目: `<` の意味の後半（`x → 0, y → 2`）
  exact fun h20 => h02 h20.symm                            -- 2 行目: 等号の対称律（`x → 2, y → 0`）の対偶

end Ising2D
