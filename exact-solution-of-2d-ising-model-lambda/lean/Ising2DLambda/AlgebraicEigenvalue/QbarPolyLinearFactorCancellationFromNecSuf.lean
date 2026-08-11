/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyLinearFactorCancellation
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarPolyLinearFactorCancellation

namespace Ising2DLambda.AlgebraicEigenvalue

theorem qbarPolyLinearFactorCancellation_from_necSuf (w : Qbar) (A B : QbarPoly) (n : ℕ)
    (hA : ∀ k, n < k → A.coeff k = 0)
    (hB : ∀ k, n < k → B.coeff k = 0)
    (hmul : (Polynomial.X - qbarConst w) * A = (Polynomial.X - qbarConst w) * B) : A = B := by
  exact Ising2DLambda.NecSuf.AlgebraicEigenvalue.poly_linear_factor_cancellation_necSuf
    w A B n hA hB hmul

end Ising2DLambda.AlgebraicEigenvalue
