import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- The factor argument uses only a field, a quadratic fixed point, and
the fact that the two squares in the real subfield cannot cancel. -/
theorem dispersion_critical_nonzero_necSuf {F : Type*} [Field F]
    (x v w cv cw D : F)
    (hx : x ^ 2 + 2 * x - 1 = 0) (hx0 : x ≠ 0) (hx1 : x ^ 2 ≠ 1)
    (hv0 : v ≠ 0) (hw0 : w ≠ 0)
    (hcv : 2 - v - v⁻¹ = cv * cv)
    (hcw : 2 - w - w⁻¹ = cw * cw)
    (hsq : cv * cv + cw * cw = 0 → cv = 0 ∧ cw = 0)
    (hmode : ¬(v = 1 ∧ w = 1))
    (hD : D - (x ^ 2 + 2 * x - 1) ^ 2 =
      x * (1 - x ^ 2) * ((2 - v - v⁻¹) + (2 - w - w⁻¹))) :
    D ≠ 0 := by
  intro hzero
  have hfac : x * (1 - x ^ 2) ≠ 0 :=
    mul_ne_zero hx0 (sub_ne_zero.mpr (Ne.symm hx1))
  have hsum : cv * cv + cw * cw = 0 := by
    have h' : x * (1 - x ^ 2) * ((2 - v - v⁻¹) + (2 - w - w⁻¹)) = 0 := by
      rw [← hD, hzero, hx]
      ring
    rw [hcv, hcw] at h'
    exact (mul_eq_zero.mp h').resolve_left hfac
  obtain ⟨hcv0, hcw0⟩ := hsq hsum
  have hv : v = 1 := by
    have h : (v - 1) * (v - 1) = 0 := by
      calc
        (v - 1) * (v - 1) = -((2 - v - v⁻¹) * v) := by field_simp [hv0]; ring
        _ = 0 := by rw [hcv, hcv0]; ring
    exact sub_eq_zero.mp ((mul_eq_zero.mp h).elim id id)
  have hw : w = 1 := by
    have h : (w - 1) * (w - 1) = 0 := by
      calc
        (w - 1) * (w - 1) = -((2 - w - w⁻¹) * w) := by field_simp [hw0]; ring
        _ = 0 := by rw [hcw, hcw0]; ring
    exact sub_eq_zero.mp ((mul_eq_zero.mp h).elim id id)
  exact hmode ⟨hv, hw⟩

end Ising2DLambda.NecSuf.KacWard
