import Mathlib.Tactic
import Ising2DLambda.KacWard.TerminalMatrix
import Ising2DLambda.KacWard.TwistedModeWrapPhase

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial Ising2DLambda.AlgebraicEigenvalue

/-- `claim_upward_seam_mode_phase`: the actual reverse vertical edge. -/
theorem upwardSeam_modePhase (L : ℕ) (hL : 1 ≤ L) (s : SpinStructure)
    (varpi varsigma : Qbar) (hvarsigma : varsigma ∈ verticalTwistedModes L s)
    (e : Edge L) (he : ¬ e.val < L ^ 2) :
    (twistSign s (e, true) : Qbar) *
      (varpi ^ (orientedTarget (e, true)).2.val *
        varsigma ^ (orientedTarget (e, true)).1.val) =
      varsigma⁻¹ * (varpi ^ (orientedSource (e, true)).2.val *
        varsigma ^ (orientedSource (e, true)).1.val) := by
  letI : NeZero L := ⟨by omega⟩
  have hrow : edgeRow L e < L := by
    have hidx : edgeIndex L e < L ^ 2 := by
      simp only [edgeIndex, if_neg he]
      have heval := e.isLt
      omega
    unfold edgeRow
    rw [Nat.div_lt_iff_lt_mul (by omega)]
    nlinarith
  have hsource : (((edgeRow L e : ZMod L) + 1).val) =
      (edgeRow L e + 1) % L := by
    convert ZMod.val_natCast L (edgeRow L e + 1) using 1 <;> push_cast <;> ring
  have htarget : ((edgeRow L e : ZMod L).val) = edgeRow L e :=
    ZMod.val_natCast_of_lt hrow
  have hmode : varsigma ^ L = if s.2 then -1 else 1 := hvarsigma
  have hvarsigma0 : varsigma ≠ 0 := by
    intro h
    have hzero : (0 : Qbar) ^ L = if s.2 then -1 else 1 := by simpa [h] using hmode
    cases hs : s.2 <;> simp [hs, Nat.ne_of_gt hL] at hzero
  by_cases hlast : edgeRow L e = L - 1
  · have hsource0 : (((edgeRow L e : ZMod L) + 1).val) = 0 := by
      rw [hsource, hlast, Nat.sub_add_cancel hL, Nat.mod_self]
    have hsign : (twistSign s (e, true) : Qbar) = if s.2 then -1 else 1 := by
      cases hs : s.2 <;> simp [twistSign, horizontalSeamParity, verticalSeamParity,
        he, hlast, hs]
    have hphase : (if s.2 then (-1 : Qbar) else 1) * varsigma ^ (L - 1) =
        varsigma⁻¹ := by
      exact twistedMode_wrapPhase L hL (if s.2 then -1 else 1) varsigma
        (by cases hs : s.2 <;> simp [hs]) hmode |>.2
    simp only [orientedTarget, orientedSource, boundary0, boundary1, he,
      Bool.true_eq_false, ↓reduceIte, htarget, hsource0]
    rw [hsign, hlast, pow_zero, mul_one]
    calc
      (if s.2 then (-1 : Qbar) else 1) *
          (varpi ^ (edgeColumn L e : ZMod L).val * varsigma ^ (L - 1)) =
          varpi ^ (edgeColumn L e : ZMod L).val *
            ((if s.2 then (-1 : Qbar) else 1) * varsigma ^ (L - 1)) := by ring
      _ = varpi ^ (edgeColumn L e : ZMod L).val * varsigma⁻¹ := by rw [hphase]
      _ = varsigma⁻¹ * varpi ^ (edgeColumn L e : ZMod L).val := by ring
  · have hsourceSucc : (((edgeRow L e : ZMod L) + 1).val) =
        edgeRow L e + 1 := by
      rw [hsource, Nat.mod_eq_of_lt (by omega)]
    have hsign : (twistSign s (e, true) : Qbar) = 1 := by
      simp [twistSign, horizontalSeamParity, verticalSeamParity, he, hlast]
    simp only [orientedTarget, orientedSource, boundary0, boundary1, he,
      Bool.true_eq_false, ↓reduceIte, htarget, hsourceSucc]
    rw [hsign, one_mul, pow_succ]
    calc
      varpi ^ (edgeColumn L e : ZMod L).val * varsigma ^ edgeRow L e =
          (varsigma⁻¹ * varsigma) *
            (varpi ^ (edgeColumn L e : ZMod L).val * varsigma ^ edgeRow L e) := by
              simp [hvarsigma0]
      _ = varsigma⁻¹ *
          (varpi ^ (edgeColumn L e : ZMod L).val *
            (varsigma ^ edgeRow L e * varsigma)) := by ring

end Ising2DLambda.KacWard
