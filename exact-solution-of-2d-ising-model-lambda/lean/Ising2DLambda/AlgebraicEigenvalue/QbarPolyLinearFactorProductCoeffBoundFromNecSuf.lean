/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyLinearFactorProductCoeffBound
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarPolyLinearFactorProductCoeffBound

namespace Ising2DLambda.AlgebraicEigenvalue

open Polynomial
open scoped BigOperators

theorem qbarPolyLinearFactorProductCoeffBound_from_necSuf (w : ℕ → Qbar) :
    ∀ m k : ℕ, m < k →
      (∏ i ∈ Finset.range m, (Polynomial.X - qbarConst (w i))).coeff k = 0 := by
  exact Ising2DLambda.NecSuf.AlgebraicEigenvalue.poly_linear_factor_product_coeff_bound_necSuf w

end Ising2DLambda.AlgebraicEigenvalue
