/-
# 実数の 0 は 1 より小さい（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_claim_real_zero_less_than_one`、ラベル **`real_zero_less_than_one`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 準備（体の公理 `0 ≠ 1`。等号の対称律の対偶（`x → 1, y → 0`）で `1 ≠ 0`） | `h01`・`h10` |
| 全順序（`x → 0, y → 1`）で `0 ≤ 1` か `1 ≤ 0` に分ける | `le_total 0 1` の場合分け |
| 第 1 の鎖（`0 ≤ 1` に準備の `0 ≠ 1` を添え、`def_real_strict_order`（`x → 0, y → 1`）を右辺から左辺へ当てて `0 < 1`。主張そのもの） | 第 1 の枝の `(real_lt_iff_le_and_ne 0 1).mpr ⟨h, h01⟩` |
| 第 2 の鎖（`1 ≤ 0` に準備の `1 ≠ 0` を添え、`def_real_strict_order`（`x → 1, y → 0`）を右辺から左辺へ当てて `1 < 0`） | 第 2 の枝の `hlt` |
| 第 3 の鎖（`0 = 1 + (−1)`（`def_real_difference` の加法の逆元を右辺から左辺へ）→ `< 0 + (−1)`（場合の仮定 `1 < 0` と `real_less_than_preserved_by_adding_on_right`）→ `= −1`（加法の単位元）） | 第 2 の枝の `hneg` の `calc` の 3 段 |
| 第 4 の鎖（`0 < (−1)·(−1)`（`real_product_of_positives_is_positive`（`a, b → −1`））→ `= 1·1`（`real_negation_times_negation_is_product`（`a, b → 1`））→ `= 1`（乗法の単位元）） | 第 2 の枝の `calc` の 3 段 |
| 結び（どちらの場合も `0 < 1`） | 2 つの枝がどちらも `0 < 1` を返すこと |

- 人手の全順序 `x ≤ y ∨ y ≤ x`（`set_and_algebra_notation`）は mathlib の `le_total` で読む。
- 人手の狭義の順序の定義 `def_real_strict_order` は具体版 `real_lt_iff_le_and_ne`（同じフォルダの `DefinitionRealStrictOrder.lean`）で読む。
- 人手の正の数どうしの積は正は本文の主張 `real_product_of_positives_is_positive`（同じフォルダの `ClaimRealProductOfPositivesIsPositive.lean`）で読む。
- 人手の狭義の順序と加法の両立 `x < y ⇒ x + c < y + c` は、順序体の公理ではなく本文の主張 `real_less_than_preserved_by_adding_on_right`（同じフォルダの `ClaimRealLessThanPreservedByAddingOnRight.lean`）で読む。
- 人手の `def_real_difference` の加法の逆元 `z + (−z) = 0` は `add_neg_cancel` で読む。
- mathlib の `zero_lt_one` は使わない（人手の鎖をそのまま書くため）。

必要十分版は `Ising2D/NecSuf/ZeroLtOneOfOrderedAxioms.lean`、具体版をその系として導くのは
`ClaimRealZeroLessThanOneFromNecSuf.lean`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealProductOfPositivesIsPositive
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.DefinitionRealStrictOrder
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealLessThanPreservedByAddingOnRight
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealNegationTimesNegationIsProduct

namespace Ising2D

/-- **人手 `real_zero_less_than_one`**: `ℝ` で `0 < 1`（全順序で `0 ≤ 1` か `1 ≤ 0` に分け、それぞれを
`def_real_strict_order` で `0 < 1`・`1 < 0` にし、`1 < 0` の場合を人手の 2 本の鎖と 1 対 1 の `calc` で `0 < 1` にする）。 -/
theorem real_zero_less_than_one : (0 : ℝ) < 1 := by
  have h01 : (0 : ℝ) ≠ 1 := zero_ne_one                      -- 体の公理 `0 ≠ 1`
  have h10 : (1 : ℝ) ≠ 0 := fun e => h01 e.symm             -- 準備: 等号の対称律（`x → 1, y → 0`）の対偶
  rcases le_total (0 : ℝ) 1 with h | h                       -- 全順序（`x → 0, y → 1`）で `0 ≤ 1` か `1 ≤ 0`
  · exact (real_lt_iff_le_and_ne 0 1).mpr ⟨h, h01⟩            -- 第 1 の鎖: `def_real_strict_order`（`x → 0, y → 1`）を右辺から左辺へ
  · have hlt : (1 : ℝ) < 0 := (real_lt_iff_le_and_ne 1 0).mpr ⟨h, h10⟩  -- 第 2 の鎖: `def_real_strict_order`（`x → 1, y → 0`）を右辺から左辺へ
    have hneg : (0 : ℝ) < -1 :=
      calc (0 : ℝ)
          = 1 + (-1) := (add_neg_cancel (1 : ℝ)).symm        -- `def_real_difference` の加法の逆元（`z → 1`）を右辺から左辺へ
        _ < 0 + (-1) := real_less_than_preserved_by_adding_on_right 1 0 (-1) hlt              -- 第 2 の鎖の結論 `1 < 0` と `real_less_than_preserved_by_adding_on_right`（`x → 1, y → 0, c → −1`）
        _ = -1 := zero_add (-1)                               -- 加法の単位元
    calc (0 : ℝ)
        < (-1) * (-1) := real_product_of_positives_is_positive (-1) (-1) hneg hneg  -- `real_product_of_positives_is_positive`（`a → −1, b → −1`）
      _ = 1 * 1 := real_negation_times_negation_is_product 1 1   -- `a → 1, b → 1`
      _ = 1 := mul_one 1                                      -- 乗法の単位元 `x·1 = x`（`x → 1`）

end Ising2D
