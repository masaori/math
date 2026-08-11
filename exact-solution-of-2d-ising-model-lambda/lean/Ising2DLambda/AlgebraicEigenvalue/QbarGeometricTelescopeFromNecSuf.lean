/-
具体版が必要十分版の特殊化として得られることの導出。

具体版は必要十分版を次のように取ったものである。

  R := Qbar（体なので当然に環である）
  z := z        n := n

すなわち、この段が要求するのは**環であることだけ**である。
体であることも、代数閉であることも、積が可換であることも、
`z` が 1 の冪根であることも使っていない。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarGeometricTelescope
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarGeometricTelescope

namespace Ising2DLambda.AlgebraicEigenvalue

open BigOperators

/-- 具体版は必要十分版の特殊化である。 -/
theorem qbarGeometricTelescope_from_necSuf (z : Qbar) (n : ℕ) :
    (z - 1) * qbarGeomSum z n = z ^ n - 1 :=
  NecSuf.AlgebraicEigenvalue.geometric_telescope_necSuf (R := Qbar) z n

end Ising2DLambda.AlgebraicEigenvalue
