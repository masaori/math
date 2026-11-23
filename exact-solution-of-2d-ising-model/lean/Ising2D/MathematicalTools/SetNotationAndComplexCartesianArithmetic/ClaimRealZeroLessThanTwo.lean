/-
# 実数の 0 は 2 より小さい（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_claim_real_zero_less_than_two`、ラベル **`real_zero_less_than_two`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 準備の鎖（`1 = 0 + 1`（加法の単位元を右辺から左辺へ）→ `< 1 + 1`（`real_zero_less_than_one` と `real_less_than_preserved_by_adding_on_right`（`x → 0, y → 1, c → 1`））→ `= 2`（`def_real_two` を右辺から左辺へ）） | `h12` の `calc` の 3 段 |
| 本体（`0 < 1` と `1 < 2` に順序の推移律） | `lt_trans real_zero_less_than_one h12` |

- 人手の `def_real_two`（`2 := 1 + 1`）は、mathlib の `ℝ` の数字 `2` を具体版 `real_two_eq_one_add_one`（`2 = 1 + 1`）で読む。
- 人手の順序体の公理の順序の推移律は `lt_trans` で読む。
- 人手の狭義の順序と加法の両立 `x < y ⇒ x + c < y + c` は、順序体の公理ではなく本文の主張 `real_less_than_preserved_by_adding_on_right`（同じフォルダの `ClaimRealLessThanPreservedByAddingOnRight.lean`）で読む。
- mathlib の `zero_lt_two`・`two_pos` は使わない（人手の鎖をそのまま書くため）。

必要十分版は `Ising2D/NecSuf/ZeroLtTwoOfOrderedAxioms.lean`、具体版をその系として導くのは
`ClaimRealZeroLessThanTwoFromNecSuf.lean`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealLessThanPreservedByAddingOnRight
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.DefinitionRealTwo
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealZeroLessThanOne

namespace Ising2D

/-- **人手 `real_zero_less_than_two`**: `ℝ` で `0 < 2`（準備の鎖で `1 < 2` を示し、
`real_zero_less_than_one` と順序の推移律でつなぐ）。 -/
theorem real_zero_less_than_two : (0 : ℝ) < 2 := by
  have h12 : (1 : ℝ) < 2 :=
    calc (1 : ℝ)
        = 0 + 1 := (zero_add (1 : ℝ)).symm                          -- 加法の単位元を右辺から左辺へ
      _ < 1 + 1 := real_less_than_preserved_by_adding_on_right 0 1 1 real_zero_less_than_one          -- `0 < 1` と `real_less_than_preserved_by_adding_on_right`（`x → 0, y → 1, c → 1`）
      _ = 2 := real_two_eq_one_add_one.symm                                     -- `def_real_two` を右辺から左辺へ
  exact lt_trans real_zero_less_than_one h12                          -- 本体: 順序の推移律

end Ising2D
