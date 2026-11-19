/-
# 正の元の加法の逆元は負（**必要十分版**）

具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealNegationOfPositiveIsNegative.lean`
（人手 `real_negation_of_positive_is_negative`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealNegationOfPositiveIsNegativeFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `calc` の 3 段（加法の単位元、順序と加法の両立、加法の逆元） | `neg_lt_zero_of_zero_lt` の同じ 3 段 |

## 何が効いているか / 効いていないか

- 効くのは、左からの加法の単位元 `0 + x = x`、順序と加法の両立 `x < y ⇒ x + c < y + c`、加法の逆元 `z + (−z) = 0` の 3 つだけである。
- 型には演算と元を持つだけの `Zero`・`Add`・`Neg` と、関係を持つだけの `LT` を置き、使う性質はすべて仮定に書く。
  `calc` が `=` と `<` をつなぐのは等号での書き換えだけなので、`<` の推移律・非反射律も、順序であることも効いていない。
- 加法の結合律・可換律、右からの単位元、乗法、全順序、実数であること、完備性は効いていない。
-/
import Mathlib.Order.Basic

namespace Ising2D.NecSuf

/-- **`real_negation_of_positive_is_negative`** の必要十分版: 左からの加法の単位元、順序と加法の両立、加法の逆元から、
`0 < a` なら `−a < 0`。 -/
theorem neg_lt_zero_of_zero_lt {R : Type*} [Zero R] [Add R] [Neg R] [LT R]
    (hzero_add : ∀ x : R, 0 + x = x)
    (hadd : ∀ x y c : R, x < y → x + c < y + c)
    (hadd_neg : ∀ z : R, z + -z = 0)
    (a : R) (ha : 0 < a) : -a < 0 :=
  calc -a
      = 0 + -a := (hzero_add (-a)).symm                     -- 加法の単位元を右辺から左辺へ
    _ < a + -a := hadd 0 a (-a) ha                           -- 順序と加法の両立
    _ = 0 := hadd_neg a                                      -- 加法の逆元

end Ising2D.NecSuf
