/-
# 同じ元を二つ足すと `t = 1 + 1` 倍になる（**必要十分版**）

具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealSumOfTwoEqualTermsIsTwice.lean`
（人手 `real_sum_of_two_equal_terms_is_twice`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealSumOfTwoEqualTermsIsTwiceFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `calc` の 3 段（左単位元を右辺から左辺へ → 右からの分配律を右辺から左辺へ → `1 + 1 = 2`） | `add_self_eq_two_mul'` の `calc` の 3 段（同じ並び） |

## 何が効いているか / 効いていないか

- 効くのは、乗法の左単位元 `1·x = x`（仮定 `hone`）、右からの分配律 `(x+y)z = xz+yz`（仮定 `hdistrib`）、
  `t = 1 + 1` であること（仮定 `htwo`）だけである。
- 加法の結合律・可換律・単位元・逆元、乗法の結合律・可換律・右単位元・逆元、左からの分配律、`t ≠ 0`、順序、
  実数であることは効いていない。
- 型は `Add`・`Mul`・`One` だけを取り、公理はすべて仮定で渡す（`MulDivCancelOfRightInverse.lean` と同じ扱い）。
-/
import Mathlib.Algebra.Group.Defs

namespace Ising2D.NecSuf

/-- **`real_sum_of_two_equal_terms_is_twice`** の必要十分版: 左単位元・右からの分配律・`1 + 1 = t` だけから
`a + a = t·a`。 -/
theorem add_self_eq_two_mul' {R : Type*} [Add R] [Mul R] [One R]
    (a t : R)
    (hone : ∀ x : R, 1 * x = x)
    (hdistrib : ∀ x y z : R, (x + y) * z = x * z + y * z)
    (htwo : 1 + 1 = t) :
    a + a = t * a :=
  calc a + a
      = 1 * a + 1 * a := by rw [hone a]                        -- 左単位元（`x → a`）を右辺から左辺へ 2 か所に同時適用
    _ = (1 + 1) * a := (hdistrib 1 1 a).symm                   -- 右からの分配律（`x → 1, y → 1, z → a`）を右辺から左辺へ
    _ = t * a := by rw [htwo]                                  -- `1 + 1 = t`

end Ising2D.NecSuf
