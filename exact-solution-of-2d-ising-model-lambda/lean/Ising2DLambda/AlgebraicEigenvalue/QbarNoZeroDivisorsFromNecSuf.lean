/-
具体版が必要十分版の特殊化として得られることの導出。

具体版は必要十分版を次のように取ったものである。

  M := Qbar（体なので当然に零元を持つモノイドである）
  a := a        b := b        ainv := a⁻¹
  hinv := inv_mul_cancel₀ ha（具体版の準備の段。ここでだけ `a ≠ 0` と体であることを使う）

すなわち、この段が要求するのは**零元を持つモノイドであることと、`a` が左逆元を持つこと**
だけである。体であることも、代数閉であることも、積が可換であることも、
`a` 以外の元が逆元を持つことも使っていない。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarNoZeroDivisors
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarNoZeroDivisors

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 具体版は必要十分版の特殊化である。 -/
theorem qbarNoZeroDivisors_from_necSuf {a b : Qbar} (ha : a ≠ 0) (hab : a * b = 0) : b = 0 :=
  NecSuf.AlgebraicEigenvalue.no_zero_divisors_necSuf (M := Qbar) (inv_mul_cancel₀ ha) hab

end Ising2DLambda.AlgebraicEigenvalue
