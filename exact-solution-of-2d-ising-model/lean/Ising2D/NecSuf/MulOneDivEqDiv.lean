/-
# 1/t を掛けると t で割った商になる（**必要十分版**）

具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealTimesHalfIsQuotientByTwo.lean`
（人手 `real_times_half_is_quotient_by_two`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealTimesHalfIsQuotientByTwoFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `calc` の 3 段（商の定義 → 乗法の左単位元 → 商の定義を右辺から左辺へ） | `mul_one_div_eq_div'` の `calc` の 3 段（同じ並び） |

## 何が効いているか / 効いていないか

- 効くのは、商が `y / z = y z⁻¹` で定まることと、乗法の左単位元 `1·x = x` だけである。
- `t = 2 = 1 + 1` であること、`t ≠ 0`、`t·t⁻¹ = 1`（逆元であること）、乗法の結合律・交換律、加法、順序、
  実数であることは効いていない。
-/
import Mathlib.Algebra.Group.Defs

namespace Ising2D.NecSuf

/-- **`real_times_half_is_quotient_by_two`** の必要十分版: 商の定義と左単位元だけから `a·(1/t) = a/t`。 -/
theorem mul_one_div_eq_div' {R : Type*} [Mul R] [One R] [Inv R] [Div R]
    (a t : R)
    (hdiv : ∀ y z : R, y / z = y * z⁻¹)
    (hone : ∀ x : R, 1 * x = x) :
    a * (1 / t) = a / t :=
  calc a * (1 / t)
      = a * (1 * t⁻¹) := by rw [hdiv 1 t]                      -- 商の定義（`y → 1, z → t`）
    _ = a * t⁻¹ := by rw [hone t⁻¹]                            -- 乗法の左単位元（`x → t⁻¹`）
    _ = a / t := (hdiv a t).symm                               -- 商の定義（`y → a, z → t`）を右辺から左辺へ

end Ising2D.NecSuf
