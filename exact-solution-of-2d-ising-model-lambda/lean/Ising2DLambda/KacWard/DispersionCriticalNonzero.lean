/-
臨界点で非自明なねじれの各分散因子が零でないこと。
本文の平方和表示、二つの平方の和が零なら両方零、
ねじれたモードには (1,1) が無いことに対応する。
-/
import Ising2DLambda.KacWard.DispersionPositiveAtRationalPoint
import Ising2DLambda.KacWard.SignedEvenSubgraphRationalSignMembership
import Ising2DLambda.FisherZero.RealClosedSumOfTwoSquaresZero

namespace Ising2DLambda.KacWard

open Polynomial
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero

private theorem root_eq_one_of_two_sub_inv_zero (z : Qbar) (hz : z ≠ 0)
    (h : 2 - z - z⁻¹ = 0) : z = 1 := by
  have hmul : (z - 1) * (z - 1) = 0 := by
    calc
      (z - 1) * (z - 1) = -((2 - z - z⁻¹) * z) := by field_simp [hz]; ring
      _ = 0 := by rw [h]; ring
  exact sub_eq_zero.mp ((mul_eq_zero.mp hmul).elim id id)

/-- `x²+2x−1=0`、`x ≠ 0`、`x² ≠ 1` なら、非自明なねじれの各モード因子は零でない。 -/
theorem dispersion_critical_nonzero (data : RealClosedSubfieldData) (L : ℕ)
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
  intro hzero
  have hsum : ((cv * cv : data.carrier) : Qbar) +
      ((cw * cw : data.carrier) : Qbar) = 0 := by
    have hfac : x * (1 - x ^ 2) ≠ 0 :=
      mul_ne_zero hx0 (sub_ne_zero.mpr (Ne.symm hx1))
    have h' : x * (1 - x ^ 2) *
        ((2 - varpi - varpi⁻¹) + (2 - varsigma - varsigma⁻¹)) = 0 := by
      rw [← hdec, hzero, hx]
      ring
    rw [hcv, hcw] at h'
    exact (mul_eq_zero.mp h').resolve_left hfac
  have hsquares : cv = 0 ∧ cw = 0 := by
    apply realClosed_sq_add_sq_eq_zero data cv cw
    simpa only [Subfield.coe_mul] using hsum
  have hvzero : 2 - varpi - varpi⁻¹ = 0 := by rw [hcv, hsquares.1]; norm_num
  have hwzero : 2 - varsigma - varsigma⁻¹ = 0 := by rw [hcw, hsquares.2]; norm_num
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
  have hvone := root_eq_one_of_two_sub_inv_zero varpi hvne hvzero
  have hwone := root_eq_one_of_two_sub_inv_zero varsigma hwne hwzero
  exact hs ((oneOne_mem_twistedModes_iff L s).mp ⟨hvone ▸ hv, hwone ▸ hw⟩)

end Ising2DLambda.KacWard
