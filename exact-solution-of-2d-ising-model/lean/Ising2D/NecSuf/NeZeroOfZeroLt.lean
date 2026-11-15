/-
# 0 より大きい元は 0 でない（**必要十分版**）

具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealTwoIsNonzero.lean`
（人手 `real_two_is_nonzero`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealTwoIsNonzeroFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| 1 行目（`0 < 2` と `<` の意味の後半） | `h0t` |
| 2 行目（等号の対称律の対偶） | `fun ht0 => h0t ht0.symm` |

## 何が効いているか / 効いていないか

- 効くのは、`0 < t` と、`<` の意味の後半 `x < y ⇒ x ≠ y` と、等号の対称律（Lean の `Eq.symm`）だけである。
- 型には元と `<` を持つだけの `Zero`・`LT` を置く。`<` の意味の前半 `x ≤ y` は使わないので `≤` を型に置かない。
  順序の推移律・全域性、加法、乗法は効いていない（`0 < 2` は具体版では主張 `real_zero_less_than_two` を
  引く段で、ここではその結論だけを仮定に置く）。
- `t` を数字 `2` に限らず任意の元で書くのは、`0 < t` 以外に `2` のどの性質も使わないことを示すため。
- 実数であること、体であること、完備性は効いていない。
-/
import Mathlib.Order.Basic

namespace Ising2D.NecSuf

/-- **`real_two_is_nonzero`** の必要十分版: `0 < t` と `x < y ⇒ x ≠ y` から `t ≠ 0`。 -/
theorem ne_zero_of_zero_lt {R : Type*} [Zero R] [LT R] {t : R}
    (hpos : (0 : R) < t)
    (hne : ∀ x y : R, x < y → x ≠ y) : t ≠ 0 := by
  have h0t : (0 : R) ≠ t := hne 0 t hpos                    -- 1 行目: `<` の意味の後半（`x → 0, y → t`）
  exact fun ht0 => h0t ht0.symm                             -- 2 行目: 等号の対称律（`x → t, y → 0`）の対偶

end Ising2D.NecSuf
