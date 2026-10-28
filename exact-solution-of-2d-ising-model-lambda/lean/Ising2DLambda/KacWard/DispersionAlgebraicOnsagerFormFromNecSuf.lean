import Ising2DLambda.KacWard.DispersionAlgebraicOnsagerForm
import Ising2DLambda.NecSuf.KacWard.DispersionAlgebraicOnsagerForm

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

theorem dispersion_algebraic_onsager_form_from_necSuf
    (q varpi varsigma : Qbar) (hq : q ≠ 0)
    (hp : varpi ≠ 0) (hs : varsigma ≠ 0) :
    (1 + q ^ 2) ^ 2 - q * (1 - q ^ 2) *
      (varpi + varpi⁻¹ + varsigma + varsigma⁻¹) =
      4 * q ^ 2 *
        (((1 + q ^ 2) / (2 * q)) ^ 2 -
          ((1 - q ^ 2) / (2 * q)) *
            ((varpi + varpi⁻¹) / 2 + (varsigma + varsigma⁻¹) / 2)) := by
  exact Ising2DLambda.NecSuf.KacWard.dispersion_algebraic_onsager_form
    q varpi varsigma hq hp hs

end Ising2DLambda.KacWard
