/-
# 場合分けで定めた絶対値が 0 なら元は 0（**必要十分版**）

具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimIntegerAbsoluteValueZeroImpliesZero.lean`
（人手 `int_absolute_value_zero_implies_zero`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimIntegerAbsoluteValueZeroImpliesZeroFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `0 ≤ x` の場合の 2 段 | 同じ 2 段（`habs_pos`） |
| `¬(0 ≤ x)` の場合の準備 `−x = a x = 0` の 2 段 | 同じ 2 段（`habs_neg`） |
| 鎖 `x = x + 0 = x + (−x) = 0` の 3 段 | 同じ 3 段（`hadd_zero`・`hadd_neg`） |

## 何が効いているか / 効いていないか

- 効くのは、絶対値 `a` が場合分けの二つの式 `0 ≤ x ⇒ a x = x`・`¬(0 ≤ x) ⇒ a x = −x` を満たすこと、右からの加法の単位元
  `x + 0 = x`、加法の逆元 `x + (−x) = 0` の 4 つだけである。
- 型には演算と元を持つだけの `Zero`・`Add`・`Neg` と、関係を持つだけの `LE` を置き、使う性質はすべて仮定に書く。
  `≤` は場合分けの条件に現れるだけで、順序の性質（反射律・推移律・反対称律・全順序・加法との両立）は一つも効いていない。
- 加法の結合律・可換律、乗法、整数であること（離散性・帰納法）は効いていない。
-/
import Mathlib.Order.Basic

namespace Ising2D.NecSuf

/-- **`int_absolute_value_zero_implies_zero`** の必要十分版: 場合分けの二つの式を満たす `a`、右からの加法の単位元、
加法の逆元から、`a x = 0 ⇒ x = 0`。 -/
theorem eq_zero_of_abs_cases_eq_zero {R : Type*} [Zero R] [Add R] [Neg R] [LE R] (a : R → R)
    (habs_pos : ∀ x : R, 0 ≤ x → a x = x)
    (habs_neg : ∀ x : R, ¬ (0 ≤ x) → a x = -x)
    (hadd_zero : ∀ x : R, x + 0 = x)
    (hadd_neg : ∀ x : R, x + -x = 0)
    (x : R) (h : a x = 0) : x = 0 := by
  by_cases hx : 0 ≤ x
  · calc x
        = a x := (habs_pos x hx).symm                    -- 場合分けの式を右辺から左辺へ
      _ = 0 := h                                         -- 仮定
  · have hneg : -x = 0 :=
      calc -x
          = a x := (habs_neg x hx).symm                  -- 場合分けの式を右辺から左辺へ
        _ = 0 := h                                       -- 仮定
    calc x
        = x + 0 := (hadd_zero x).symm                    -- 右からの加法の単位元を右辺から左辺へ
      _ = x + -x := by rw [hneg]                         -- `−x = 0` を右辺から左辺へ
      _ = 0 := hadd_neg x                                -- 加法の逆元

end Ising2D.NecSuf
