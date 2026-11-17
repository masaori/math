/-
# 実数の狭義の順序は非対称（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_claim_real_less_than_is_asymmetric`、ラベル **`real_less_than_is_asymmetric`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `b < a` と仮定する | `intro hba` |
| `a < b` の定義から `a ≤ b` と `a ≠ b`、`b < a` の定義から `b ≤ a` | `hab.le`・`hab.ne`・`hba.le`（`<` の意味 `x < y ⟺ x ≤ y ∧ x ≠ y` は mathlib の `lt_iff_le_and_ne` で、その 2 つの向きの読み出し） |
| 鎖の 1 行 `a = b`（`a ≤ b` と `b ≤ a` に ℝ の順序の反対称律） | `le_antisymm hab_le hba_le` |
| `a ≠ b` に反する | `hab_ne heq` |

- mathlib の `lt_asymm`・`not_lt_of_gt` は使わない（人手の論法をそのまま書くため）。

必要十分版は `Ising2D/NecSuf/NotLtOfLtOfAntisymm.lean`、具体版をその系として導くのは
`ClaimRealLessThanIsAsymmetricFromNecSuf.lean`。
-/
import Mathlib.Data.Real.Basic

namespace Ising2D

/-- **人手 `real_less_than_is_asymmetric`**: `a, b ∈ ℝ` について `a < b` ならば `b < a` は成り立たない
（人手の論法: `b < a` と仮定すると `a ≤ b`・`a ≠ b`・`b ≤ a`、反対称律で `a = b` となり `a ≠ b` に反する）。 -/
theorem real_less_than_is_asymmetric (a b : ℝ) (hab : a < b) : ¬ b < a := by
  intro hba                                                  -- `b < a` と仮定する
  have hab_le : a ≤ b := hab.le                              -- `a < b` の定義の前半
  have hab_ne : a ≠ b := hab.ne                              -- `a < b` の定義の後半
  have hba_le : b ≤ a := hba.le                              -- `b < a` の定義の前半
  have heq : a = b := le_antisymm hab_le hba_le              -- ℝ の順序の反対称律
  exact hab_ne heq                                           -- `a ≠ b` に反する

end Ising2D
