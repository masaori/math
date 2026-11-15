import Ising2DLambda.KacWard.DispersionCriticalNonzero
import Ising2DLambda.NecSuf.KacWard.DispersionCriticalNonzero

namespace Ising2DLambda.KacWard

open Polynomial
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero

/-- The general field calculation specializes to the actual dispersion factor. -/
theorem dispersion_critical_nonzero_from_necSuf (data : RealClosedSubfieldData) (L : ℕ)
    (hL : 1 ≤ L) (s : SpinStructure) (hs : s ≠ (false, false))
    (varpi varsigma : Qbar)
    (hv : varpi ∈ horizontalTwistedModes L s)
    (hw : varsigma ∈ verticalTwistedModes L s)
    (x : Qbar) (hx : x ^ 2 + 2 * x - 1 = 0)
    (hx0 : x ≠ 0) (hx1 : x ^ 2 ≠ 1) :
    (dispersionPolynomial varpi varsigma).eval x ≠ 0 := by
  have hn : 0 < 2 * L := by omega
  have hvr : varpi ∈ RootOfUnity (2 * L) :=
    twistedModes_subset_doubleRoots L s (Or.inl hv)
  have hwr : varsigma ∈ RootOfUnity (2 * L) :=
    twistedModes_subset_doubleRoots L s (Or.inr hw)
  obtain ⟨cv, hcv⟩ := two_sub_rootOfUnity_sub_inv_eq_square data (2 * L) hn varpi hvr
  obtain ⟨cw, hcw⟩ := two_sub_rootOfUnity_sub_inv_eq_square data (2 * L) hn varsigma hwr
  have hdec := congrArg (Polynomial.eval x)
    (dispersion_positive_decomposition varpi varsigma)
  simp only [eval_sub, eval_mul, eval_add, eval_pow, eval_X, eval_C,
    eval_ofNat, eval_one] at hdec
  have hvne : varpi ≠ 0 := by
    intro h
    have h' := hvr
    change varpi ^ (2 * L) = 1 at h'
    rw [h, zero_pow (by omega)] at h'
    exact zero_ne_one h'
  have hwne : varsigma ≠ 0 := by
    intro h
    have h' := hwr
    change varsigma ^ (2 * L) = 1 at h'
    rw [h, zero_pow (by omega)] at h'
    exact zero_ne_one h'
  have hmode : ¬(varpi = 1 ∧ varsigma = 1) := by
    intro h
    exact hs ((oneOne_mem_twistedModes_iff L s).mp ⟨h.1 ▸ hv, h.2 ▸ hw⟩)
  apply Ising2DLambda.NecSuf.KacWard.dispersion_critical_nonzero_necSuf
    x varpi varsigma (cv : Qbar) (cw : Qbar)
    ((dispersionPolynomial varpi varsigma).eval x) hx hx0 hx1 hvne hwne
  · exact hcv
  · exact hcw
  · intro h
    have hsquares : cv = 0 ∧ cw = 0 := by
      apply realClosed_sq_add_sq_eq_zero data cv cw
      simpa only [Subfield.coe_mul] using h
    exact ⟨by rw [hsquares.1]; rfl, by rw [hsquares.2]; rfl⟩
  · exact hmode
  · exact hdec

end Ising2DLambda.KacWard
