/-
主張「相異なる代数的数に対応する一次因子は互いに素である（明示的な Bezout 恒等式）」の必要十分版。

必要なのは、環であること（分配則）と、a - b の左逆元 u が既に分かっていること
（u*(a-b)=1）だけである。体であることも、多項式環であることも、代数閉であることも
Q̄ の元であることも仮定しない。

住処: ここに ℝ / ℂ は現れない。
-/
import Mathlib.Algebra.Ring.Defs

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

/-- `u*(a-b)=1` ならば `u*a - u*b = 1`（分配則のみを使う）。 -/
theorem distinct_linear_factors_bezout_necSuf {R : Type*} [Ring R] (u a b : R)
    (hinv : u * (a - b) = 1) : u * a - u * b = 1 := by
  calc u * a - u * b = u * (a - b) := (mul_sub u a b).symm
    _ = 1 := hinv

end Ising2DLambda.NecSuf.ThermodynamicLimit
