/-
# 加法定理から得る倍角公式（**必要十分版**）

対応する人手証明のラベル: `sinh_double_angle_formula`（具体版は
`Ising2D/MathematicalTools/RealSquareRootExponentialAndHyperbolicFunctions/ClaimCoshAdditionAndHalfAngle.lean` の
`sinh_eq_two_sinh_half_mul_cosh_half`）。具体版をこの特殊化として得る導出は同じフォルダの
`ClaimCoshAdditionAndHalfAngleFromNecSuf.lean` の `sinh_eq_two_sinh_half_mul_cosh_half_of_necSuf`。

## 何が効いているか / 効いていないか

| 具体版（`ℝ` の `sinh`・`cosh`） | 必要十分版 | 仮定 |
| --- | --- | --- |
| `x = x/2 + x/2` | 1 段目 | 引数の側で、与えられた `y` が `x = y + y` を満たすこと（`hh`。具体版は `y := x/2`） |
| `sinh_addition_formula` の複号 `+` を `x/2, x/2` で | 2 段目 | 点 `(y, y)` での加法定理 `s(y + y) = s(y)c(y) + c(y)s(y)`（`hadd`） |
| `ℝ` の乗法の交換律 | 3 段目 | `c(y)` と `s(y)` が交換すること（`hcomm`）だけ |
| 同類項をまとめる（と Lean にだけある結合律の段） | 4 段目 | 値の側の `ab + ab = 2(ab)`（`hdbl`）と、`2(ab) = (2a)b`（`hassoc`）。どちらも `a = s(y)`、`b = c(y)` の 1 組について |

* 仮定はどれも、主張に出る元 `x`・`y` での 1 つの等式として受け取る。
* 加法定理の中身（`exp` の指数法則、`cosh`・`sinh` の定義、`2` の逆元）は効いていない。点 `(y, y)` での等式として受け取るだけで足りる。
  加法定理そのものの必要十分版は `SymmetrizedAdditionFormulas.lean`。
* 引数の側の加法の結合律・交換律・零・逆元は効いていない。半分にする写像（具体版の `· / 2`）も効いておらず、`x = y + y` を満たす元が 1 つあれば足りる。
* 値の側は加法・乗法・元 `2` があるだけの型で、零・加法の結合律と交換律・分配律・減法・逆元・順序は効いていない。
  乗法の可換律は `c(y)` と `s(y)` の 1 組についてしか効いていない。
* `hassoc` は、Lean の `2 * a * b` が `(2 * a) * b` と読まれるために生じる、Lean にだけある段の仮定である（人手の `2 sinh(x/2) cosh(x/2)` は括弧を書かない）。
  主張の右辺を `2 * (s(y) * c(y))` と書けば要らない。具体版の主張の型に合わせるために置く。
-/
import Mathlib.Init

namespace Ising2D.NecSuf

/-- **倍角公式の必要十分版**: 与えられた `y` が `x = y + y` を満たし、点 `(y, y)` での加法定理と下の 1 組の等式が成り立つなら `s x = 2 s(y) c(y)`。具体版 `sinh_eq_two_sinh_half_mul_cosh_half` と同じ 4 段。 -/
theorem double_angle_formula' {A R : Type*} [Add A] [Add R] [Mul R] [OfNat R 2]
    (s c : A → R) (x y : A)
    (hh : x = y + y)
    (hadd : s (y + y) = s y * c y + c y * s y)
    (hcomm : c y * s y = s y * c y)
    (hdbl : s y * c y + s y * c y = 2 * (s y * c y))
    (hassoc : 2 * (s y * c y) = 2 * s y * c y) :
    s x = 2 * s y * c y :=
  calc s x
      = s (y + y) := by rw [← hh]
          -- 1 段目: `x = y + y`
    _ = s y * c y + c y * s y := hadd
          -- 2 段目: 加法定理
    _ = s y * c y + s y * c y := by rw [hcomm]
          -- 3 段目: `c(y)` と `s(y)` の交換
    _ = 2 * s y * c y := by rw [hdbl, hassoc]
          -- 4 段目: 同類項をまとめる（`hdbl`）と、Lean にだけある結合律の段（`hassoc`）

end Ising2D.NecSuf
