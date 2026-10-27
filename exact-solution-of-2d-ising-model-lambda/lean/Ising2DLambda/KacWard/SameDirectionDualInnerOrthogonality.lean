/- `claim_same_direction_dual_inner_orthogonality` の具体版。 -/
import Ising2DLambda.KacWard.TargetDirectionBijection
import Ising2DLambda.KacWard.TwistedModeRatioRoot
import Ising2DLambda.KacWard.DualEndpointModeVector
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnityGeometricSumZero
import Mathlib

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.PartitionPolynomial
open BigOperators
attribute [local instance] Classical.propDecidable

theorem sameDirection_dualInner_orthogonality {L : ℕ} [NeZero L]
    (s : SpinStructure) (varpi varsigma varpi' varsigma' : Qbar) (δ : ZMod 4)
    (hvarpi : varpi ∈ horizontalTwistedModes L s)
    (hvarsigma : varsigma ∈ verticalTwistedModes L s)
    (hvarpi' : varpi' ∈ horizontalTwistedModes L s)
    (hvarsigma' : varsigma' ∈ verticalTwistedModes L s) :
    (∑ e : OrientedEdge L,
      dualEndpointModeVector L varpi varsigma δ e *
        endpointModeVector L varpi' varsigma' δ e) =
      if varpi = varpi' ∧ varsigma = varsigma' then (L : Qbar) ^ 2 else 0 := by
  classical
  let htarget : OrientedEdge L ≃ (Vertex L × ZMod 4) :=
    Equiv.ofBijective (fun e => (orientedTarget e, directionNumber e))
      targetDirection_bijective
  let hcoord : Vertex L ≃ Fin L × Fin L :=
    Equiv.prodCongr (ZMod.finEquiv L).symm (ZMod.finEquiv L).symm
  let h : OrientedEdge L ≃ ((Fin L × Fin L) × ZMod 4) :=
    htarget.trans (Equiv.prodCongr hcoord (Equiv.refl _))
  have hrow (e : OrientedEdge L) :
      (orientedTarget e).1.val = (h e).1.1.val := by
    simp [h, htarget, hcoord]
    cases L with
    | zero => exact (NeZero.ne 0 rfl).elim
    | succ n => rfl
  have hcolumn (e : OrientedEdge L) :
      (orientedTarget e).2.val = (h e).1.2.val := by
    simp [h, htarget, hcoord]
    cases L with
    | zero => exact (NeZero.ne 0 rfl).elim
    | succ n => rfl
  have hdirection (e : OrientedEdge L) : directionNumber e = (h e).2 := by
    simp [h, htarget, hcoord]
  have hnonzeroVarpi : varpi ≠ 0 := by
    intro hz
    have hp : varpi ^ L = (if s.1 then (-1 : Qbar) else 1) := hvarpi
    rw [hz, zero_pow (NeZero.ne L)] at hp
    split_ifs at hp <;> norm_num at hp
  have hnonzeroVarsigma : varsigma ≠ 0 := by
    intro hz
    have hp : varsigma ^ L = (if s.2 then (-1 : Qbar) else 1) := hvarsigma
    rw [hz, zero_pow (NeZero.ne L)] at hp
    split_ifs at hp <;> norm_num at hp
  obtain ⟨hrootR, hrootT⟩ :=
    twistedMode_ratio_root s hvarpi hvarpi' hvarsigma hvarsigma'
  let r : Qbar := varpi' / varpi
  let t : Qbar := varsigma' / varsigma
  have hreindex :
      (∑ e : OrientedEdge L,
        dualEndpointModeVector L varpi varsigma δ e *
          endpointModeVector L varpi' varsigma' δ e) =
      ∑ p : ((Fin L × Fin L) × ZMod 4),
        dualEndpointModeVector L varpi varsigma δ (h.symm p) *
          endpointModeVector L varpi' varsigma' δ (h.symm p) := by
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
  have hsumR : (∑ j : Fin L, r ^ j.val) = if r = 1 then (L : Qbar) else 0 := by
    by_cases hsame : r = 1
    · simp [hsame]
    · simp only [if_neg hsame]
      rw [Fin.sum_univ_eq_sum_range]
      exact rootOfUnityGeometricSumZero (by simpa [r] using hrootR) hsame
  have hsumT : (∑ i : Fin L, t ^ i.val) = if t = 1 then (L : Qbar) else 0 := by
    by_cases hsame : t = 1
    · simp [hsame]
    · simp only [if_neg hsame]
      rw [Fin.sum_univ_eq_sum_range]
      exact rootOfUnityGeometricSumZero (by simpa [t] using hrootT) hsame
  rw [hsumR, hsumT]
  have hr : r = 1 ↔ varpi = varpi' := by
    dsimp [r]
    constructor
    · intro hratio
      exact ((div_eq_one_iff_eq hnonzeroVarpi).mp hratio).symm
    · intro hsame
      rw [← hsame]
      exact div_self hnonzeroVarpi
  have ht : t = 1 ↔ varsigma = varsigma' := by
    dsimp [t]
    constructor
    · intro hratio
      exact ((div_eq_one_iff_eq hnonzeroVarsigma).mp hratio).symm
    · intro hsame
      rw [← hsame]
      exact div_self hnonzeroVarsigma
  by_cases hsameVarpi : varpi = varpi'
  · by_cases hsameVarsigma : varsigma = varsigma'
    · simp [hr.mpr hsameVarpi, ht.mpr hsameVarsigma, hsameVarpi, hsameVarsigma, pow_two]
    · simp [hr.mpr hsameVarpi, (not_congr ht).mpr hsameVarsigma,
        hsameVarpi, hsameVarsigma]
  · simp [(not_congr hr).mpr hsameVarpi, hsameVarpi]

end Ising2DLambda.KacWard
