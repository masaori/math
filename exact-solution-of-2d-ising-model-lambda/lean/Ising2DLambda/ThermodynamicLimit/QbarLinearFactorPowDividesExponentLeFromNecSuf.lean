/- 具体版が必要十分版の特殊化として得られることの導出（R := Q̄）。 -/
import Ising2DLambda.ThermodynamicLimit.QbarLinearFactorPowDividesExponentLe
import Ising2DLambda.NecSuf.ThermodynamicLimit.QbarLinearFactorPowDividesExponentLe

namespace Ising2DLambda.ThermodynamicLimit

open Ising2DLambda.AlgebraicEigenvalue

theorem qbarLinearFactorPowDividesExponentLe_from_necSuf (w : Qbar) (f : QbarPoly) (n : ℕ)
    (hf : f ≠ 0) (hn : ∀ i, n < i → f.coeff i = 0) (k : ℕ)
    (hdiv : qbarLinearFactorPowDivides w k f) : k ≤ n :=
  NecSuf.ThermodynamicLimit.poly_linear_factor_pow_divides_exponent_le_necSuf w f n hf hn k hdiv

end Ising2DLambda.ThermodynamicLimit
