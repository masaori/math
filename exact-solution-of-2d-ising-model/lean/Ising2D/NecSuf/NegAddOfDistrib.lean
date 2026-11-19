/-
# 和の符号を反転すると、符号を反転した元の和になる（**必要十分版**）

具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealNegationOfSumIsSumOfNegations.lean`
（人手 `real_negation_of_sum_is_sum_of_negations`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealNegationOfSumIsSumOfNegationsFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `calc` の 3 段（`(-1)·(x+y) = -(x+y)` を右辺から左辺へ → 左からの分配律 → `(-1)·a = -a` を 2 箇所へ） | `neg_add_of_distrib` の `calc` の 3 段（同じ並び） |

## 何が効いているか / 効いていないか

- `(-1)·a = -a` の 2 段は、具体版では主張 `real_minus_one_times_is_negation` を引く段で、ここでもその必要十分版
  `neg_one_mul_of_rightDistrib` を引く。効くのは加法の可換群・右からの分配律・左からの乗法の単位元 `1·a = a` である。
- 真ん中の段で左からの分配律（`LeftDistribClass R`）が効く。
- 乗法の結合律・可換律、右からの乗法の単位元 `a·1 = a`、乗法の逆元、順序、実数であることは効いていない。
  mathlib には左からの単位元だけを持つ型クラスが無いので、`1·a = a` は仮定 `hone_mul` で受け取る。
- 主張 `-(x+y) = (-x)+(-y)` そのものは、加法の可換群だけで（`(x+y) + ((-x)+(-y)) = 0` と逆元の一意性から）成り立つ。
  乗法・`1`・分配律が要るのは、`-z` を `(-1)·z` に書き換える人手の経路のためであり、主張には本質的でない。
-/
import Ising2D.NecSuf.NegOneMulOfRightDistrib

namespace Ising2D.NecSuf

/-- **`real_negation_of_sum_is_sum_of_negations`** の必要十分版: 加法の可換群で、左右からの分配律をもち、
`1` が左からの乗法の単位元なら `-(x+y) = (-x)+(-y)`。 -/
theorem neg_add_of_distrib {R : Type*} [AddCommGroup R] [Mul R] [One R]
    [LeftDistribClass R] [RightDistribClass R] (hone_mul : ∀ a : R, 1 * a = a) (x y : R) :
    -(x + y) = (-x) + (-y) :=
  calc -(x + y)
      = (-1) * (x + y) := (neg_one_mul_of_rightDistrib hone_mul (x + y)).symm   -- `(-1)·(x+y) = -(x+y)` を右辺から左辺へ
    _ = (-1) * x + (-1) * y := mul_add (-1) x y                                -- 左からの分配律
    _ = (-x) + (-y) := by
        rw [neg_one_mul_of_rightDistrib hone_mul x, neg_one_mul_of_rightDistrib hone_mul y]
                                                                               -- `(-1)·a = -a` を 2 箇所へ

end Ising2D.NecSuf
