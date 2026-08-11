/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyLinearFactorCoeffBound
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarPolyLinearFactorCoeffBound

namespace Ising2DLambda.AlgebraicEigenvalue

theorem qbarPolyLinearFactorCoeffBound_from_necSuf (w : Qbar) (C : QbarPoly) (m : ℕ)
    (hC : ∀ k, m < k → C.coeff k = 0) :
    ∀ k, m + 1 < k → ((Polynomial.X - qbarConst w) * C).coeff k = 0 := by
  exact Ising2DLambda.NecSuf.AlgebraicEigenvalue.poly_linear_factor_coeff_bound_necSuf
    w C m hC

end Ising2DLambda.AlgebraicEigenvalue
