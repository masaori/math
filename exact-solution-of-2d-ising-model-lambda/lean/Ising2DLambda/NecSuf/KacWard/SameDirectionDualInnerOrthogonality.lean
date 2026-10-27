import Ising2DLambda.NecSuf.KacWard.DualEndpointModeVector
import Ising2DLambda.NecSuf.KacWard.EndpointModeVector
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.RootOfUnityGeometricSumZero
import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

open BigOperators
attribute [local instance] Classical.propDecidable

private theorem finiteRootPowerSum {F : Type*} [Field F]
    {L : ℕ} (z : F) (hz : z ^ L = 1) :
    (∑ j : Fin L, z ^ j.val) = if z = 1 then (L : F) else 0 := by
  classical
  by_cases h : z = 1
  · simp [h]
  · simp only [if_neg h]
    rw [Fin.sum_univ_eq_sum_range]
    apply Ising2DLambda.NecSuf.AlgebraicEigenvalue.geometric_sum_zero_necSuf
      (inv := (z - 1)⁻¹)
    · exact inv_mul_cancel₀ (sub_ne_zero.mpr h)
    · exact hz

theorem sameDirection_dualInner_orthogonality_necSuf
    {E F : Type*} [Fintype E] [DecidableEq E] [Field F]
    {L : ℕ} (h : E ≃ ((Fin L × Fin L) × ZMod 4))
    (row column : E → ℕ) (direction : E → ZMod 4)
    (hrow : ∀ e, row e = (h e).1.1.val)
    (hcolumn : ∀ e, column e = (h e).1.2.val)
    (hdirection : ∀ e, direction e = (h e).2)
    (varpi varsigma varpi' varsigma' : F) (δ : ZMod 4)
    (hvarpi : varpi ≠ 0) (hvarsigma : varsigma ≠ 0)
    (hpower : (varpi' / varpi) ^ L = 1)
    (hpower' : (varsigma' / varsigma) ^ L = 1) :
    (∑ e : E, dualEndpointModeVector row column direction varpi varsigma δ e *
      endpointModeVector row column direction varpi' varsigma' δ e) =
      if varpi = varpi' ∧ varsigma = varsigma' then (L : F) ^ 2 else 0 := by
  classical
  let r : F := varpi' / varpi
  let t : F := varsigma' / varsigma
  have hreindex :
      (∑ e : E, dualEndpointModeVector row column direction varpi varsigma δ e *
        endpointModeVector row column direction varpi' varsigma' δ e) =
      ∑ p : ((Fin L × Fin L) × ZMod 4),
        dualEndpointModeVector row column direction varpi varsigma δ (h.symm p) *
          endpointModeVector row column direction varpi' varsigma' δ (h.symm p) := by
    exact (Equiv.sum_comp h.symm _).symm
  rw [hreindex]
  simp only [dualEndpointModeVector, endpointModeVector]
  simp only [hrow, hcolumn, hdirection, Equiv.apply_symm_apply]
  rw [Fintype.sum_prod_type]
  simp_rw [ite_mul, zero_mul]
  simp only [mul_ite, mul_zero]
  simp
  have hterm (x : Fin L × Fin L) :
      (varpi ^ x.2.val)⁻¹ * (varsigma ^ x.1.val)⁻¹ *
        (varpi' ^ x.2.val * varsigma' ^ x.1.val) =
      r ^ x.2.val * t ^ x.1.val := by
    dsimp [r, t]
    simp [div_eq_mul_inv, mul_pow, mul_assoc, mul_comm, mul_left_comm]
  simp_rw [hterm]
  rw [Fintype.sum_prod_type]
  simp_rw [← Finset.sum_mul]
  simp_rw [← Finset.mul_sum]
  rw [finiteRootPowerSum r (by simpa [r] using hpower),
      finiteRootPowerSum t (by simpa [t] using hpower')]
  have hr : r = 1 ↔ varpi = varpi' := by
    dsimp [r]
    constructor
    · intro hratio
      apply (div_eq_one_iff_eq hvarpi).mp at hratio
      exact hratio.symm
    · intro hsame
      rw [← hsame]
      exact div_self hvarpi
  have ht : t = 1 ↔ varsigma = varsigma' := by
    dsimp [t]
    constructor
    · intro hratio
      apply (div_eq_one_iff_eq hvarsigma).mp at hratio
      exact hratio.symm
    · intro hsame
      rw [← hsame]
      exact div_self hvarsigma
  by_cases hsameVarpi : varpi = varpi'
  · by_cases hsameVarsigma : varsigma = varsigma'
    · simp [hr.mpr hsameVarpi, ht.mpr hsameVarsigma, hsameVarpi, hsameVarsigma, pow_two]
    · simp [hr.mpr hsameVarpi, (not_congr ht).mpr hsameVarsigma,
        hsameVarpi, hsameVarsigma]
  · simp [(not_congr hr).mpr hsameVarpi, hsameVarpi]

end Ising2DLambda.NecSuf.KacWard
