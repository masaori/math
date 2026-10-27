import Mathlib.Tactic
import Ising2DLambda.KacWard.TerminalMatrix
import Ising2DLambda.KacWard.TwistedModeWrapPhase

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial Ising2DLambda.AlgebraicEigenvalue

/-- `claim_rightward_seam_mode_phase`: the actual forward horizontal edge. -/
theorem rightwardSeam_modePhase (L : ℕ) (hL : 1 ≤ L) (s : SpinStructure)
    (varpi varsigma : Qbar) (hvarpi : varpi ∈ horizontalTwistedModes L s)
    (e : Edge L) (he : e.val < L ^ 2) :
    (twistSign s (e, false) : Qbar) *
      (varpi ^ (orientedTarget (e, false)).2.val *
        varsigma ^ (orientedTarget (e, false)).1.val) =
      varpi ^ ((orientedSource (e, false)).2.val + 1) *
        varsigma ^ (orientedSource (e, false)).1.val := by
  letI : NeZero L := ⟨by omega⟩
  have hcol : edgeColumn L e < L := by
    unfold edgeColumn
    exact Nat.mod_lt _ (by omega)
  have htarget : (((edgeColumn L e : ZMod L) + 1).val) =
      (edgeColumn L e + 1) % L := by
    convert ZMod.val_natCast L (edgeColumn L e + 1) using 1 <;> push_cast <;> ring
  have hsource : ((edgeColumn L e : ZMod L).val) = edgeColumn L e :=
    ZMod.val_natCast_of_lt hcol
  have hmode : varpi ^ L = if s.1 then -1 else 1 := hvarpi
  by_cases hlast : edgeColumn L e = L - 1
  · have htarget0 : (((edgeColumn L e : ZMod L) + 1).val) = 0 := by
      rw [htarget, hlast, Nat.sub_add_cancel hL, Nat.mod_self]
    have hsign : (twistSign s (e, false) : Qbar) = varpi ^ L := by
      cases hs : s.1 <;> simp [twistSign, horizontalSeamParity, verticalSeamParity,
        he, hlast, hs, hmode]
    simp only [orientedTarget, orientedSource, boundary0, boundary1, he,
      Bool.false_eq_true, ↓reduceIte, htarget0, hsource]
    simp only [hsign, pow_zero, one_mul, hlast, Nat.sub_add_cancel hL]
  · have htargetSucc : (((edgeColumn L e : ZMod L) + 1).val) =
        edgeColumn L e + 1 := by
      rw [htarget, Nat.mod_eq_of_lt (by omega)]
    have hsign : (twistSign s (e, false) : Qbar) = 1 := by
      simp [twistSign, horizontalSeamParity, verticalSeamParity, he, hlast]
    simp only [orientedTarget, orientedSource, boundary0, boundary1, he,
      Bool.false_eq_true, ↓reduceIte, htargetSucc, hsource]
    rw [hsign, one_mul]

end Ising2DLambda.KacWard
