import Ising2DLambda.AlgebraicEigenvalue.QbarPolynomialSquareRootUniqueness
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarPolynomialSquareRootUniqueness

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 必要十分版を代数的数係数へ特殊化する導出版。 -/
theorem qbarPolynomialSquareRoot_unique_from_necSuf (S T : QbarPoly)
    (hS : S.coeff 0 = 1) (hT : T.coeff 0 = 1) (hsquare : S * S = T * T) :
    S = T := by
  have htwo_ne : (1 : Qbar) + 1 ≠ 0 := by norm_num
  exact Ising2DLambda.NecSuf.AlgebraicEigenvalue.polynomialSquareRoot_unique_necSuf
    htwo_ne S T hS hT hsquare

end Ising2DLambda.AlgebraicEigenvalue
