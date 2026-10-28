import Ising2DLambda.KacWard.ModeSmallMatrixDeterminantDispersion

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- The finite-mode dispersion expression in the algebraic notation used for
the later Onsager integral. No analytic functions occur here. -/
theorem dispersion_algebraic_onsager_form
    (q varpi varsigma : Qbar) (hq : q ≠ 0)
    (hp : varpi ≠ 0) (hs : varsigma ≠ 0) :
    (1 + q ^ 2) ^ 2 - q * (1 - q ^ 2) *
      (varpi + varpi⁻¹ + varsigma + varsigma⁻¹) =
      4 * q ^ 2 *
        (((1 + q ^ 2) / (2 * q)) ^ 2 -
          ((1 - q ^ 2) / (2 * q)) *
            ((varpi + varpi⁻¹) / 2 + (varsigma + varsigma⁻¹) / 2)) := by
  calc
    (1 + q ^ 2) ^ 2 - q * (1 - q ^ 2) *
        (varpi + varpi⁻¹ + varsigma + varsigma⁻¹) =
      (1 + q ^ 2) ^ 2 - q * (1 - q ^ 2) *
        ((varpi + varpi⁻¹) + (varsigma + varsigma⁻¹)) := by ring
    _ = 4 * q ^ 2 *
        (((1 + q ^ 2) ^ 2) / (4 * q ^ 2) -
          ((1 - q ^ 2) / (2 * q)) *
            ((varpi + varpi⁻¹) / 2 + (varsigma + varsigma⁻¹) / 2)) := by
          field_simp [hq, hp, hs]
          ring
    _ = 4 * q ^ 2 *
        (((1 + q ^ 2) / (2 * q)) ^ 2 -
          ((1 - q ^ 2) / (2 * q)) *
            ((varpi + varpi⁻¹) / 2 + (varsigma + varsigma⁻¹) / 2)) := by
          field_simp [hq, hp, hs]
          ring

end Ising2DLambda.KacWard
