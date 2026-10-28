import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- A field with two invertible and nonzero mode values suffices for the
algebraic change of notation. -/
theorem dispersion_algebraic_onsager_form
    {R : Type*} [Field R] [NeZero (2 : R)]
    (q varpi varsigma : R) (hq : q ≠ 0)
    (hp : varpi ≠ 0) (hs : varsigma ≠ 0) :
    (1 + q ^ 2) ^ 2 - q * (1 - q ^ 2) *
      (varpi + varpi⁻¹ + varsigma + varsigma⁻¹) =
      4 * q ^ 2 *
        (((1 + q ^ 2) / (2 * q)) ^ 2 -
          ((1 - q ^ 2) / (2 * q)) *
            ((varpi + varpi⁻¹) / 2 + (varsigma + varsigma⁻¹) / 2)) := by
  have htwo : (2 : R) ≠ 0 := NeZero.ne _
  have hfour : (4 : R) ≠ 0 := by
    convert mul_ne_zero htwo htwo using 1 <;> norm_num
  calc
    (1 + q ^ 2) ^ 2 - q * (1 - q ^ 2) *
        (varpi + varpi⁻¹ + varsigma + varsigma⁻¹) =
      (1 + q ^ 2) ^ 2 - q * (1 - q ^ 2) *
        ((varpi + varpi⁻¹) + (varsigma + varsigma⁻¹)) := by ring
    _ = 4 * q ^ 2 *
        (((1 + q ^ 2) ^ 2) / (4 * q ^ 2) -
          ((1 - q ^ 2) / (2 * q)) *
            ((varpi + varpi⁻¹) / 2 + (varsigma + varsigma⁻¹) / 2)) := by
          field_simp [hq, htwo, hfour, hp, hs]
          ring
    _ = 4 * q ^ 2 *
        (((1 + q ^ 2) / (2 * q)) ^ 2 -
          ((1 - q ^ 2) / (2 * q)) *
            ((varpi + varpi⁻¹) / 2 + (varsigma + varsigma⁻¹) / 2)) := by
          field_simp [hq, htwo, hfour, hp, hs]
          ring

end Ising2DLambda.NecSuf.KacWard
