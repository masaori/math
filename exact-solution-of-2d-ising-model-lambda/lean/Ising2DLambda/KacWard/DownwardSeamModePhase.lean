import Mathlib.Tactic
import Ising2DLambda.KacWard.TerminalMatrix
import Ising2DLambda.KacWard.TwistedModeWrapPhase

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial Ising2DLambda.AlgebraicEigenvalue

/-- `claim_downward_seam_mode_phase`: the actual forward vertical edge. -/
theorem downwardSeam_modePhase (L : ℕ) (hL : 1 ≤ L) (s : SpinStructure)
    (varpi varsigma : Qbar) (hvarsigma : varsigma ∈ verticalTwistedModes L s)
    (e : Edge L) (he : ¬ e.val < L ^ 2) :
    (twistSign s (e, false) : Qbar) *
      (varpi ^ (orientedTarget (e, false)).2.val *
        varsigma ^ (orientedTarget (e, false)).1.val) =
      varpi ^ (orientedSource (e, false)).2.val *
        varsigma ^ ((orientedSource (e, false)).1.val + 1) := by
  letI : NeZero L := ⟨by omega⟩
  have hrow : edgeRow L e < L := by
    have hidx : edgeIndex L e < L ^ 2 := by
      simp only [edgeIndex, if_neg he]
      have heval := e.isLt
      omega
    unfold edgeRow
    rw [Nat.div_lt_iff_lt_mul (by omega)]
    nlinarith
  have htarget : (((edgeRow L e : ZMod L) + 1).val) =
      (edgeRow L e + 1) % L := by
    convert ZMod.val_natCast L (edgeRow L e + 1) using 1 <;> push_cast <;> ring
  have hsource : ((edgeRow L e : ZMod L).val) = edgeRow L e :=
    ZMod.val_natCast_of_lt hrow
  have hmode : varsigma ^ L = if s.2 then -1 else 1 := hvarsigma
  by_cases hlast : edgeRow L e = L - 1
  · have htarget0 : (((edgeRow L e : ZMod L) + 1).val) = 0 := by
      rw [htarget, hlast, Nat.sub_add_cancel hL, Nat.mod_self]
    have hsign : (twistSign s (e, false) : Qbar) = varsigma ^ L := by
      cases hs : s.2 <;> simp [twistSign, horizontalSeamParity, verticalSeamParity,
        he, hlast, hs, hmode]
    simp only [orientedTarget, orientedSource, boundary0, boundary1, he,
      Bool.false_eq_true, ↓reduceIte, htarget0, hsource]
    simp only [hsign, pow_zero, mul_one, hlast, Nat.sub_add_cancel hL]
    exact mul_comm _ _
  · have htargetSucc : (((edgeRow L e : ZMod L) + 1).val) =
        edgeRow L e + 1 := by
      rw [htarget, Nat.mod_eq_of_lt (by omega)]
    have hsign : (twistSign s (e, false) : Qbar) = 1 := by
      simp [twistSign, horizontalSeamParity, verticalSeamParity, he, hlast]
    simp only [orientedTarget, orientedSource, boundary0, boundary1, he,
      Bool.false_eq_true, ↓reduceIte, htargetSucc, hsource]
    rw [hsign, one_mul]

end Ising2DLambda.KacWard
