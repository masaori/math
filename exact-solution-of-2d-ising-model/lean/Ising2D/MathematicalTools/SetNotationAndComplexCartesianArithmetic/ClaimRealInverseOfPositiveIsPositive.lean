/-
# 正の実数の乗法の逆元は正（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_claim_real_inverse_of_positive_is_positive`、ラベル **`real_inverse_of_positive_is_positive`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 準備の 2 行 `0 < a ⇒ 0 ≠ a ⇒ a ≠ 0`（`<` の意味の後半、等号の対称律の対偶） | `ha0` |
| `a⁻¹` は `def_real_quotient` の `z⁻¹`（`z → a`）、`a` の乗法の逆元 `a·a⁻¹ = 1`（体の公理） | `hinv` |
| `a⁻¹ = 0` と仮定した鎖 `1 = a·a⁻¹ = a·0 = 0`（逆元を右辺から左辺へ、仮定、`real_times_zero_is_zero`（`x → a`））と、体の公理 `0 ≠ 1` との矛盾 | `hinv0` の `calc` の 3 段と `zero_ne_one` |
| `a⁻¹ ≠ 0 ⇒ 0 ≠ a⁻¹`（等号の対称律の対偶）。全順序で `0 < a⁻¹` か `a⁻¹ < 0`。`0 < a⁻¹` の場合は主張そのもの | `fun h => hinv0 h.symm` と `lt_or_gt_of_ne` の場合分けの第 1 の枝 |
| 第 1 の鎖 `0 = a⁻¹ + (−a⁻¹) < 0 + (−a⁻¹) = −a⁻¹` | 第 2 の枝の `h1` の `calc` の 3 段 |
| 第 2 の鎖 `0 < a·(−a⁻¹) = a·((−1)·a⁻¹) = (a·(−1))·a⁻¹ = ((−1)·a)·a⁻¹ = (−1)·(a·a⁻¹) = (−1)·1 = −1` | `h2` の `calc` の 7 段 |
| 第 3 の鎖 `1 = 0 + 1 < (−1) + 1 = 1 + (−1) = 0` | `h3` の `calc` の 4 段 |
| 結び `0 < 1 ∧ 1 < 0 ⇒ 0 < 0 ⇒ 0 ≠ 0`（`real_zero_less_than_one`、推移律、`<` の意味の後半）と反射律との矛盾 | `h00`（`lt_trans`）と `lt_iff_le_and_ne` の後半に `rfl` |

- 人手の順序体の公理は、mathlib の `ℝ` の全順序の場合分け（`lt_or_gt_of_ne`）、
  正の数どうしの積は正 `mul_pos`、推移律 `lt_trans` で読む。
  人手の狭義の順序と加法の両立 `x < y ⇒ x + c < y + c` は、順序体の公理ではなく本文の主張 `real_less_than_preserved_by_adding_on_right`（同じフォルダの `ClaimRealLessThanPreservedByAddingOnRight.lean`）で読む。
  `a` の乗法の逆元 `a·a⁻¹ = 1` は体の公理の具体版 `real_mul_inv_cancel`（`DefinitionRealQuotient.lean`）で読む。
- 人手の `<` の意味（`x ≤ y` かつ `x ≠ y`）は `lt_iff_le_and_ne` で読む。
- mathlib の `inv_pos`・`inv_pos_of_pos` は使わない（人手の鎖をそのまま書くため）。

必要十分版は `Ising2D/NecSuf/InvPosOfOrderedAxioms.lean`、具体版をその系として導くのは
`ClaimRealInverseOfPositiveIsPositiveFromNecSuf.lean`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealLessThanPreservedByAddingOnRight
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.DefinitionRealQuotient
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealMinusOneTimesIsNegation
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealTimesZeroIsZero
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealZeroLessThanOne

namespace Ising2D

/-- **人手 `real_inverse_of_positive_is_positive`**: `a ∈ ℝ`、`0 < a` について `0 < a⁻¹`
（`a⁻¹ ≠ 0` を示して `0 < a⁻¹` か `a⁻¹ < 0` に分け、`a⁻¹ < 0` の場合を人手の 3 本の鎖と推移律で矛盾にする）。 -/
theorem real_inverse_of_positive_is_positive (a : ℝ) (ha : 0 < a) : 0 < a⁻¹ := by
  have ha0 : a ≠ 0 := by
    have h0a : (0 : ℝ) ≠ a := (lt_iff_le_and_ne.mp ha).2      -- 準備 1 行目: `<` の意味の後半（`x → 0, y → a`）
    exact fun h => h0a h.symm                                -- 準備 2 行目: 等号の対称律（`x → a, y → 0`）の対偶
  have hinv : a * a⁻¹ = 1 := real_mul_inv_cancel a ha0      -- `a` の乗法の逆元（体の公理）
  have hinv0 : a⁻¹ ≠ 0 := by
    intro h
    have h10 : (1 : ℝ) = 0 :=
      calc (1 : ℝ)
          = a * a⁻¹ := hinv.symm                              -- 逆元 `a·a⁻¹ = 1` を右辺から左辺へ
        _ = a * 0 := by rw [h]                                -- 仮定 `a⁻¹ = 0`
        _ = 0 := real_times_zero_is_zero a                    -- `real_times_zero_is_zero`（`x → a`）
    exact zero_ne_one h10.symm                               -- 体の公理 `0 ≠ 1` に反する
  rcases lt_or_gt_of_ne (fun h => hinv0 h.symm) with h | h   -- 全順序と `0 ≠ a⁻¹` で `0 < a⁻¹` か `a⁻¹ < 0`
  · exact h                                                  -- `0 < a⁻¹` の場合は主張そのもの
  · exfalso
    have h1 : (0 : ℝ) < -a⁻¹ :=
      calc (0 : ℝ)
          = a⁻¹ + -a⁻¹ := (add_neg_cancel a⁻¹).symm           -- `def_real_difference` の加法の逆元（`z → a⁻¹`）を右辺から左辺へ
        _ < 0 + -a⁻¹ := real_less_than_preserved_by_adding_on_right a⁻¹ 0 (-a⁻¹) h              -- 場合の仮定と `real_less_than_preserved_by_adding_on_right`（`x → a⁻¹, y → 0, c → −a⁻¹`）
        _ = -a⁻¹ := zero_add (-a⁻¹)                           -- 加法の単位元
    have h2 : (0 : ℝ) < -1 :=
      calc (0 : ℝ)
          < a * -a⁻¹ := mul_pos ha h1                         -- 正の数どうしの積は正
        _ = a * ((-1) * a⁻¹) := by rw [real_minus_one_times_is_negation a⁻¹]  -- `a → a⁻¹` を右辺から左辺へ
        _ = (a * (-1)) * a⁻¹ := (mul_assoc a (-1) a⁻¹).symm   -- 乗法の結合律
        _ = ((-1) * a) * a⁻¹ := by rw [mul_comm a (-1)]       -- 乗法の可換律
        _ = (-1) * (a * a⁻¹) := mul_assoc (-1) a a⁻¹          -- 乗法の結合律
        _ = (-1) * 1 := by rw [hinv]                          -- 逆元 `a·a⁻¹ = 1`
        _ = -1 := real_minus_one_times_is_negation 1          -- `a → 1`
    have h3 : (1 : ℝ) < 0 :=
      calc (1 : ℝ)
          = 0 + 1 := (zero_add 1).symm                        -- 加法の単位元を右辺から左辺へ
        _ < -1 + 1 := real_less_than_preserved_by_adding_on_right 0 (-1) 1 h2                    -- `0 < −1` と `real_less_than_preserved_by_adding_on_right`（`x → 0, y → −1, c → 1`）
        _ = 1 + -1 := add_comm (-1) 1                         -- 加法の可換律
        _ = 0 := add_neg_cancel 1                             -- `def_real_difference` の加法の逆元（`z → 1`）
    have h00 : (0 : ℝ) < 0 := lt_trans real_zero_less_than_one h3  -- 推移律
    exact (lt_iff_le_and_ne.mp h00).2 rfl                    -- `<` の意味の後半で `0 ≠ 0`、反射律に反する

end Ising2D
