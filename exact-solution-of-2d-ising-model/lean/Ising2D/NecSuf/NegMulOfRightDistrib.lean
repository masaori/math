/-
# 符号を反転した元に右から元を掛けると、積の符号が反転する（**必要十分版**）

具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealNegationTimesIsNegationOfProduct.lean`
（人手 `real_negation_times_is_negation_of_product`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealNegationTimesIsNegationOfProductFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `calc` の 3 段（`(-1)·x = -x` を右辺から左辺へ → 乗法の結合律 → `(-1)·(x·t) = -(x·t)`） | `neg_mul_of_rightDistrib` の `calc` の 3 段（同じ並び） |

## 何が効いているか / 効いていないか

- `(-1)·a = -a` の 2 段は、具体版では主張 `real_minus_one_times_is_negation` を引く段で、ここでもその必要十分版
  `neg_one_mul_of_rightDistrib` を引く。効くのは加法の可換群・右からの分配律・左からの乗法の単位元 `1·a = a` である。
- ほかに効くのは乗法の結合律（`Semigroup R`）だけである。
- 乗法の可換律、左からの分配律、右からの乗法の単位元 `a·1 = a`、乗法の逆元、順序、実数であることは効いていない。
  mathlib には左からの単位元だけを持つ型クラスが無いので、`1·a = a` は仮定 `hone_mul` で受け取る。
- 主張 `(-x)·t = -(x·t)` そのものは、加法の群と右からの分配律だけで（`x·t + (-x)·t = (x + -x)·t = 0·t = 0` から）成り立つ。
  `1` と乗法の結合律が要るのは、`-x` を `(-1)·x` に書き換える人手の経路のためであり、主張には本質的でない。
-/
import Ising2D.NecSuf.NegOneMulOfRightDistrib

namespace Ising2D.NecSuf

/-- **`real_negation_times_is_negation_of_product`** の必要十分版: 加法の可換群で、乗法が半群をなし、
右からの分配律をもち、`1` が左からの乗法の単位元なら `(-x)·t = -(x·t)`。 -/
theorem neg_mul_of_rightDistrib {R : Type*} [AddCommGroup R] [Semigroup R] [One R]
    [RightDistribClass R] (hone_mul : ∀ a : R, 1 * a = a) (x t : R) : (-x) * t = -(x * t) :=
  calc (-x) * t
      = ((-1) * x) * t := by rw [neg_one_mul_of_rightDistrib hone_mul x]   -- `(-1)·x = -x` を右辺から左辺へ
    _ = (-1) * (x * t) := mul_assoc (-1) x t                              -- 乗法の結合律
    _ = -(x * t) := neg_one_mul_of_rightDistrib hone_mul (x * t)          -- `(-1)·(x·t) = -(x·t)`

end Ising2D.NecSuf
