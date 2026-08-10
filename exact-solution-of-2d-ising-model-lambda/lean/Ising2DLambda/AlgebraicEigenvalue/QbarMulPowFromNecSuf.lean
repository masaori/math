/-
具体版が必要十分版の特殊化として得られることの導出。

具体版は必要十分版を次のように取ったものである。

  M := Qbar        w, z := 代数的数        h := Qbar の積の可換則

すなわち、この段が要求するのは**モノイドであることと、その 2 元が可換であることだけ**である。
体であることも代数閉であることも、値が代数的数であることも、加法も零元も分配則も
使っていない。具体版が `mul_comm` を直に引けるのは `Qbar` が可換体だからであって、
この段が全体としての可換性を要求しているからではない。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarMulPow
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarMulPow

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 具体版は必要十分版の特殊化である。 -/
theorem qbarMul_pow_from_necSuf (w z : Qbar) (n : ℕ) :
    (w * z) ^ n = w ^ n * z ^ n :=
  NecSuf.AlgebraicEigenvalue.mul_pow_necSuf (M := Qbar) w z (mul_comm w z) n

end Ising2DLambda.AlgebraicEigenvalue
