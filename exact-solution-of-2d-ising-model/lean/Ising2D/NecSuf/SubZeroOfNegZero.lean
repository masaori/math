/-
# 0 を引いても変わらない（**必要十分版**）

具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealMinusZeroIsSelf.lean`
（人手 `real_minus_zero_is_self`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealMinusZeroIsSelfFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `calc` の 3 段（差の定義 → `-0 = 0` → 加法の単位元） | `sub_zero_of_negZero` の `calc` の 3 段（同じ並び） |

## 何が効いているか / 効いていないか

- 効くのは、差が `a - b = a + -b` で定まること、`-0 = 0`、右からの単位元 `a + 0 = a` の 3 つだけである。
- `-0 = 0` は具体版では主張 `real_negation_of_zero_is_zero` を引く段で、ここではその結論だけを仮定に置く
  （その主張が何から出るかは `NecSuf/NegZeroOfAddComm.lean` が示す）。
- 加法の結合則・可換則、加法の逆元そのもの、乗法、順序、実数であることは効いていない。
- 具体版と同じ手順を保つ限り、3 つの仮定はどれも外せない（各段が 1 つずつ使う）。
-/
import Mathlib.Algebra.Group.Defs

namespace Ising2D.NecSuf

/-- **`real_minus_zero_is_self`** の必要十分版: 差の定義・`-0 = 0`・右からの単位元だけから `a - 0 = a`。 -/
theorem sub_zero_of_negZero {R : Type*} [Add R] [Zero R] [Neg R] [Sub R]
    (hsub_def : ∀ a b : R, a - b = a + -b) (hneg_zero : -(0 : R) = 0)
    (hadd_zero : ∀ a : R, a + 0 = a) (a : R) : a - 0 = a :=
  calc a - 0
      = a + -0 := hsub_def a 0           -- 差の定義
    _ = a + 0 := by rw [hneg_zero]      -- `-0 = 0`
    _ = a := hadd_zero a                -- 加法の単位元

end Ising2D.NecSuf
