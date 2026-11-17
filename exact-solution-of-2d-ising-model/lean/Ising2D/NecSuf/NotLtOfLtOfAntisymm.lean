/-
# 狭義の順序の非対称律（**必要十分版**）

具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealLessThanIsAsymmetric.lean`
（人手 `real_less_than_is_asymmetric`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealLessThanIsAsymmetricFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `b < a` と仮定し、`a ≤ b`・`a ≠ b`・`b ≤ a` を読み出し、反対称律で `a = b`、`a ≠ b` に反する | `not_lt_of_lt_of_antisymm` の同じ段 |

## 何が効いているか / 効いていないか

- 効くのは、`<` の意味の一つの向き `x < y ⇒ x ≤ y`・`x < y ⇒ x ≠ y` と、`≤` の反対称律 `x ≤ y ⇒ y ≤ x ⇒ x = y` だけである。
- 型には関係を持つだけの `LE`・`LT` を置き、使う性質はすべて仮定に書く。
  `<` の意味の逆の向き（`x ≤ y ∧ x ≠ y ⇒ x < y`）、`≤` の反射律・推移律・全域性は効いていない。
  加法・乗法、実数であること、完備性も効いていない。
-/
import Mathlib.Order.Basic

namespace Ising2D.NecSuf

/-- **`real_less_than_is_asymmetric`** の必要十分版: `<` から `≤` と `≠` を読み出せて、`≤` が反対称なら、
`a < b` ならば `b < a` は成り立たない。 -/
theorem not_lt_of_lt_of_antisymm {R : Type*} [LE R] [LT R]
    (hlt_le : ∀ x y : R, x < y → x ≤ y)
    (hlt_ne : ∀ x y : R, x < y → x ≠ y)
    (hantisymm : ∀ x y : R, x ≤ y → y ≤ x → x = y)
    (a b : R) (hab : a < b) : ¬ b < a := by
  intro hba                                                  -- `b < a` と仮定する
  have hab_le : a ≤ b := hlt_le a b hab                      -- `a < b` の定義の前半
  have hab_ne : a ≠ b := hlt_ne a b hab                      -- `a < b` の定義の後半
  have hba_le : b ≤ a := hlt_le b a hba                      -- `b < a` の定義の前半
  have heq : a = b := hantisymm a b hab_le hba_le            -- 反対称律
  exact hab_ne heq                                           -- `a ≠ b` に反する

end Ising2D.NecSuf
