/- `claim_twisted_fourier_right_inverse` の具体版。 -/
import Ising2DLambda.KacWard.TwistedModePowerSum
import Ising2DLambda.KacWard.EdgeModeIndexBijection
import Ising2DLambda.KacWard.DualTwistedFourierMatrix
import Mathlib

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open BigOperators

def modeIndexProductEquiv (L : ℕ) (s : SpinStructure) :
    {m // m ∈ fourierModeIndexSet L s} ≃
      {z : Qbar // z ∈ horizontalTwistedModes L s} ×
        {z : Qbar // z ∈ verticalTwistedModes L s} × ZMod 4 := by
  refine {
    toFun := fun m => (⟨m.val.1, m.property.1⟩, ⟨m.val.2.1, m.property.2⟩, m.val.2.2)
    invFun := fun m => ⟨(m.1.val, m.2.1.val, m.2.2), ⟨m.1.property, m.2.1.property⟩⟩
    left_inv := ?_
    right_inv := ?_
  }
  · intro m
    apply Subtype.ext
    rfl
  · intro m
    ext <;> rfl

private theorem twistedFourier_modeSum {L : ℕ} [NeZero L] (s : SpinStructure)
    (κ : OrientedEdge L ≃ {m // m ∈ fourierModeIndexSet L s})
    (e f : OrientedEdge L) :
    (∑ g : OrientedEdge L,
      endpointModeVector L (κ g).val.1 (κ g).val.2.1 (κ g).val.2.2 e *
      dualEndpointModeVector L (κ g).val.1 (κ g).val.2.1 (κ g).val.2.2 f) =
      if e = f then (L : Qbar) ^ 2 else 0 := by
  classical
  have hL : 1 ≤ L := Nat.pos_of_ne_zero (NeZero.ne L)
  let σa : Qbar := if s.1 then -1 else 1
  let σb : Qbar := if s.2 then -1 else 1
  have hσa : σa ≠ 0 := by cases h : s.1 <;> simp [σa, h]
  have hσb : σb ≠ 0 := by cases h : s.2 <;> simp [σb, h]
  obtain ⟨ξa, hξa⟩ := IsAlgClosed.exists_pow_nat_eq σa hL
  obtain ⟨ξb, hξb⟩ := IsAlgClosed.exists_pow_nat_eq σb hL
  letI : Fintype (RootOfUnity L) := (rootOfUnityFiniteCardLe L hL).1.fintype
  letI : Fintype {z : Qbar // z ^ L = σa} :=
    Fintype.ofEquiv (RootOfUnity L) (twistedModeRootEquiv hL hσa hξa)
  letI : Fintype {z : Qbar // z ^ L = σb} :=
    Fintype.ofEquiv (RootOfUnity L) (twistedModeRootEquiv hL hσb hξb)
  letI : Fintype {z : Qbar // z ∈ horizontalTwistedModes L s} :=
    Fintype.ofEquiv (RootOfUnity L) (twistedModeRootEquiv hL hσa hξa)
  letI : Fintype {z : Qbar // z ∈ verticalTwistedModes L s} :=
    Fintype.ofEquiv (RootOfUnity L) (twistedModeRootEquiv hL hσb hξb)
  letI : Fintype {m // m ∈ fourierModeIndexSet L s} :=
    Fintype.ofEquiv (OrientedEdge L) κ
  have hU (i j : ℕ) (hi : i < L) (hj : j < L) :
      (∑ z : {z : Qbar // z ∈ horizontalTwistedModes L s},
        z.1 ^ i * (z.1⁻¹) ^ j) = if i = j then (L : Qbar) else 0 := by
    change (∑ z : {z : Qbar // z ^ L = σa},
      z.1 ^ i * (z.1⁻¹) ^ j) = if i = j then (L : Qbar) else 0
    exact twistedMode_coordinateKernel hL hσa hξa i j hi hj
  have hW (i j : ℕ) (hi : i < L) (hj : j < L) :
      (∑ z : {z : Qbar // z ∈ verticalTwistedModes L s},
        z.1 ^ i * (z.1⁻¹) ^ j) = if i = j then (L : Qbar) else 0 := by
    change (∑ z : {z : Qbar // z ^ L = σb},
      z.1 ^ i * (z.1⁻¹) ^ j) = if i = j then (L : Qbar) else 0
    exact twistedMode_coordinateKernel hL hσb hξb i j hi hj
  let p := modeIndexProductEquiv L s
  calc
    (∑ g : OrientedEdge L,
      endpointModeVector L (κ g).val.1 (κ g).val.2.1 (κ g).val.2.2 e *
      dualEndpointModeVector L (κ g).val.1 (κ g).val.2.1 (κ g).val.2.2 f)
        = ∑ m : {m // m ∈ fourierModeIndexSet L s},
          endpointModeVector L m.val.1 m.val.2.1 m.val.2.2 e *
          dualEndpointModeVector L m.val.1 m.val.2.1 m.val.2.2 f := by
            exact Fintype.sum_equiv κ _ _ (fun _ => rfl)
    _ = ∑ m : {z : Qbar // z ∈ horizontalTwistedModes L s} ×
          {z : Qbar // z ∈ verticalTwistedModes L s} × ZMod 4,
          endpointModeVector L m.1.val m.2.1.val m.2.2 e *
          dualEndpointModeVector L m.1.val m.2.1.val m.2.2 f := by
            exact Fintype.sum_equiv p _ _ (fun _ => rfl)
    _ = if e = f then (L : Qbar) ^ 2 else 0 := by
          simp only [Fintype.sum_prod_type]
          by_cases hd : directionNumber e = directionNumber f
          · simp [endpointModeVector, dualEndpointModeVector, hd]
            have hfactor :
                (∑ u : {z : Qbar // z ∈ horizontalTwistedModes L s},
                  ∑ w : {z : Qbar // z ∈ verticalTwistedModes L s},
                    u.1 ^ (orientedTarget e).2.val * w.1 ^ (orientedTarget e).1.val *
                      ((u.1 ^ (orientedTarget f).2.val)⁻¹ *
                        (w.1 ^ (orientedTarget f).1.val)⁻¹)) =
                (∑ u : {z : Qbar // z ∈ horizontalTwistedModes L s},
                  u.1 ^ (orientedTarget e).2.val *
                    (u.1⁻¹) ^ (orientedTarget f).2.val) *
                (∑ w : {z : Qbar // z ∈ verticalTwistedModes L s},
                  w.1 ^ (orientedTarget e).1.val *
                    (w.1⁻¹) ^ (orientedTarget f).1.val) := by
              rw [Finset.sum_mul_sum]
              apply Finset.sum_congr rfl
              intro u _
              apply Finset.sum_congr rfl
              intro w _
              rw [inv_pow, inv_pow]
              ring
            rw [hfactor]
            have hje : (orientedTarget e).2.val < L := ZMod.val_lt _
            have hjf : (orientedTarget f).2.val < L := ZMod.val_lt _
            have hie : (orientedTarget e).1.val < L := ZMod.val_lt _
            have hif : (orientedTarget f).1.val < L := ZMod.val_lt _
            rw [hU _ _ hje hjf, hW _ _ hie hif]
            by_cases hef : e = f
            · subst f
              simp [pow_two]
            · have hcoord : (orientedTarget e).2.val ≠ (orientedTarget f).2.val ∨
                    (orientedTarget e).1.val ≠ (orientedTarget f).1.val := by
                by_contra h
                push Not at h
                apply hef
                apply targetDirection_bijective.1
                apply Prod.ext
                · apply Prod.ext
                  · exact ZMod.val_injective L h.2
                  · exact ZMod.val_injective L h.1
                · exact hd
              rcases hcoord with h | h <;> simp [hef, h]
          · simp [endpointModeVector, dualEndpointModeVector, hd]
            intro hef
            exact (hd (congrArg directionNumber hef)).elim

theorem twistedFourier_rightInverse {L : ℕ} [NeZero L] (s : SpinStructure)
    (κ : OrientedEdge L ≃ {m // m ∈ fourierModeIndexSet L s}) :
    twistedFourierMatrix s κ * twistedFourierInverseCandidate s κ = 1 := by
  classical
  apply Matrix.ext
  intro e f
  have hL : (L : Qbar) ≠ 0 := by exact_mod_cast (NeZero.ne L)
  rw [Matrix.one_apply]
  simp only [Matrix.mul_apply, twistedFourierMatrix,
    twistedFourierInverseCandidate, dualTwistedFourierMatrix,
    Matrix.smul_apply, smul_eq_mul]
  calc
    (∑ g : OrientedEdge L,
      endpointModeVector L (κ g).val.1 (κ g).val.2.1 (κ g).val.2.2 e *
      ((L : Qbar)⁻¹ ^ 2 *
        dualEndpointModeVector L (κ g).val.1 (κ g).val.2.1 (κ g).val.2.2 f))
        = (L : Qbar)⁻¹ ^ 2 *
            (∑ g : OrientedEdge L,
              endpointModeVector L (κ g).val.1 (κ g).val.2.1 (κ g).val.2.2 e *
              dualEndpointModeVector L (κ g).val.1 (κ g).val.2.1 (κ g).val.2.2 f) := by
            rw [Finset.mul_sum]
            apply Finset.sum_congr rfl
            intro g _
            ring
    _ = (L : Qbar)⁻¹ ^ 2 * (if e = f then (L : Qbar) ^ 2 else 0) := by
      rw [twistedFourier_modeSum s κ e f]
    _ = if e = f then 1 else 0 := by
      by_cases hef : e = f <;> simp [hef, hL]

end Ising2DLambda.KacWard
