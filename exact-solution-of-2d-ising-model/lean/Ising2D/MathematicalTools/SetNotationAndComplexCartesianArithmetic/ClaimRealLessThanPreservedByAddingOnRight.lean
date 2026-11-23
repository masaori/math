/-
# 実数の狭義の順序は右から同じ数を足しても保たれる（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
（`calc_formulae_claim_real_less_than_preserved_by_adding_on_right`、ラベル **`real_less_than_preserved_by_adding_on_right`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `x < y` の定義（`def_real_strict_order`）から `x ≤ y` と `x ≠ y` | `(real_lt_iff_le_and_ne x y).1 h` の二つの成分 |
| 鎖 `x + c ≤ y + c`（`x ≤ y` と ℝ の順序と加法の両立 `x ≤ y ⇒ x + t ≤ y + t`、`t → c`） | `add_le_add_left hle c` |
| `x + c = y + c` と仮定した鎖 `x = x + 0 = x + (c + (−c)) = (x + c) + (−c) = (y + c) + (−c) = y + (c + (−c)) = y + 0 = y` | `hne` の `calc` の 7 段 |
| `x ≠ y` に反する | `hxy heq` |
| `x + c ≤ y + c` と `x + c ≠ y + c` から `def_real_strict_order` で `x + c < y + c` | `(real_lt_iff_le_and_ne (x + c) (y + c)).2 ⟨hle', hne⟩` |

- 人手の順序体の公理の「順序と加法の両立」（`≤` について）は mathlib の `add_le_add_left`（`b ≤ c ⇒ b + a ≤ c + a`）で読む。
- 加法の単位元・結合律は `add_zero`・`add_assoc`、`def_real_difference` の加法の逆元は `add_neg_cancel` で読む。
- mathlib の `add_lt_add_left`・`add_lt_add_right` は使わない（人手の論法をそのまま書くため）。

必要十分版は `Ising2D/NecSuf/AddLtAddRightOfLeCompat.lean`、具体版をその系として導くのは
`ClaimRealLessThanPreservedByAddingOnRightFromNecSuf.lean`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.DefinitionRealStrictOrder

namespace Ising2D

/-- **人手 `real_less_than_preserved_by_adding_on_right`**: `x, y, c ∈ ℝ` について `x < y` ならば `x + c < y + c`
（人手の論法: `x ≤ y` から `x + c ≤ y + c`、`x + c = y + c` と仮定すると鎖で `x = y` となり `x ≠ y` に反する）。 -/
theorem real_less_than_preserved_by_adding_on_right (x y c : ℝ) (h : x < y) : x + c < y + c := by
  have hle : x ≤ y := ((real_lt_iff_le_and_ne x y).1 h).1        -- `x < y` の定義（`def_real_strict_order`）の前半
  have hxy : x ≠ y := ((real_lt_iff_le_and_ne x y).1 h).2        -- `x < y` の定義の後半
  have hle' : x + c ≤ y + c := add_le_add_left hle c              -- ℝ の順序と加法の両立（`t → c`）
  have hne : x + c ≠ y + c := by
    intro hsum                                                    -- `x + c = y + c` と仮定する
    have heq : x = y :=
      calc x
          = x + 0 := (add_zero x).symm                            -- 加法の単位元（`x → x`）を右辺から左辺へ
        _ = x + (c + -c) := by rw [add_neg_cancel c]              -- `def_real_difference` の加法の逆元（`z → c`）を右辺から左辺へ
        _ = (x + c) + -c := (add_assoc x c (-c)).symm             -- 加法の結合律（`x → x, y → c, t → −c`）を右辺から左辺へ
        _ = (y + c) + -c := by rw [hsum]                          -- 仮定 `x + c = y + c`
        _ = y + (c + -c) := add_assoc y c (-c)                    -- 加法の結合律（`x → y, y → c, t → −c`）
        _ = y + 0 := by rw [add_neg_cancel c]                     -- `def_real_difference` の加法の逆元（`z → c`）
        _ = y := add_zero y                                       -- 加法の単位元（`x → y`）
    exact hxy heq                                                 -- `x ≠ y` に反する
  exact (real_lt_iff_le_and_ne (x + c) (y + c)).2 ⟨hle', hne⟩    -- `def_real_strict_order`

end Ising2D
