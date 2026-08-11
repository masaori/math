/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyLinearFactorLeadingCoeff
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarPolyLinearFactorLeadingCoeff

namespace Ising2DLambda.AlgebraicEigenvalue

theorem qbarPolyLinearFactorLeadingCoeff_from_necSuf (w : Qbar) (C : QbarPoly) (m : ℕ)
    (hC : ∀ k, m < k → C.coeff k = 0) :
    ((Polynomial.X - qbarConst w) * C).coeff (m + 1) = C.coeff m := by
  exact Ising2DLambda.NecSuf.AlgebraicEigenvalue.poly_linear_factor_leading_coeff_necSuf
    w C m hC

end Ising2DLambda.AlgebraicEigenvalue
