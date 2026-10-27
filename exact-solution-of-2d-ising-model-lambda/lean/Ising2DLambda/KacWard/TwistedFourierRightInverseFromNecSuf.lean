/- `claim_twisted_fourier_right_inverse` の具体版を必要十分版から導く。 -/
import Ising2DLambda.KacWard.TwistedFourierRightInverse
import Ising2DLambda.NecSuf.KacWard.TwistedFourierRightInverse
import Mathlib

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.NecSuf.KacWard

theorem twistedFourier_rightInverse_from_necSuf {L : ℕ} [NeZero L]
    (s : SpinStructure)
    (κ : OrientedEdge L ≃ {m // m ∈ fourierModeIndexSet L s}) :
    twistedFourierMatrix s κ * twistedFourierInverseCandidate s κ = 1 := by
  classical
  have hL : 1 ≤ L := Nat.pos_of_ne_zero (NeZero.ne L)
  have hLq : (L : Qbar) ≠ 0 := by exact_mod_cast (NeZero.ne L)
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
  let p := modeIndexProductEquiv L s
  let κ' := κ.trans p
  let ψ (m : {z : Qbar // z ∈ horizontalTwistedModes L s} ×
      {z : Qbar // z ∈ verticalTwistedModes L s} × ZMod 4)
      (e : OrientedEdge L) := endpointModeVector L m.1.val m.2.1.val m.2.2 e
  let ψbar (m : {z : Qbar // z ∈ horizontalTwistedModes L s} ×
      {z : Qbar // z ∈ verticalTwistedModes L s} × ZMod 4)
      (e : OrientedEdge L) := dualEndpointModeVector L m.1.val m.2.1.val m.2.2 e
  have hU : ∀ y y' : ZMod L,
      (∑ u : {z : Qbar // z ∈ horizontalTwistedModes L s},
        u.1 ^ y.val * (u.1⁻¹) ^ y'.val) =
        if y = y' then (L : Qbar) else 0 := by
    intro y y'
    have h := twistedMode_coordinateKernel hL hσa hξa y.val y'.val
      (ZMod.val_lt y) (ZMod.val_lt y')
    have heq : y.val = y'.val ↔ y = y' := by
      constructor
      · intro h
        exact ZMod.val_injective L h
      · intro hyy
        rw [hyy]
    change (∑ z : {z : Qbar // z ^ L = σa},
      z.1 ^ y.val * (z.1⁻¹) ^ y'.val) =
        if y = y' then (L : Qbar) else 0
    simpa only [heq] using h
  have hV : ∀ x x' : ZMod L,
      (∑ v : {z : Qbar // z ∈ verticalTwistedModes L s},
        v.1 ^ x.val * (v.1⁻¹) ^ x'.val) =
        if x = x' then (L : Qbar) else 0 := by
    intro x x'
    have h := twistedMode_coordinateKernel hL hσb hξb x.val x'.val
      (ZMod.val_lt x) (ZMod.val_lt x')
    have heq : x.val = x'.val ↔ x = x' := by
      constructor
      · intro h
        exact ZMod.val_injective L h
      · intro hxx
        rw [hxx]
    change (∑ z : {z : Qbar // z ^ L = σb},
      z.1 ^ x.val * (z.1⁻¹) ^ x'.val) =
        if x = x' then (L : Qbar) else 0
    simpa only [heq] using h
  have hgen := fourier_rightInverse_necSuf κ' orientedTarget directionNumber
    targetDirection_bijective.1
    (fun u y => u.1 ^ y.val) (fun u y => (u.1⁻¹) ^ y.val)
    (fun v x => v.1 ^ x.val) (fun v x => (v.1⁻¹) ^ x.val)
    ψ ψbar (by intro m e; rfl) (by intro m e; rfl)
    (L : Qbar) (L : Qbar) (mul_ne_zero hLq hLq) hU hV
  have hF : fourierMatrix κ' ψ = twistedFourierMatrix s κ := by
    ext e g
    rfl
  have hG : fourierInverseCandidate ((L : Qbar) * (L : Qbar))⁻¹ κ' ψbar =
      twistedFourierInverseCandidate s κ := by
    have hscale : ((L : Qbar) * (L : Qbar))⁻¹ = (L : Qbar)⁻¹ ^ 2 := by
      rw [← pow_two, inv_pow]
    rw [hscale]
    ext g e
    rfl
  rw [hF, hG] at hgen
  exact hgen

end Ising2DLambda.KacWard
