/- 具体版が必要十分版の特殊化として得られることの導出（R := Q̄）。 -/
import Ising2DLambda.ThermodynamicLimit.QbarLinearFactorPowMulLeadingCoeff
import Ising2DLambda.NecSuf.ThermodynamicLimit.QbarLinearFactorPowMulLeadingCoeff

namespace Ising2DLambda.ThermodynamicLimit

open Ising2DLambda.AlgebraicEigenvalue

theorem qbarLinearFactorPowMulLeadingCoeff_from_necSuf (w : Qbar) (C : QbarPoly) (m : ℕ)
    (hC : ∀ k, m < k → C.coeff k = 0) :
    ∀ j : ℕ, ((Polynomial.X - qbarConst w) ^ j * C).coeff (m + j) = C.coeff m :=
  NecSuf.ThermodynamicLimit.poly_linear_factor_pow_mul_leading_coeff_necSuf w C m hC

end Ising2DLambda.ThermodynamicLimit
