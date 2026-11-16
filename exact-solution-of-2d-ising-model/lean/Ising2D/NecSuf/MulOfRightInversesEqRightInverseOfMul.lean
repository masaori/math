/-
# 右逆元どうしの積は積の右逆元（**必要十分版**）

具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealProductOfInversesIsInverseOfProduct.lean`
（人手 `real_product_of_inverses_is_inverse_of_product`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealProductOfInversesIsInverseOfProductFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| 準備の `calc` の 7 段（結合則 → 結合則を右辺から左辺へ → 可換則 → 結合則 → 逆元 → `x·1 = x` → 逆元） | `prep` の同じ並び |
| 主鎖の `calc` の 6 段（`1·x = x` → 逆元 → 可換則 → 結合則 → 準備 → `x·1 = x`） | 主の `calc` の同じ並び |

## 何が効いているか / 効いていないか

- 効くのは、`1·y = y`、`y·1 = y`、乗法の結合則、乗法の可換則（準備の 3 段目と主鎖の 3 段目の 2 か所）、
  `a`・`b`・`a·b` がそれぞれ右逆元 `a'`・`b'`・`c`（`a·a' = 1`、`b·b' = 1`、`(a·b)·c = 1`）を持つことだけである。
- `a ≠ 0`・`b ≠ 0` は、具体版では体の公理から逆元 `a⁻¹`・`b⁻¹` を得るためと、`real_product_of_nonzero_is_nonzero` で
  `a·b ≠ 0` を出して `(a·b)⁻¹` を得るためだけに要る。ここでは三つの右逆元の存在を直接仮定に置く。
- `1·y = y` は可換則と `y·1 = y` から従うが、具体版の主鎖の 1 段目が人手どおり `1·x = x` を引くので、同じ手順を保つために仮定に残す。
- 逆元の一意性、加法、`0`、順序、実数であることは効いていない。
-/
import Mathlib.Algebra.Group.Defs

namespace Ising2D.NecSuf

/-- **`real_product_of_inverses_is_inverse_of_product`** の必要十分版: `a·a' = 1`、`b·b' = 1`、`(a·b)·c = 1` なら `a'·b' = c`。 -/
theorem mul_of_rightInverses_eq_rightInverse_of_mul {R : Type*} [Mul R] [One R]
    (hone_mul : ∀ y : R, 1 * y = y)
    (hmul_one : ∀ y : R, y * 1 = y)
    (hmul_assoc : ∀ x y z : R, (x * y) * z = x * (y * z))
    (hmul_comm : ∀ x y : R, x * y = y * x)
    {a b a' b' c : R} (ha : a * a' = 1) (hb : b * b' = 1) (hab : (a * b) * c = 1) :
    a' * b' = c := by
  have prep : (a * b) * (a' * b') = 1 :=
    calc (a * b) * (a' * b')
        = a * (b * (a' * b')) := hmul_assoc a b (a' * b')     -- 結合則
      _ = a * ((b * a') * b') := by rw [hmul_assoc b a' b']   -- 結合則を右辺から左辺へ
      _ = a * ((a' * b) * b') := by rw [hmul_comm b a']       -- 可換則
      _ = a * (a' * (b * b')) := by rw [hmul_assoc a' b b']   -- 結合則
      _ = a * (a' * 1) := by rw [hb]                          -- 右逆元 `b·b' = 1`
      _ = a * a' := by rw [hmul_one a']                       -- `x·1 = x`
      _ = 1 := ha                                             -- 右逆元 `a·a' = 1`
  calc a' * b'
      = 1 * (a' * b') := (hone_mul _).symm                    -- `1·x = x` を右辺から左辺へ
    _ = ((a * b) * c) * (a' * b') := by rw [hab]              -- 右逆元 `(a·b)·c = 1` を右辺から左辺へ
    _ = (c * (a * b)) * (a' * b') := by rw [hmul_comm (a * b) c]
                                                              -- 可換則
    _ = c * ((a * b) * (a' * b')) := hmul_assoc _ _ _         -- 結合則
    _ = c * 1 := by rw [prep]                                 -- 準備
    _ = c := hmul_one c                                       -- `x·1 = x`

end Ising2D.NecSuf
