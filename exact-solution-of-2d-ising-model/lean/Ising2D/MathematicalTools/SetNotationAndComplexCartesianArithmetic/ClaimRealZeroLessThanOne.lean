/-
# 実数の 0 は 1 より小さい（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_claim_real_zero_less_than_one`、ラベル **`real_zero_less_than_one`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 準備（体の公理 `0 ≠ 1`。全順序なので `0 < 1` か `1 < 0`。`0 < 1` の場合は主張そのもの） | `h01`・`lt_or_gt_of_ne h01` の場合分けの第 1 の枝 |
| 第 1 の鎖（`0 = 1 + (−1)`（`def_real_difference` の加法の逆元を右辺から左辺へ）→ `< 0 + (−1)`（場合の仮定 `1 < 0` と `real_less_than_preserved_by_adding_on_right`）→ `= −1`（加法の単位元）） | 第 2 の枝の `hneg` の `calc` の 3 段 |
| 第 2 の鎖（`0 < (−1)·(−1)`（正の数どうしの積は正）→ `= 1·1`（`real_negation_times_negation_is_product`（`a, b → 1`））→ `= 1`（乗法の単位元）） | 第 2 の枝の `calc` の 3 段 |
| 結び（どちらの場合も `0 < 1`） | 2 つの枝がどちらも `0 < 1` を返すこと |

- 人手の順序体の公理は、mathlib の `ℝ` の全順序の場合分け（`lt_or_gt_of_ne`）、
  正の数どうしの積は正 `mul_pos` で読む。
- 人手の狭義の順序と加法の両立 `x < y ⇒ x + c < y + c` は、順序体の公理ではなく本文の主張 `real_less_than_preserved_by_adding_on_right`（同じフォルダの `ClaimRealLessThanPreservedByAddingOnRight.lean`）で読む。
- 人手の `def_real_difference` の加法の逆元 `z + (−z) = 0` は `add_neg_cancel` で読む。
- mathlib の `zero_lt_one` は使わない（人手の鎖をそのまま書くため）。

必要十分版は `Ising2D/NecSuf/ZeroLtOneOfOrderedAxioms.lean`、具体版をその系として導くのは
`ClaimRealZeroLessThanOneFromNecSuf.lean`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealLessThanPreservedByAddingOnRight
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealNegationTimesNegationIsProduct

namespace Ising2D

/-- **人手 `real_zero_less_than_one`**: `ℝ` で `0 < 1`（`0 < 1` か `1 < 0` で場合を分け、`1 < 0` の場合を
人手の 2 本の鎖と 1 対 1 の `calc` で `0 < 1` にする）。 -/
theorem real_zero_less_than_one : (0 : ℝ) < 1 := by
  have h01 : (0 : ℝ) ≠ 1 := zero_ne_one                      -- 体の公理 `0 ≠ 1`
  rcases lt_or_gt_of_ne h01 with h | h                       -- 全順序なので `0 < 1` か `1 < 0`
  · exact h                                                  -- `0 < 1` の場合は主張そのもの
  · have hneg : (0 : ℝ) < -1 :=
      calc (0 : ℝ)
          = 1 + (-1) := (add_neg_cancel (1 : ℝ)).symm        -- `def_real_difference` の加法の逆元（`z → 1`）を右辺から左辺へ
        _ < 0 + (-1) := real_less_than_preserved_by_adding_on_right 1 0 (-1) h                -- 場合の仮定 `1 < 0` と `real_less_than_preserved_by_adding_on_right`（`x → 1, y → 0, c → −1`）
        _ = -1 := zero_add (-1)                               -- 加法の単位元
    calc (0 : ℝ)
        < (-1) * (-1) := mul_pos hneg hneg                    -- 正の数どうしの積は正
      _ = 1 * 1 := real_negation_times_negation_is_product 1 1   -- `a → 1, b → 1`
      _ = 1 := one_mul 1                                      -- 乗法の単位元

end Ising2D
