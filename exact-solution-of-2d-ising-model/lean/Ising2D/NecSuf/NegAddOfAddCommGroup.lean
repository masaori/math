/-
# 和の符号を反転すると、符号を反転した元の和になる（加法の可換群だけで示す**必要十分版**）

具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimIntegerNegationOfSumIsSumOfNegations.lean`
（人手 `int_negation_of_sum_is_sum_of_negations`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimIntegerNegationOfSumIsSumOfNegationsFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `calc` の 10 段 | `neg_add_of_addCommGroup` の `calc` の 10 段（同じ並び） |

## 何が効いているか / 効いていないか

- 効くのは、加法の左右の単位元、左右の逆元、加法の結合律、加法の可換律だけである。
- 加法の可換律は最後の段 `(−y) + (−x) = (−x) + (−y)` だけで効く。その前の 9 段は可換でない加法の群でも通り、
  `−(x + y) = (−y) + (−x)` を与える。人手の主張が `(−x) + (−y)` の順に書かれているので、可換律を外せない。
- 乗法・`1`・分配律・順序・整数であることは効いていない（`real_negation_of_sum_is_sum_of_negations` の人手の経路は
  `(−1)·z = −z` を経るので乗法と分配律が要るが、この主張の経路は加法だけで閉じる）。
-/
import Mathlib.Algebra.Group.Defs

namespace Ising2D.NecSuf

/-- **`int_negation_of_sum_is_sum_of_negations`** の必要十分版: 加法の可換群で `−(x + y) = (−x) + (−y)`。 -/
theorem neg_add_of_addCommGroup {R : Type*} [AddCommGroup R] (x y : R) : -(x + y) = (-x) + (-y) :=
  calc -(x + y)
      = -(x + y) + 0 := (add_zero (-(x + y))).symm                           -- 右の単位元を右辺から左辺へ
    _ = -(x + y) + (x + -x) := by rw [add_neg_cancel x]                      -- 右からの逆元を右辺から左辺へ
    _ = -(x + y) + ((x + 0) + -x) := by rw [add_zero x]                      -- 右の単位元を右辺から左辺へ
    _ = -(x + y) + ((x + (y + -y)) + -x) := by rw [add_neg_cancel y]         -- 右からの逆元を右辺から左辺へ
    _ = -(x + y) + (((x + y) + -y) + -x) := by rw [add_assoc x y (-y)]       -- 加法の結合律を右辺から左辺へ
    _ = -(x + y) + ((x + y) + (-y + -x)) := by rw [add_assoc (x + y) (-y) (-x)]
                                                                             -- 加法の結合律
    _ = (-(x + y) + (x + y)) + (-y + -x) := (add_assoc (-(x + y)) (x + y) (-y + -x)).symm
                                                                             -- 加法の結合律を右辺から左辺へ
    _ = 0 + (-y + -x) := by rw [neg_add_cancel (x + y)]                      -- 左からの逆元
    _ = -y + -x := zero_add (-y + -x)                                        -- 左の単位元
    _ = -x + -y := add_comm (-y) (-x)                                        -- 加法の可換律

end Ising2D.NecSuf
