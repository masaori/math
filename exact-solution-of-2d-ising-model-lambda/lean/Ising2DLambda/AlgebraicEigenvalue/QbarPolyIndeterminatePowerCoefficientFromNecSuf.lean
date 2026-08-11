/-
「不定元の冪の係数」の具体版が、必要十分版の特殊化として得られることの導出。

具体版は必要十分版（`indeterminate_power_coefficient_necSuf`）を次のように取ったものである。

  R := Qbar（体なので当然に半環である）
  k := k        j := j

すなわち具体版は、係数環を `Qbar` に固定した場合にほかならない。
人手証明で `Qbar[t]` について書いているのは、人手証明を一般の半環へ持ち上げないという規則によるもので、
数学的に 2 つの内容があるわけではない。この導出がそのことを示す。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyIndeterminatePowerCoefficient
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarPolyIndeterminatePowerCoefficient

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 具体版は必要十分版の特殊化である。 -/
theorem qbarPolyIndeterminatePowerCoefficient_from_necSuf (k j : ℕ) :
    ((Polynomial.X : QbarPoly) ^ k).coeff j = if j = k then 1 else 0 :=
  NecSuf.AlgebraicEigenvalue.indeterminate_power_coefficient_necSuf (R := Qbar) k j

end Ising2DLambda.AlgebraicEigenvalue
