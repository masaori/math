/- 必要十分版に K = ℚ、A = Qbar を代入した導出版。 -/
import Ising2DLambda.AlgebraicEigenvalue.AlgebraicNumbersEnumeration
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.AlgebraicNumbersEnumeration

namespace Ising2DLambda.AlgebraicEigenvalue

theorem algebraicNumbersEnumeration_from_necSuf :
    ∃ ξ : ℕ → Qbar, Function.Surjective ξ :=
  NecSuf.AlgebraicEigenvalue.algebraicExtensionEnumeration ℚ Qbar

end Ising2DLambda.AlgebraicEigenvalue
