/-
# 場合分けで定めた絶対値は 0 以上（**必要十分版**）

具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimIntegerAbsoluteValueIsNonnegative.lean`
（人手 `int_absolute_value_is_nonnegative`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimIntegerAbsoluteValueIsNonnegativeFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `0 ≤ x` の場合の 2 段 | 同じ 2 段（`habs_pos`） |
| 全順序から `x ≤ 0` | `htotal` |
| `¬(0 ≤ x)` の場合の 4 段 | 同じ 4 段（`hadd_neg`・`hle_add`・`hzero_add`・`habs_neg`） |

## 何が効いているか / 効いていないか

- 効くのは、絶対値 `a` が場合分けの二つの式 `0 ≤ x ⇒ a x = x`・`¬(0 ≤ x) ⇒ a x = −x` を満たすこと、`≤` の全順序の `0` と `x` の組
  `0 ≤ x ∨ x ≤ 0`、加法の逆元 `x + (−x) = 0`、`≤` と加法の両立の `y = 0` の形 `x ≤ 0 ⇒ x + t ≤ 0 + t`、左からの加法の単位元 `0 + x = x` の 5 つだけである。
- 型には演算と元を持つだけの `Zero`・`Add`・`Neg` と、関係を持つだけの `LE` を置き、使う性質はすべて仮定に書く。
  `≤` の反射律・推移律・反対称律は効いていない（順序であることも要らない）。全順序と加法の両立は、具体版が使う組の形だけを仮定に置いた。
- 加法の結合律・可換律、右からの単位元、乗法、整数であること（離散性・帰納法）は効いていない。
-/
import Mathlib.Order.Basic

namespace Ising2D.NecSuf

/-- **`int_absolute_value_is_nonnegative`** の必要十分版: 場合分けの二つの式を満たす `a`、全順序、加法の逆元、
`≤` と加法の両立、左からの加法の単位元から `0 ≤ a x`。 -/
theorem abs_nonneg_of_cases {R : Type*} [Zero R] [Add R] [Neg R] [LE R] (a : R → R)
    (habs_pos : ∀ x : R, 0 ≤ x → a x = x)
    (habs_neg : ∀ x : R, ¬ (0 ≤ x) → a x = -x)
    (htotal : ∀ x : R, 0 ≤ x ∨ x ≤ 0)
    (hadd_neg : ∀ x : R, x + -x = 0)
    (hle_add : ∀ x t : R, x ≤ 0 → x + t ≤ 0 + t)
    (hzero_add : ∀ x : R, 0 + x = x)
    (x : R) : 0 ≤ a x := by
  by_cases hx : 0 ≤ x
  · calc (0 : R)
        ≤ x := hx                                        -- 場合の仮定
      _ = a x := (habs_pos x hx).symm                    -- 場合分けの式を右辺から左辺へ
  · have hx0 : x ≤ 0 := (htotal x).resolve_left hx    -- 全順序の左が成り立たない
    calc (0 : R)
        = x + -x := (hadd_neg x).symm                    -- 加法の逆元を右辺から左辺へ
      _ ≤ 0 + -x := hle_add x (-x) hx0                 -- 順序と加法の両立
      _ = -x := hzero_add (-x)                           -- 左からの加法の単位元
      _ = a x := (habs_neg x hx).symm                    -- 場合分けの式を右辺から左辺へ

end Ising2D.NecSuf
