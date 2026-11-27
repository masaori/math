/-
# 正の実数どうしの積は正（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_claim_real_product_of_positives_is_positive`、ラベル **`real_product_of_positives_is_positive`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 準備 `0 < a ⇒ 0 ≤ a ∧ 0 ≠ a ⇒ 0 ≤ a ∧ a ≠ 0`（`def_real_strict_order`、等号の対称律の対偶） | `ha'`・`ha0` |
| 準備 `0 < b ⇒ 0 ≤ b ∧ 0 ≠ b ⇒ 0 ≤ b ∧ b ≠ 0`（同じ） | `hb'`・`hb0` |
| `0 ≤ a ∧ 0 ≤ b ⇒ 0 ≤ a·b`（順序と乗法の両立、`x → a, y → b`） | `hle`（`mul_nonneg`） |
| `a ≠ 0 ∧ b ≠ 0 ⇒ a·b ≠ 0 ⇒ 0 ≠ a·b`（`real_product_of_nonzero_is_nonzero`、等号の対称律の対偶） | `hne` |
| `0 ≤ a·b ∧ 0 ≠ a·b ⇒ 0 < a·b`（`def_real_strict_order` を右辺から左辺へ） | `real_lt_iff_le_and_ne` の `mpr` |

- 人手の順序と乗法の両立 `(0 ≤ x ∧ 0 ≤ y) ⇒ 0 ≤ x·y`（`set_and_algebra_notation` が外から持ち込む ℝ の順序の条件）は `mul_nonneg` で読む。
- mathlib の `mul_pos` は使わない（人手の 3 本の鎖をそのまま書くため）。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealProductOfNonzeroIsNonzero
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.DefinitionRealStrictOrder

namespace Ising2D

/-- **人手 `real_product_of_positives_is_positive`**: `a, b ∈ ℝ`、`0 < a`、`0 < b` について `0 < a·b`
（`≤` の乗法との両立で `0 ≤ a·b`、`real_product_of_nonzero_is_nonzero` で `a·b ≠ 0` を出し、`def_real_strict_order` で合わせる）。 -/
theorem real_product_of_positives_is_positive (a b : ℝ) (ha : 0 < a) (hb : 0 < b) : 0 < a * b := by
  have ha' : 0 ≤ a ∧ (0 : ℝ) ≠ a := (real_lt_iff_le_and_ne 0 a).mp ha      -- 準備: `def_real_strict_order`（`x → 0, y → a`）
  have ha0 : a ≠ 0 := fun h => ha'.2 h.symm                                 -- 準備: 等号の対称律（`x → a, y → 0`）の対偶
  have hb' : 0 ≤ b ∧ (0 : ℝ) ≠ b := (real_lt_iff_le_and_ne 0 b).mp hb      -- 準備: `def_real_strict_order`（`x → 0, y → b`）
  have hb0 : b ≠ 0 := fun h => hb'.2 h.symm                                 -- 準備: 等号の対称律（`x → b, y → 0`）の対偶
  have hle : 0 ≤ a * b := mul_nonneg ha'.1 hb'.1                            -- 順序と乗法の両立（`x → a, y → b`）
  have hne : (0 : ℝ) ≠ a * b := by
    have hab : a * b ≠ 0 := real_product_of_nonzero_is_nonzero a b ha0 hb0  -- `real_product_of_nonzero_is_nonzero`（`a → a, b → b`）
    exact fun h => hab h.symm                                               -- 等号の対称律（`x → 0, y → a·b`）の対偶
  exact (real_lt_iff_le_and_ne 0 (a * b)).mpr ⟨hle, hne⟩                    -- `def_real_strict_order`（`x → 0, y → a·b`）を右辺から左辺へ

end Ising2D
