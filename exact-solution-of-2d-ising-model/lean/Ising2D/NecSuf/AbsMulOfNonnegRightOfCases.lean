/-
# 場合分けで定めた絶対値と、0 以上の元との積（**必要十分版**）

具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimIntegerAbsoluteValueOfProductWithNonnegative.lean`
（人手 `int_absolute_value_of_product_with_nonnegative`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimIntegerAbsoluteValueOfProductWithNonnegativeFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `0 ≤ x` の場合の `hxy` と 2 段 | 同じ（`hmul_nonneg`・`habs_pos`） |
| `hxy_neg` の 2 段 | 同じ（`habs_neg`・`hneg_mul`） |
| `hneg_nonneg` | 同じ（`habs_nonneg`・`hmul_nonneg`） |
| `0 ≤ x·y` の場合の 3 段・反対称律・6 段 | 同じ（`hzero_add`・`hle_add`・`hneg_add`・`hantisymm`・`hadd_neg`） |
| `¬(0 ≤ x·y)` の場合の 2 段 | 同じ（`habs_neg`） |

## 何が効いているか / 効いていないか

- 効くのは、絶対値 `a` が場合分けの二つの式を満たすことと `0 ≤ a x`、`≤` と乗法の両立 `(0 ≤ x ∧ 0 ≤ y) ⇒ 0 ≤ x·y`、
  符号反転と積の `(−x)·y = −(x·y)`、`≤` と加法の両立の `x = 0` の形 `0 ≤ y ⇒ 0 + t ≤ y + t`、反対称律、
  左からの加法の単位元、左右の加法の逆元だけである。
- 型には演算と元を持つだけの `Zero`・`Add`・`Neg`・`Mul` と関係を持つだけの `LE` を置き、使う性質はすべて仮定に書く。
  `0 ≤ a x` と `(−x)·y = −(x·y)` は、具体版では別の主張（`int_absolute_value_is_nonnegative`・`int_negation_times_is_negation_of_product`）を引く段なので、
  ここでも結論の形で仮定に置く。
- `≤` の反射律・推移律・全順序、加法の結合律・可換律、乗法の結合律・可換律・単位元、整数であること（離散性・帰納法）は効いていない。
-/
import Mathlib.Order.Basic

namespace Ising2D.NecSuf

/-- **`int_absolute_value_of_product_with_nonnegative`** の必要十分版: 場合分けの二つの式と非負性を満たす `a` と、
上の仮定の下で、`0 ≤ y` なら `a (x·y) = a x · y`。 -/
theorem abs_mul_of_nonneg_right_of_cases {R : Type*} [Zero R] [Add R] [Neg R] [Mul R] [LE R] (a : R → R)
    (habs_pos : ∀ x : R, 0 ≤ x → a x = x)
    (habs_neg : ∀ x : R, ¬ (0 ≤ x) → a x = -x)
    (habs_nonneg : ∀ x : R, 0 ≤ a x)
    (hmul_nonneg : ∀ x y : R, 0 ≤ x → 0 ≤ y → 0 ≤ x * y)
    (hneg_mul : ∀ x y : R, (-x) * y = -(x * y))
    (hle_add : ∀ y t : R, 0 ≤ y → 0 + t ≤ y + t)
    (hantisymm : ∀ x y : R, x ≤ y → y ≤ x → x = y)
    (hzero_add : ∀ x : R, 0 + x = x)
    (hadd_neg : ∀ x : R, x + -x = 0)
    (hneg_add : ∀ x : R, -x + x = 0)
    (x y : R) (hy : 0 ≤ y) : a (x * y) = a x * y := by
  by_cases hx : 0 ≤ x
  · have hxy : 0 ≤ x * y := hmul_nonneg x y hx hy
    calc a (x * y)
        = x * y := habs_pos (x * y) hxy
      _ = a x * y := by rw [habs_pos x hx]
  · have hxy_neg : a x * y = -(x * y) :=
      calc a x * y
          = (-x) * y := by rw [habs_neg x hx]
        _ = -(x * y) := hneg_mul x y
    have hneg_nonneg : 0 ≤ -(x * y) := by
      rw [← hxy_neg]
      exact hmul_nonneg (a x) y (habs_nonneg x) hy
    rcases (em (0 ≤ x * y)).symm with hxy | hxy
    · calc a (x * y)
          = -(x * y) := habs_neg (x * y) hxy
        _ = a x * y := hxy_neg.symm
    · have hxy_le : x * y ≤ 0 :=
        calc x * y
            = 0 + x * y := (hzero_add (x * y)).symm
          _ ≤ -(x * y) + x * y := hle_add (-(x * y)) (x * y) hneg_nonneg
          _ = 0 := hneg_add (x * y)
      have hxy_zero : x * y = 0 := hantisymm (x * y) 0 hxy_le hxy
      calc a (x * y)
          = x * y := habs_pos (x * y) hxy
        _ = 0 := hxy_zero
        _ = x * y + -(x * y) := (hadd_neg (x * y)).symm
        _ = 0 + -(x * y) := by rw [hxy_zero]
        _ = -(x * y) := hzero_add (-(x * y))
        _ = a x * y := hxy_neg.symm

end Ising2D.NecSuf
