/- 具体版が必要十分版の特殊化として得られることの導出（R := Q̄）。 -/
import Ising2DLambda.ThermodynamicLimit.QbarLinearFactorPowMulCoeffBound
import Ising2DLambda.NecSuf.ThermodynamicLimit.QbarLinearFactorPowMulCoeffBound

namespace Ising2DLambda.ThermodynamicLimit

open Ising2DLambda.AlgebraicEigenvalue

theorem qbarLinearFactorPowMulCoeffBound_from_necSuf (w : Qbar) (C : QbarPoly) (m : ℕ)
    (hC : ∀ k, m < k → C.coeff k = 0) :
    ∀ j : ℕ, ∀ k, m + j < k → ((Polynomial.X - qbarConst w) ^ j * C).coeff k = 0 :=
  NecSuf.ThermodynamicLimit.poly_linear_factor_pow_mul_coeff_bound_necSuf w C m hC

end Ising2DLambda.ThermodynamicLimit
