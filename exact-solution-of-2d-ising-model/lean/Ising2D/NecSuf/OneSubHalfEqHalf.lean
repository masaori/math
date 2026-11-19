/-
# 1 から 1/2 を引くと 1/2 になる（**必要十分版**）

具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealOneMinusHalfIsHalf.lean`
（人手 `real_one_minus_half_is_half`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealOneMinusHalfIsHalfFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `calc` の 8 段（差の定義 → 逆元 → `2 = 1 + 1` → 分配律 → 商の定義 → 加法の結合律 → 加法の逆元 → 加法の単位元） | `one_sub_half_eq_half'` の `calc` の 8 段（同じ並び） |

## 何が効いているか / 効いていないか

- 効くのは、差が `a − b = a + (−b)` で定まること、`t` の右逆元 `t·t⁻¹ = 1`、`t = 1 + 1`、右からの分配律、
  商が `y / z = y z⁻¹` で定まること、加法の結合律、加法の右逆元 `x + (−x) = 0`、加法の右単位元 `x + 0 = x` だけである。
- `t·t⁻¹ = 1` は、具体版では `t = 2` の `2 ≠ 0`（`real_two_is_nonzero`）から体の公理で得る段で、ここではその結論だけを仮定に置く。
  `t` 以外の元の逆元、`0⁻¹` の値は効いていない。
- 乗法の結合律・交換律・単位元（`1·x = x`）、加法の交換律、左からの分配律、順序、実数であることは効いていない。
-/
import Mathlib.Algebra.Group.Defs

namespace Ising2D.NecSuf

/-- **`real_one_minus_half_is_half`** の必要十分版: 上の 8 つの性質だけから `1 − 1/t = 1/t`（`t = 1 + 1`）。 -/
theorem one_sub_half_eq_half' {R : Type*} [Add R] [Mul R] [Neg R] [Sub R] [Zero R] [One R] [Inv R] [Div R]
    (t : R)
    (hsub : ∀ a b : R, a - b = a + -b)
    (hinv : t * t⁻¹ = 1)
    (htwo : t = 1 + 1)
    (hdistrib : ∀ x y s : R, (x + y) * s = x * s + y * s)
    (hdiv : ∀ y z : R, y / z = y * z⁻¹)
    (hassoc : ∀ x y s : R, (x + y) + s = x + (y + s))
    (hneg : ∀ x : R, x + -x = 0)
    (hzero : ∀ x : R, x + 0 = x) :
    1 - 1 / t = 1 / t :=
  calc 1 - 1 / t
      = 1 + -(1 / t) := hsub 1 (1 / t)                         -- 差の定義
    _ = t * t⁻¹ + -(1 / t) := by rw [hinv]                     -- `t` の右逆元を右辺から左辺へ
    _ = (1 + 1) * t⁻¹ + -(1 / t) :=
        congrArg (fun x => x * t⁻¹ + -(1 / t)) htwo            -- `t = 1 + 1`（左の因子だけ）
    _ = (1 * t⁻¹ + 1 * t⁻¹) + -(1 / t) := by
        rw [hdistrib 1 1 t⁻¹]                                  -- 右からの分配律
    _ = (1 / t + 1 / t) + -(1 / t) := by
        rw [← hdiv 1 t]                                        -- 商の定義を右辺から左辺へ、2 箇所へ
    _ = 1 / t + (1 / t + -(1 / t)) :=
        hassoc (1 / t) (1 / t) (-(1 / t))                      -- 加法の結合律
    _ = 1 / t + 0 := by rw [hneg (1 / t)]                      -- 加法の右逆元
    _ = 1 / t := hzero (1 / t)                                 -- 加法の右単位元

end Ising2D.NecSuf
