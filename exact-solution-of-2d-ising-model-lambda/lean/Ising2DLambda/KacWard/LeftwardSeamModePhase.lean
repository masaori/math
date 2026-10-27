import Mathlib.Tactic
import Ising2DLambda.KacWard.TerminalMatrix
import Ising2DLambda.KacWard.TwistedModeWrapPhase

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial Ising2DLambda.AlgebraicEigenvalue

/-- `claim_leftward_seam_mode_phase`: the actual reverse horizontal edge. -/
theorem leftwardSeam_modePhase (L : ℕ) (hL : 1 ≤ L) (s : SpinStructure)
    (varpi varsigma : Qbar) (hvarpi : varpi ∈ horizontalTwistedModes L s)
    (e : Edge L) (he : e.val < L ^ 2) :
    (twistSign s (e, true) : Qbar) *
      (varpi ^ (orientedTarget (e, true)).2.val *
        varsigma ^ (orientedTarget (e, true)).1.val) =
      varpi⁻¹ * (varpi ^ (orientedSource (e, true)).2.val *
        varsigma ^ (orientedSource (e, true)).1.val) := by
  letI : NeZero L := ⟨by omega⟩
  have hcol : edgeColumn L e < L := by
    unfold edgeColumn
    exact Nat.mod_lt _ (by omega)
  have hsource : (((edgeColumn L e : ZMod L) + 1).val) =
      (edgeColumn L e + 1) % L := by
    convert ZMod.val_natCast L (edgeColumn L e + 1) using 1 <;> push_cast <;> ring
  have htarget : ((edgeColumn L e : ZMod L).val) = edgeColumn L e :=
    ZMod.val_natCast_of_lt hcol
  have hmode : varpi ^ L = if s.1 then -1 else 1 := hvarpi
  have hvarpi0 : varpi ≠ 0 := by
    intro h
    have hzero : (0 : Qbar) ^ L = if s.1 then -1 else 1 := by simpa [h] using hmode
    cases hs : s.1 <;> simp [hs, Nat.ne_of_gt hL] at hzero
  by_cases hlast : edgeColumn L e = L - 1
  · have hsource0 : (((edgeColumn L e : ZMod L) + 1).val) = 0 := by
      rw [hsource, hlast, Nat.sub_add_cancel hL, Nat.mod_self]
    have hsign : (twistSign s (e, true) : Qbar) = if s.1 then -1 else 1 := by
      cases hs : s.1 <;> simp [twistSign, horizontalSeamParity, verticalSeamParity,
        he, hlast, hs]
    have hphase : (if s.1 then (-1 : Qbar) else 1) * varpi ^ (L - 1) = varpi⁻¹ := by
      exact twistedMode_wrapPhase L hL (if s.1 then -1 else 1) varpi
        (by cases hs : s.1 <;> simp [hs]) hmode |>.2
    simp only [orientedTarget, orientedSource, boundary0, boundary1, he,
      Bool.true_eq_false, ↓reduceIte, htarget, hsource0]
    rw [hsign, hlast, ← mul_assoc, hphase]
    simp
  · have hsourceSucc : (((edgeColumn L e : ZMod L) + 1).val) =
        edgeColumn L e + 1 := by
      rw [hsource, Nat.mod_eq_of_lt (by omega)]
    have hsign : (twistSign s (e, true) : Qbar) = 1 := by
      simp [twistSign, horizontalSeamParity, verticalSeamParity, he, hlast]
    simp only [orientedTarget, orientedSource, boundary0, boundary1, he,
      Bool.true_eq_false, ↓reduceIte, htarget, hsourceSucc]
    rw [hsign, one_mul]
    rw [pow_succ]
    calc
      varpi ^ edgeColumn L e * varsigma ^ ((edgeRow L e : ZMod L).val) =
          (varpi⁻¹ * varpi) *
            (varpi ^ edgeColumn L e * varsigma ^ ((edgeRow L e : ZMod L).val)) := by
              simp [hvarpi0]
      _ = varpi⁻¹ *
          (varpi ^ edgeColumn L e * varpi *
            varsigma ^ ((edgeRow L e : ZMod L).val)) := by ring


end Ising2DLambda.KacWard
