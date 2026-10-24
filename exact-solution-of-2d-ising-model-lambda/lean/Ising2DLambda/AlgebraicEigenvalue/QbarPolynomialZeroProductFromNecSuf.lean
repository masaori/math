import Ising2DLambda.AlgebraicEigenvalue.QbarPolynomialZeroProduct
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarPolynomialZeroProduct

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 必要十分版を代数的数の係数へ特殊化した導出版。 -/
theorem qbarPolynomial_zero_product_from_necSuf (f g : QbarPoly) (hfg : f * g = 0) :
    f = 0 ∨ g = 0 :=
  Ising2DLambda.NecSuf.AlgebraicEigenvalue.polynomial_zero_product_necSuf f g hfg

end Ising2DLambda.AlgebraicEigenvalue
