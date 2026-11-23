/-
# 差に引いた元を足すともとに戻る（加法の群だけで示す**必要十分版**）

具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimIntegerDifferencePlusSubtrahendIsOriginal.lean`
（人手 `int_difference_plus_subtrahend_is_original`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimIntegerDifferencePlusSubtrahendIsOriginalFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `calc` の 4 段 | `sub_add_cancel_of_addGroup` の `calc` の 4 段（同じ並び） |

## 何が効いているか / 効いていないか

- 効くのは、差が `x − y = x + (−y)` であること、加法の結合律、左からの逆元 `(−y) + y = 0`、右の単位元 `x + 0 = x` だけである。
  `AddGroup` はこれらを公理（またはその直接の帰結）として持つので、型クラスはそれにした。
- 加法の可換律、乗法、順序、整数であることは効いていない。
-/
import Mathlib.Algebra.Group.Defs

namespace Ising2D.NecSuf

/-- **`int_difference_plus_subtrahend_is_original`** の必要十分版: 加法の群で `(x − y) + y = x`。 -/
theorem sub_add_cancel_of_addGroup {R : Type*} [AddGroup R] (x y : R) : (x - y) + y = x :=
  calc (x - y) + y
      = (x + -y) + y := by rw [sub_eq_add_neg x y]                          -- 差は加法の逆元の和
    _ = x + (-y + y) := add_assoc x (-y) y                                   -- 加法の結合律
    _ = x + 0 := by rw [neg_add_cancel y]                                    -- 加法の逆元 `(−y) + y = 0`
    _ = x := add_zero x                                                      -- 右の単位元

end Ising2D.NecSuf
