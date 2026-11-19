/-
# 符号を反転した元どうしの積は、もとの元どうしの積に等しい（**必要十分版**）

具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealNegationTimesNegationIsProduct.lean`
（人手 `real_negation_times_negation_is_product`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealNegationTimesNegationIsProductFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `calc` の 9 段（`(-1)·a = -a` を 2 度右辺から左辺へ → 乗法の結合律 → 乗法の結合律 → 乗法の可換律 → 乗法の結合律 → `(-1)·a = -a` を 2 度 → `-(-a) = a`） | `neg_mul_neg_of_rightDistrib` の `calc` の 9 段（同じ並び） |

## 何が効いているか / 効いていないか

- `(-1)·a = -a` の段は、具体版では主張 `real_minus_one_times_is_negation` を引く段で、ここでもその必要十分版
  `neg_one_mul_of_rightDistrib` を引く。効くのは加法の可換群・右からの分配則・左からの乗法の単位元 `1·a = a` である。
- `-(-a) = a` の段は `real_double_negation` の必要十分版 `neg_neg_of_addCommGroup` を引く（加法の可換群だけ）。
- ほかに効くのは、乗法の結合律と可換律（`CommSemigroup R`）だけである。
- 左からの分配則と右からの乗法の単位元 `a·1 = a` は、証明の中では使っていない（可換則と右からの分配則・`1·a = a` から導けるので、仮定として置かない）。乗法の逆元、順序、実数であることは効いていない。
  mathlib には左からの単位元だけを持つ型クラスが無いので、`1·a = a` は仮定 `hone_mul` で受け取る。
- 具体版と同じ手順を保つ限り、乗法の可換律は外せない（5 段目で `a·(-1)` を `(-1)·a` に並べ替え、
  `(-1)` を左へ集めてから `(-1)·a = -a` を当てる形にしている）。主張 `(-a)(-b) = ab` そのものは乗法が可換でない環でも成り立つので、
  可換則が要るのは人手の経路のためであり、主張には本質的でない。
-/
import Ising2D.NecSuf.NegOneMulOfRightDistrib
import Ising2D.NecSuf.NegNegOfAddCommGroup

namespace Ising2D.NecSuf

/-- **`real_negation_times_negation_is_product`** の必要十分版: 加法の可換群で、乗法が可換な半群をなし、
右からの分配則をもち、`1` が左からの乗法の単位元なら `(-a)·(-b) = a·b`。 -/
theorem neg_mul_neg_of_rightDistrib {R : Type*} [AddCommGroup R] [CommSemigroup R] [One R]
    [RightDistribClass R] (hone_mul : ∀ a : R, 1 * a = a) (a b : R) : (-a) * (-b) = a * b :=
  calc (-a) * (-b)
      = ((-1) * a) * (-b) := by rw [neg_one_mul_of_rightDistrib hone_mul a]               -- `(-1)·a = -a` を右辺から左辺へ
    _ = ((-1) * a) * ((-1) * b) := by rw [neg_one_mul_of_rightDistrib hone_mul b]         -- `(-1)·b = -b` を右辺から左辺へ
    _ = (-1) * (a * ((-1) * b)) := mul_assoc (-1) a ((-1) * b)                            -- 乗法の結合律
    _ = (-1) * ((a * (-1)) * b) := by rw [mul_assoc a (-1) b]                             -- 乗法の結合律
    _ = (-1) * (((-1) * a) * b) := by rw [mul_comm a (-1)]                                -- 乗法の可換律
    _ = (-1) * ((-1) * (a * b)) := by rw [mul_assoc (-1) a b]                             -- 乗法の結合律
    _ = (-1) * (-(a * b)) := by rw [neg_one_mul_of_rightDistrib hone_mul (a * b)]         -- `(-1)·(a·b) = -(a·b)`
    _ = -(-(a * b)) := neg_one_mul_of_rightDistrib hone_mul (-(a * b))                    -- `(-1)·(-(a·b)) = -(-(a·b))`
    _ = a * b := neg_neg_of_addCommGroup (a * b)                                          -- `-(-x) = x`

end Ising2D.NecSuf
