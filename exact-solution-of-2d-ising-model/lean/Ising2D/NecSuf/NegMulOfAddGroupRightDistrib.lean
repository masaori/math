/-
# 符号を反転した元に右から元を掛けると、積の符号が反転する（加法の群と右からの分配律だけで示す**必要十分版**）

具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimIntegerNegationTimesIsNegationOfProduct.lean`
（人手 `int_negation_times_is_negation_of_product`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimIntegerNegationTimesIsNegationOfProductFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `calc` の 7 段 | `neg_mul_of_addGroup_rightDistrib` の `calc` の 7 段（同じ並び。`int_zero_times_is_zero` の段は `zero_mul_of_rightDistrib`） |

## 何が効いているか / 効いていないか

- 効くのは、加法が群をなすこと（結合律・左右の単位元・左右の逆元）と、右からの分配律 `(y + z)·s = y·s + z·s` だけである。
  `0·t = 0` の段も同じ二つから示す（`NecSuf.zero_mul_of_rightDistrib`）。
- 加法の可換律、左からの分配律、乗法の結合律・単位元、順序、整数であることは効いていない。
- 同じ主張の `real_negation_times_is_negation_of_product` の必要十分版 `NecSuf.neg_mul_of_rightDistrib` は、人手が `(−1)·x` を経るので
  乗法の結合律と `1` を仮定に持つ。こちらは人手がその経路を取らないので、それらを持たない。
-/
import Ising2D.NecSuf.ZeroMulOfRightDistrib

namespace Ising2D.NecSuf

/-- **`int_negation_times_is_negation_of_product`** の必要十分版: 加法の群で右からの分配律をもてば `(−x)·t = −(x·t)`。 -/
theorem neg_mul_of_addGroup_rightDistrib {R : Type*} [AddGroup R] [Mul R] [RightDistribClass R] (x t : R) :
    (-x) * t = -(x * t) :=
  calc (-x) * t
      = (-x) * t + 0 := (add_zero ((-x) * t)).symm                             -- 加法の単位元を右辺から左辺へ
    _ = (-x) * t + (x * t + -(x * t)) := by rw [add_neg_cancel (x * t)]        -- 加法の逆元を右辺から左辺へ
    _ = ((-x) * t + x * t) + -(x * t) := (add_assoc ((-x) * t) (x * t) (-(x * t))).symm  -- 加法の結合律を右辺から左辺へ
    _ = ((-x) + x) * t + -(x * t) := by rw [add_mul (-x) x t]                  -- 右からの分配律を右辺から左辺へ
    _ = 0 * t + -(x * t) := by rw [neg_add_cancel x]                           -- 加法の逆元 `(−y)+y = 0`
    _ = 0 + -(x * t) := by rw [zero_mul_of_rightDistrib t]                     -- `0·t = 0`
    _ = -(x * t) := zero_add (-(x * t))                                        -- 加法の単位元 `0 + y = y`

end Ising2D.NecSuf
