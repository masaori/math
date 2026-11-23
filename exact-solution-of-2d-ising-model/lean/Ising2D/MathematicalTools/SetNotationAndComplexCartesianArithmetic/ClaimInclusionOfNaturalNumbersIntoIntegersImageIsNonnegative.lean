/-
# ℕ から ℤ への包含写像の像は 0 以上（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
（`calc_formulae_claim_inclusion_nn_to_zz_image_is_nonnegative`、ラベル **`inclusion_nn_to_zz_image_is_nonnegative`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| ℕ の数学的帰納法（`φ(n) :⇔ 0_ℤ ≤ ι(n)`） | `induction n` |
| `n = 0_ℕ` の鎖 `0_ℤ ≤ 0_ℤ = ι(0_ℕ)` | `zero` の枝の `calc` の 2 段 |
| `n + 1_ℕ` の鎖 `0 = 0 + 0 ≤ 1 + 0 = 0 + 1 ≤ ι(n) + 1 = ι(n + 1_ℕ)` | `succ` の枝の `calc` の 5 段 |

- `set_and_algebra_notation` の ℤ の行のうち、順序の反射律は `le_refl`、和の単位元 `0 + x = x` は `zero_add`、
  加法の交換律は `add_comm`、順序と加法の両立 `x ≤ y ⇒ x + t ≤ y + t` は `add_le_add_left`（この mathlib では `b ≤ c ⇒ b + a ≤ c + a`）で読む。
  `≤` と `=` の連なりを推移律でつなぐのは `calc` である。
- mathlib の `Int.natCast_nonneg`・`Nat.cast_nonneg`・`zero_le_one` は使わない（人手の論法をそのまま書くため）。

必要十分版は `Ising2D/NecSuf/ZeroLeOfRecAddOne.lean`、具体版をその系として導くのは
`ClaimInclusionOfNaturalNumbersIntoIntegersImageIsNonnegativeFromNecSuf.lean`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.DefinitionInclusionOfNaturalNumbersIntoIntegers
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimIntegerZeroAtMostOne

namespace Ising2D

/-- **人手 `inclusion_nn_to_zz_image_is_nonnegative`**: すべての `n ∈ ℕ` で `0_ℤ ≤ ι_{ℕ→ℤ}(n)`
（人手の論法: ℕ の数学的帰納法。`n + 1` の段は `int_zero_at_most_one` と順序と加法の両立）。 -/
theorem inclusion_nn_to_zz_image_is_nonnegative (n : ℕ) : (0 : ℤ) ≤ inclusionNNtoZZ n := by
  induction n with
  | zero =>
    calc (0 : ℤ)
        ≤ 0 := le_refl 0                                                   -- ℤ の順序の反射律（`x → 0_ℤ`）
      _ = inclusionNNtoZZ 0 := rfl                                         -- `inclusion_nn_to_zz` の `ι(0_ℕ) := 0_ℤ` を右辺から左辺へ
  | succ n ih =>
    calc (0 : ℤ)
        = 0 + 0 := (zero_add (0 : ℤ)).symm                                 -- ℤ の和の単位元 `0 + x = x`（`x → 0_ℤ`）を右辺から左辺へ
      _ ≤ 1 + 0 := add_le_add_left int_zero_at_most_one 0                  -- `int_zero_at_most_one` に順序と加法の両立（`t → 0_ℤ`）
      _ = 0 + 1 := add_comm 1 0                                            -- ℤ の加法の交換律（`x → 1_ℤ, y → 0_ℤ`）
      _ ≤ inclusionNNtoZZ n + 1 := add_le_add_left ih 1                    -- 帰納法の仮定に順序と加法の両立（`t → 1_ℤ`）
      _ = inclusionNNtoZZ (n + 1) := rfl                                   -- `inclusion_nn_to_zz` の `ι(n + 1_ℕ) := ι(n) + 1_ℤ` を右辺から左辺へ

end Ising2D
