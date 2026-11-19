/-
# 元に右から符号を反転した元を掛けると、積の符号が反転する（**必要十分版**）

具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealTimesNegationIsNegationOfProduct.lean`
（人手 `real_times_negation_is_negation_of_product`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealTimesNegationIsNegationOfProductFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `calc` の 3 段（乗法の可換律 → `(-p)·q = -(p·q)` → 乗法の可換律） | `mul_neg_of_comm_rightDistrib` の `calc` の 3 段（同じ並び） |

## 何が効いているか / 効いていないか

- 真ん中の段は、具体版では主張 `real_negation_times_is_negation_of_product` を引く段で、ここでもその必要十分版
  `neg_mul_of_rightDistrib` を引く。効くのは加法の可換群・右からの分配則・左からの乗法の単位元 `1·a = a`・乗法の結合律である。
- 前後の 2 段で乗法の可換律（`CommSemigroup R`）が効く。人手の経路は可換則で `x·(-t)` を `(-t)·x` に並べ替えて
  右からの分配則の側の主張へ帰すので、可換則は削れない。
- 左からの分配則、右からの乗法の単位元 `a·1 = a`、乗法の逆元、順序、実数であることは効いていない。
  mathlib には左からの単位元だけを持つ型クラスが無いので、`1·a = a` は仮定 `hone_mul` で受け取る。
- 主張 `x·(-t) = -(x·t)` そのものは、加法の群と左からの分配則だけで（`x·t + x·(-t) = x·(t + -t) = x·0 = 0` から）成り立つ。
  可換則・`1`・結合則が要るのは、`(-x)·t = -(x·t)` に帰す人手の経路のためであり、主張には本質的でない。
-/
import Ising2D.NecSuf.NegMulOfRightDistrib

namespace Ising2D.NecSuf

/-- **`real_times_negation_is_negation_of_product`** の必要十分版: 加法の可換群で、乗法が可換な半群をなし、
右からの分配則をもち、`1` が左からの乗法の単位元なら `x·(-t) = -(x·t)`。 -/
theorem mul_neg_of_comm_rightDistrib {R : Type*} [AddCommGroup R] [CommSemigroup R] [One R]
    [RightDistribClass R] (hone_mul : ∀ a : R, 1 * a = a) (x t : R) : x * (-t) = -(x * t) :=
  calc x * (-t)
      = (-t) * x := mul_comm x (-t)                                      -- 乗法の可換律
    _ = -(t * x) := neg_mul_of_rightDistrib hone_mul t x                 -- `(-p)·q = -(p·q)`（`p → t, q → x`）
    _ = -(x * t) := by rw [mul_comm t x]                                 -- 乗法の可換律

end Ising2D.NecSuf
