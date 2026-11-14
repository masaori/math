/-
# 0 を右から掛けると 0 になる（**必要十分版**）

具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealTimesZeroIsZero.lean`
（人手 `real_times_zero_is_zero`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealTimesZeroIsZeroFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `calc` の 6 段（加法の単位元 → 加法の逆元 → 加法の結合則 → 左からの分配則 → `0 + 0 = 0` → 加法の逆元） | `mul_zero_of_leftDistrib` の `calc` の 6 段（同じ並び） |

## 何が効いているか / 効いていないか

- 効くのは、加法が群をなすこと（右からの単位元、右からの逆元、結合則）と、左からの分配則 `a(b+c) = ab+ac` だけである。
- 加法の可換則、右からの分配則、乗法の結合則・単位元・可換則、乗法の逆元、順序、実数であることは効いていない。
- 具体版と同じ手順を保つ限り、`AddGroup R` は外せない（`NecSuf/ZeroMulOfRightDistrib.lean` と同じ理由）。
  `LeftDistribClass R` は 4 段目の分配則のために要る。左から掛ける形 `zero_mul_of_rightDistrib` とは、
  要る分配則の向きだけが違う。
-/
import Mathlib.Algebra.Group.Defs
import Mathlib.Algebra.Ring.Defs

namespace Ising2D.NecSuf

/-- **`real_times_zero_is_zero`** の必要十分版: 加法群で左からの分配則をもつなら `x·0 = 0`。 -/
theorem mul_zero_of_leftDistrib {R : Type*} [AddGroup R] [Mul R] [LeftDistribClass R] (x : R) :
    x * 0 = 0 :=
  calc x * 0
      = x * 0 + 0 := (add_zero (x * 0)).symm                                   -- 加法の単位元を右辺から左辺へ
    _ = x * 0 + (x * 0 + -(x * 0)) := by rw [add_neg_cancel (x * 0)]            -- 加法の逆元を右辺から左辺へ
    _ = (x * 0 + x * 0) + -(x * 0) := (add_assoc (x * 0) (x * 0) (-(x * 0))).symm  -- 加法の結合則
    _ = x * (0 + 0) + -(x * 0) := by rw [mul_add x (0 : R) 0]                  -- 左からの分配則を右辺から左辺へ
    _ = x * 0 + -(x * 0) := by rw [add_zero (0 : R)]                           -- `0 + 0 = 0`
    _ = 0 := add_neg_cancel (x * 0)                                            -- 加法の逆元

end Ising2D.NecSuf
