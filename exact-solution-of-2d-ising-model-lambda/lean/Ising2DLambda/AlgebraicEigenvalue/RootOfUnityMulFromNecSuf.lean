/-
具体版が必要十分版の特殊化として得られることの導出。

具体版は必要十分版を次のように取ったものである。

  M := Qbar        w, z := 代数的数        h := Qbar の積の可換則

すなわち、この段が要求するのは**モノイドであることと、その 2 元が可換であることだけ**である。
体であることも代数閉であることも、値が代数的数であることも使っていない。
μ_n の「1 の」の部分（1 が代数的数の 1 であること）も使っておらず、
使うのは「n 乗して単位元になる」という等式 2 本だけである。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnityMul
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.RootOfUnityMul

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 具体版は必要十分版の特殊化である。 -/
theorem rootOfUnity_mul_from_necSuf {n : ℕ} {w z : Qbar}
    (hw : w ∈ RootOfUnity n) (hz : z ∈ RootOfUnity n) : w * z ∈ RootOfUnity n :=
  NecSuf.AlgebraicEigenvalue.mul_mem_pow_eq_one_necSuf (M := Qbar) w z (mul_comm w z) n hw hz

end Ising2DLambda.AlgebraicEigenvalue
