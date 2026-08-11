/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyProductCoeffBound
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarPolyProductCoeffBound

namespace Ising2DLambda.AlgebraicEigenvalue

theorem qbarPolyProductCoeffBound_from_necSuf (P Q : QbarPoly) (p q : ℕ)
    (hP : ∀ k, p < k → P.coeff k = 0) (hQ : ∀ k, q < k → Q.coeff k = 0) :
    ∀ k, p + q < k → (P * Q).coeff k = 0 := by
  exact Ising2DLambda.NecSuf.AlgebraicEigenvalue.poly_product_coeff_bound_necSuf
    P Q p q hP hQ

end Ising2DLambda.AlgebraicEigenvalue
