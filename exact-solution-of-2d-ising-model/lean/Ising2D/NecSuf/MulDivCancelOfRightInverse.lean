/-
# `t` で割った商に `t` を掛けるともとの元に戻る（`t t⁻¹ = 1`。**必要十分版**）

具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealTwiceQuotientByTwoIsOriginal.lean`
（人手 `real_twice_quotient_by_two_is_original`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealTwiceQuotientByTwoIsOriginalFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `calc` の 5 段（商の定義 → `b` と `2⁻¹` の交換 → 結合則を右辺から左辺へ → 右逆元 → 左単位元） | `mul_div_cancel_of_right_inverse'` の `calc` の 5 段（同じ並び） |

## 何が効いているか / 効いていないか

- 効くのは、商が `y / z = y z⁻¹` で定まること（仮定 `hdiv`）、`b` と `t⁻¹` が可換であること（仮定 `hc`。
  人手の交換則の段は `b` と `2^{-1}` の 1 組にしか当てない）、乗法の結合律（仮定 `hassoc`）、`t·t⁻¹ = 1`（仮定 `hinv`）、
  乗法の左単位元 `1·x = x`（仮定 `hone`）だけである。
- **具体版の `2 ≠ 0` は `hinv` を出すためだけに要る。** `R := ℝ`、`t := 0` なら（mathlib の `0⁻¹ = 0` の下で）`t·t⁻¹ = 0 ≠ 1` となり、主張 `0·(b/0) = b` も `b ≠ 0` で成り立たない。
- 一般の可換則、右単位元、`t⁻¹·t = 1`（左逆元）、`t = 2 = 1 + 1` であること、加法、順序、実数であることは効いていない。
- 型は `Mul`・`One`・`Inv`・`Div` だけを取り、公理はすべて仮定で渡す（`OneSubHalfEqHalf.lean`・`MulOneDivEqDiv.lean` と同じ扱い）。
-/
import Mathlib.Algebra.Group.Defs

namespace Ising2D.NecSuf

/-- **`real_twice_quotient_by_two_is_original`** の必要十分版: 商の定義・`b` と `t⁻¹` の可換性・結合則・`t t⁻¹ = 1`・
左単位元だけから `t·(b/t) = b`。 -/
theorem mul_div_cancel_of_right_inverse' {R : Type*} [Mul R] [One R] [Inv R] [Div R]
    (b t : R)
    (hdiv : ∀ y z : R, y / z = y * z⁻¹)
    (hc : b * t⁻¹ = t⁻¹ * b)
    (hassoc : ∀ x y z : R, (x * y) * z = x * (y * z))
    (hinv : t * t⁻¹ = 1)
    (hone : ∀ x : R, 1 * x = x) :
    t * (b / t) = b :=
  calc t * (b / t)
      = t * (b * t⁻¹) := by rw [hdiv b t]                      -- 商の定義（`y → b, z → t`）
    _ = t * (t⁻¹ * b) := by rw [hc]                            -- `b` と `t⁻¹` の可換性
    _ = (t * t⁻¹) * b := (hassoc t t⁻¹ b).symm                 -- 結合則（`x → t, y → t⁻¹, z → b`）を右辺から左辺へ
    _ = 1 * b := by rw [hinv]                                  -- 右逆元 `t·t⁻¹ = 1`
    _ = b := hone b                                            -- 乗法の左単位元（`x → b`）

end Ising2D.NecSuf
