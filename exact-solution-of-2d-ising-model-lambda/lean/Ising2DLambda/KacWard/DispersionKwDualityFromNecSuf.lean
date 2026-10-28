import Ising2DLambda.KacWard.DispersionKwDuality
import Ising2DLambda.NecSuf.KacWard.DispersionKwDuality

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

theorem dispersion_kw_duality_from_necSuf
    (q varpi varsigma : RatFunc Qbar) (h : 1 + q ≠ 0) :
    (1 + q) ^ 4 *
      ((1 + ((1 - q) / (1 + q)) ^ 2) ^ 2 -
        ((1 - q) / (1 + q)) * (1 - ((1 - q) / (1 + q)) ^ 2) *
          (varpi + varpi⁻¹ + varsigma + varsigma⁻¹)) =
      4 * ((1 + q ^ 2) ^ 2 - q * (1 - q ^ 2) *
        (varpi + varpi⁻¹ + varsigma + varsigma⁻¹)) := by
  exact Ising2DLambda.NecSuf.KacWard.dispersion_kw_duality q varpi varsigma h

end Ising2DLambda.KacWard
