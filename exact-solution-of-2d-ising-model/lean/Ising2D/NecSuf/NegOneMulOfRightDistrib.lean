/-
# −1 を左から掛けると符号が反転する（**必要十分版**）

具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealMinusOneTimesIsNegation.lean`
（人手 `real_minus_one_times_is_negation`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealMinusOneTimesIsNegationFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `calc` の 10 段（加法の単位元 → 加法の逆元 → 加法の結合律 → `1·a = a` → 右からの分配則 → 加法の可換則 → 加法の逆元 → `0·a = 0` → 加法の可換則 → 加法の単位元） | `neg_one_mul_of_rightDistrib` の `calc` の 10 段（同じ並び） |

## 何が効いているか / 効いていないか

- 効くのは、加法が可換群をなすこと（右からの単位元、右からの逆元、結合則、可換則）、右からの分配則
  `(x+y)c = xc+yc`、`1` が左からの乗法の単位元であること（`1·a = a`）だけである。
- `0·a = 0` は具体版では主張 `real_zero_times_is_zero` を引く段で、ここでもその必要十分版
  `zero_mul_of_rightDistrib`（加法群と右からの分配則だけで示した）を引く。新しい仮定は増えない。
- 左からの分配則、乗法の結合則・可換則、右からの乗法の単位元 `a·1 = a`、乗法の逆元、順序、実数であることは効いていない。
  mathlib には左からの単位元だけを持つ型クラスが無いので、`1·a = a` は仮定 `hone_mul` で受け取る。
- 具体版と同じ手順を保つ限り、加法の可換則は外せない（6 段目で `(-1) + 1` を `1 + (-1)` に、9 段目で `0 + (-a)` を
  `(-a) + 0` に並べ替え、右からの逆元・右からの単位元を当てる形にしている）。`AddCommGroup R` はこの 4 つと同じ強さである。
-/
import Ising2D.NecSuf.ZeroMulOfRightDistrib

namespace Ising2D.NecSuf

/-- **`real_minus_one_times_is_negation`** の必要十分版: 加法の可換群で右からの分配則をもち、`1` が左からの
乗法の単位元なら `(-1)·a = -a`。 -/
theorem neg_one_mul_of_rightDistrib {R : Type*} [AddCommGroup R] [Mul R] [One R] [RightDistribClass R]
    (hone_mul : ∀ a : R, 1 * a = a) (a : R) : (-1) * a = -a :=
  calc (-1) * a
      = (-1) * a + 0 := (add_zero ((-1) * a)).symm                           -- 加法の単位元を右辺から左辺へ
    _ = (-1) * a + (a + -a) := by rw [add_neg_cancel a]                       -- 加法の逆元を右辺から左辺へ
    _ = ((-1) * a + a) + -a := (add_assoc ((-1) * a) a (-a)).symm             -- 加法の結合律
    _ = ((-1) * a + 1 * a) + -a := by rw [hone_mul a]                         -- `1·a = a` を右辺から左辺へ
    _ = ((-1) + 1) * a + -a := by rw [add_mul (-1 : R) 1 a]                   -- 右からの分配則を右辺から左辺へ
    _ = (1 + -1) * a + -a := by rw [add_comm (-1 : R) 1]                      -- 加法の可換則
    _ = 0 * a + -a := by rw [add_neg_cancel (1 : R)]                          -- 加法の逆元
    _ = 0 + -a := by rw [zero_mul_of_rightDistrib a]                          -- `0·a = 0`（`zero_mul_of_rightDistrib`）
    _ = -a + 0 := add_comm 0 (-a)                                             -- 加法の可換則
    _ = -a := add_zero (-a)                                                   -- 加法の単位元

end Ising2D.NecSuf
