/-
# 0 の符号を反転しても 0 である（**必要十分版**）

具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealNegationOfZeroIsZero.lean`
（人手 `real_negation_of_zero_is_zero`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealNegationOfZeroIsZeroFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `calc` の 3 段（加法の単位元 → 加法の可換律 → 加法の逆元） | `neg_zero_of_addComm` の `calc` の 3 段（同じ並び） |

## 何が効いているか / 効いていないか

- 効くのは、`-0 + 0 = -0`（右からの単位元を `-0` に当てる）、`-0 + 0 = 0 + -0`（可換律を `-0` と `0` に当てる）、
  `0 + -0 = 0`（右からの逆元を `0` に当てる）の 3 つだけである。仮定はこの 3 つを全ての元についての形で置く。
- 加法の結合律、乗法、順序、実数であることは効いていない。
- 具体版と同じ手順を保つ限り、3 つの仮定はどれも外せない（各段が 1 つずつ使う）。
  mathlib の `NegZeroClass` は `-0 = 0` そのものを公理に持つので、それを仮定すると何も示さないことになり採らない。
-/
import Mathlib.Algebra.Group.Defs

namespace Ising2D.NecSuf

/-- **`real_negation_of_zero_is_zero`** の必要十分版: 右からの単位元・可換律・右からの逆元だけから `-0 = 0`。 -/
theorem neg_zero_of_addComm {R : Type*} [Add R] [Zero R] [Neg R]
    (hadd_zero : ∀ a : R, a + 0 = a) (hadd_comm : ∀ a b : R, a + b = b + a)
    (hadd_neg : ∀ a : R, a + -a = 0) : -(0 : R) = 0 :=
  calc -(0 : R)
      = -0 + 0 := (hadd_zero (-(0 : R))).symm   -- 加法の単位元を右辺から左辺へ
    _ = 0 + -0 := hadd_comm (-(0 : R)) 0         -- 加法の可換律
    _ = 0 := hadd_neg 0                          -- 加法の逆元

end Ising2D.NecSuf
