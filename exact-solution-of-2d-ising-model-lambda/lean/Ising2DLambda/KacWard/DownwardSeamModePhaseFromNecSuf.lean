import Ising2DLambda.KacWard.DownwardSeamModePhase
import Ising2DLambda.NecSuf.KacWard.DownwardSeamModePhase

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial Ising2DLambda.AlgebraicEigenvalue

/-- The concrete vertical seam is the period-residue calculation. -/
theorem downwardSeam_modePhase_from_necSuf (L : ℕ) (hL : 1 ≤ L)
    (s : SpinStructure) (varpi varsigma : Qbar)
    (hvarsigma : varsigma ∈ verticalTwistedModes L s)
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
  let σ : Qbar := if s.2 then -1 else 1
  have hz : varsigma ^ L = σ := hvarsigma
  have hsign : (twistSign s (e, false) : Qbar) =
      if edgeRow L e = L - 1 then σ else 1 := by
    by_cases hlast : edgeRow L e = L - 1
    · cases hs : s.2 <;> simp [twistSign, horizontalSeamParity,
        verticalSeamParity, he, hlast, σ, hs]
    · simp [twistSign, horizontalSeamParity, verticalSeamParity, he, hlast]
  have htarget : (((edgeRow L e : ZMod L) + 1).val) =
      (edgeRow L e + 1) % L := by
    convert ZMod.val_natCast L (edgeRow L e + 1) using 1 <;> push_cast <;> ring
  have hsource : ((edgeRow L e : ZMod L).val) = edgeRow L e :=
    ZMod.val_natCast_of_lt hrow
  simp only [orientedTarget, orientedSource, boundary0, boundary1, he,
    Bool.false_eq_true, ↓reduceIte, htarget, hsource]
  rw [hsign]
  have hmain := Ising2DLambda.NecSuf.KacWard.downwardSeam_modePhase_necSuf
    L (edgeRow L e) hL hrow σ varsigma hz
  rw [mul_comm (varpi ^ _), ← mul_assoc, hmain]
  exact mul_comm _ _

end Ising2DLambda.KacWard
