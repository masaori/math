import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- Only field operations and the invertibility of `1 + q` are used. -/
theorem dispersion_kw_duality
    {R : Type*} [Field R] (q varpi varsigma : R) (h : 1 + q ≠ 0) :
    (1 + q) ^ 4 *
      ((1 + ((1 - q) / (1 + q)) ^ 2) ^ 2 -
        ((1 - q) / (1 + q)) * (1 - ((1 - q) / (1 + q)) ^ 2) *
          (varpi + varpi⁻¹ + varsigma + varsigma⁻¹)) =
      4 * ((1 + q ^ 2) ^ 2 - q * (1 - q ^ 2) *
        (varpi + varpi⁻¹ + varsigma + varsigma⁻¹)) := by
  have hsum : 1 + ((1 - q) / (1 + q)) ^ 2 =
      2 * (1 + q ^ 2) / (1 + q) ^ 2 := by
    field_simp [h]
    ring
  have hproduct : ((1 - q) / (1 + q)) *
      (1 - ((1 - q) / (1 + q)) ^ 2) =
      4 * q * (1 - q) / (1 + q) ^ 3 := by
    field_simp [h]
    ring
  calc
    (1 + q) ^ 4 *
        ((1 + ((1 - q) / (1 + q)) ^ 2) ^ 2 -
          ((1 - q) / (1 + q)) * (1 - ((1 - q) / (1 + q)) ^ 2) *
            (varpi + varpi⁻¹ + varsigma + varsigma⁻¹)) =
      (1 + q) ^ 4 *
        ((2 * (1 + q ^ 2) / (1 + q) ^ 2) ^ 2 -
          (4 * q * (1 - q) / (1 + q) ^ 3) *
            (varpi + varpi⁻¹ + varsigma + varsigma⁻¹)) := by
        rw [hsum, hproduct]
    _ = 4 * ((1 + q ^ 2) ^ 2 - q * (1 - q) * (1 + q) *
          (varpi + varpi⁻¹ + varsigma + varsigma⁻¹)) := by
        field_simp [h]
        ring
    _ = 4 * ((1 + q ^ 2) ^ 2 - q * (1 - q ^ 2) *
          (varpi + varpi⁻¹ + varsigma + varsigma⁻¹)) := by
        ring

end Ising2DLambda.NecSuf.KacWard
