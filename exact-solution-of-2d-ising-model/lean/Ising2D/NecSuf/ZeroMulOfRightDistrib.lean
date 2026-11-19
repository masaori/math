/-
# 0 を左から掛けると 0 になる（**必要十分版**）

具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealZeroTimesIsZero.lean`
（人手 `real_zero_times_is_zero`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealZeroTimesIsZeroFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `calc` の 6 段（加法の単位元 → 加法の逆元 → 加法の結合律 → 右からの分配律 → `0 + 0 = 0` → 加法の逆元） | `zero_mul_of_rightDistrib` の `calc` の 6 段（同じ並び） |

## 何が効いているか / 効いていないか

- 効くのは、加法が群をなすこと（右からの単位元、右からの逆元、結合律）と、右からの分配律 `(a+b)c = ac+bc` だけである。
- 加法の可換律、左からの分配律、乗法の結合律・単位元・可換律、乗法の逆元、順序、実数であることは効いていない。
- 具体版と同じ手順を保つ限り、`AddGroup R` は外せない。1 段目で右からの単位元、2 段目と 6 段目で右からの逆元、
  3 段目で結合律が要る。`AddGroup` はこの 3 つと同じ強さである（結合律と右からの単位元・右からの逆元から、
  左からの単位元と左からの逆元が出る）。`RightDistribClass R` は 4 段目の分配律のために要る。
- 別の手順（`0·x + 0·x = 0·x` の両辺から `0·x` を簡約する）なら加法の逆元は要らないが、それは人手の鎖と別の論法なので採らない。
-/
import Mathlib.Algebra.Group.Defs
import Mathlib.Algebra.Ring.Defs

namespace Ising2D.NecSuf

/-- **`real_zero_times_is_zero`** の必要十分版: 加法群で右からの分配律をもつなら `0·x = 0`。 -/
theorem zero_mul_of_rightDistrib {R : Type*} [AddGroup R] [Mul R] [RightDistribClass R] (x : R) :
    0 * x = 0 :=
  calc 0 * x
      = 0 * x + 0 := (add_zero (0 * x)).symm                                   -- 加法の単位元を右辺から左辺へ
    _ = 0 * x + (0 * x + -(0 * x)) := by rw [add_neg_cancel (0 * x)]            -- 加法の逆元を右辺から左辺へ
    _ = (0 * x + 0 * x) + -(0 * x) := (add_assoc (0 * x) (0 * x) (-(0 * x))).symm  -- 加法の結合律
    _ = (0 + 0) * x + -(0 * x) := by rw [add_mul (0 : R) 0 x]                  -- 右からの分配律を右辺から左辺へ
    _ = 0 * x + -(0 * x) := by rw [add_zero (0 : R)]                           -- `0 + 0 = 0`
    _ = 0 := add_neg_cancel (0 * x)                                            -- 加法の逆元

end Ising2D.NecSuf
