/-
# 0 を割ると 0 になる（**必要十分版**）

具体版: `Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealZeroDividedIsZero.lean`
（人手 `real_zero_divided_is_zero`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealZeroDividedIsZeroFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `calc` の 2 段（商の定義 → `0·y = 0`） | `zero_div_of_zeroMul` の `calc` の 2 段（同じ並び） |

## 何が効いているか / 効いていないか

- 効くのは、商が `y / z = y z⁻¹` で定まることと、左から 0 を掛けると 0 になること（`0·y = 0` を `y → x⁻¹` に当てる）だけである。
- `0·y = 0` は具体版では主張 `real_zero_times_is_zero` を引く段で、ここではその結論だけを仮定に置く
  （その主張が何から出るかは `NecSuf/ZeroMulOfRightDistrib.lean` が示す）。
- `x ≠ 0` は効いていない。人手では `def_real_quotient` が商を定めるために要るが、商の値の計算には使わない。
  逆元 `x⁻¹` がどの元かも効いていない（`x x⁻¹ = 1` を使わない）。加法、乗法の結合律・単位元、順序、実数であることも効いていない。
-/
import Mathlib.Algebra.Group.Defs

namespace Ising2D.NecSuf

/-- **`real_zero_divided_is_zero`** の必要十分版: 商の定義と左から 0 を掛けると 0 だけから `0/x = 0`。 -/
theorem zero_div_of_zeroMul {R : Type*} [Mul R] [Zero R] [Inv R] [Div R]
    (hdiv_def : ∀ y z : R, y / z = y * z⁻¹) (hzero_mul : ∀ y : R, 0 * y = 0) (x : R) :
    0 / x = 0 :=
  calc 0 / x
      = 0 * x⁻¹ := hdiv_def 0 x     -- 商の定義
    _ = 0 := hzero_mul x⁻¹         -- 左から 0 を掛けると 0

end Ising2D.NecSuf
